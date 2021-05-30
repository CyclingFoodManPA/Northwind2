
/*****************************************************************************
 *        Class Name: HolidayDescriptionRepository
 *  Class Decription: Contains data repository functionality for HolidayDescription
 *     Inherits From: RepositoryBase
 *              Date: Friday, July 8, 2016
 *            Author: ksafford
 *             
 *  http:// articles.runtings.co.uk/2010/04/solved-located-assemblys-manifest.html
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using Northwind2.Common.Classes;
using Northwind2.Common.Infrastructure;
using Northwind2.Entities.Models;
using Northwind2.Repositories.Contracts;

namespace Northwind2.Repositories.Implementation
{
    public sealed class HolidayDescriptionRepository : RepositoryBase<HolidayDescription>, IHolidayDescriptionRepository
    {
        #region Private Member Variables

        // Private Member Variables
        private const string THIS_CLASS = "HolidayDescriptionRepository";

        #endregion Private Member Variables

        #region Public Constructor
        // Public Constructor
        public HolidayDescriptionRepository(IUnitOfWork unitOfWork)
            : base(unitOfWork)
        {
            // Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int HolidayDescriptionAdd(HolidayDescription holidayDescription, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayDescriptionAdd; HolidayDescriptionName= " + holidayDescription.HolidayDescriptionName.Trim());

            try
            {
                holidayDescription.HolidayDescriptionID = 0;
                holidayDescription.AddedDate = DateTime.Now;
                holidayDescription.ModifiedDate = DateTime.Now;
                this.Add(holidayDescription);

                this.CommitAllChanges();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                holidayDescription.HolidayDescriptionID = -1;
                _log.Error(THIS_CLASS + ": HolidayDescriptionAdd; HolidayDescriptionName= " + holidayDescription.HolidayDescriptionName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return holidayDescription.HolidayDescriptionID;
        }

        // Read
        public IList<HolidayDescription> HolidayDescriptionGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayDescriptionGetAll");
            IList<HolidayDescription> list = null;
            int totCount = 0;

            try
            {
                IQueryable<HolidayDescription> query = (from x in this.UnitOfWork.Context.HolidayDescriptions
                                             select x);

                // Add predicate for dynamic search
                var predicate = PredicateBuilder.True<HolidayDescription>();
                if (searchText != null && searchText.Length > 0)
                {
                    predicate = predicate.And(p => p.HolidayDescriptionName.ToLower().Contains(searchText.ToLower()));
                }

                query = query.Where(predicate);

                list = GenericSorterPager.GetSortedPagedList<HolidayDescription>(query, paging, out totalCount);
                totCount = totalCount;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": HolidayDescriptionGetAll" + " ErrorMessage: " + message.Trim());
            }

            // Had to do this asignment as after I put the try {} catch(() block in, code was looking
            // for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItem> HolidayDescriptionGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayDescriptionGetAllList");
            List<ListItem> list = null;

            try
            {
                list = (from x in this.UnitOfWork.Context.HolidayDescriptions
                        orderby x.HolidayDescriptionName
                        select new ListItem
                        {
                            ID = x.HolidayDescriptionID,
                            Name = x.HolidayDescriptionName
                        }).ToList();
                totalCount = list.Count();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": HolidayDescriptionGetAllList;" + " ErrorMessage: " + message.Trim());
                totalCount = 0;
            }

            return list;
        }

        public HolidayDescription HolidayDescriptionGetByID(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayDescriptionGetByID; HolidayDescriptionID= " + id.ToString());
            HolidayDescription x = null;

            try
            {
                x = this.GetByID(id);

                if (x != null)
                {
                    IQueryable<Holiday> holidays = this.UnitOfWork.Context.Holidays.Where(y => y.HolidayDescriptionID == id);
                    x.Holidays = holidays.ToList();
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": HolidayDescriptionGetByID; HolidayDescriptionID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return x;
        }

        // Update
        public bool HolidayDescriptionUpdate(HolidayDescription holidayDescription, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayDescriptionUpdate; HolidayDescriptionID= " + holidayDescription.HolidayDescriptionID.ToString());
            bool isUpdateSuccessful = false;

            try
            {
                // Get holidayDescription to be updated
                HolidayDescription updateEntity = this.GetByID(holidayDescription.HolidayDescriptionID);

                if (updateEntity != null)
                {
                    if (TimeStampExtensions.Matches(updateEntity.Modified, holidayDescription.Modified))
                    {
                        // Update columns
                        this.UnitOfWork.Context.Entry(updateEntity).CurrentValues.SetValues(holidayDescription);
                        updateEntity.ModifiedDate = DateTime.Now;

                        // Commit the updates
                        this.CommitAllChanges();
                        isUpdateSuccessful = true;
                    }
                    else
                    {
                        message = "The record you attempted to edit was modified by another user after you got the original value. The edit operation was canceled!";
                        _log.Debug(THIS_CLASS + ": HolidayDescriptionUpdate; HolidayDescriptionID= " + holidayDescription.HolidayDescriptionID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                    }
                }
                else
                {
                    message = "The record you attempted to edit was deleted by another user after you got the original value. The edit operation cannot be completed!";
                    _log.Debug(THIS_CLASS + ": HolidayDescriptionUpdate; HolidayDescriptionID= " + holidayDescription.HolidayDescriptionID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": HolidayDescriptionUpdate; HolidayDescriptionID= " + holidayDescription.HolidayDescriptionID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool HolidayDescriptionDelete(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayDescriptionDelete; HolidayDescriptionID= " + id.ToString());
            bool isDeleteSuccessful = false;

            try
            {
                this.Delete(id);
                this.CommitAllChanges();
                isDeleteSuccessful = true;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": HolidayDescriptionDelete; HolidayDescriptionID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations
    }
}
