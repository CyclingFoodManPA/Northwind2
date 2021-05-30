
/*****************************************************************************
 *        Class Name: TitleOfCourtesyRepository
 *  Class Decription: Contains data repository functionality for TitleOfCourtesy
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
    public sealed class TitleOfCourtesyRepository : RepositoryBase<TitleOfCourtesy>, ITitleOfCourtesyRepository
    {
        #region Private Member Variables

        // Private Member Variables
        private const string THIS_CLASS = "TitleOfCourtesyRepository";

        #endregion Private Member Variables

        #region Public Constructor
        // Public Constructor
        public TitleOfCourtesyRepository(IUnitOfWork unitOfWork)
            : base(unitOfWork)
        {
            // Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int TitleOfCourtesyAdd(TitleOfCourtesy region, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleOfCourtesyAdd; TitleOfCourtesyName= " + region.TitleOfCourtesyName.Trim());

            try
            {
                region.TitleOfCourtesyID = 0;
                region.AddedDate = DateTime.Now;
                region.ModifiedDate = DateTime.Now;
                this.Add(region);

                this.CommitAllChanges();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                region.TitleOfCourtesyID = -1;
                _log.Error(THIS_CLASS + ": TitleOfCourtesyAdd; TitleOfCourtesyName= " + region.TitleOfCourtesyName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return region.TitleOfCourtesyID;
        }

        // Read
        public IList<TitleOfCourtesy> TitleOfCourtesyGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleOfCourtesyGetAll");
            IList<TitleOfCourtesy> list = null;
            int totCount = 0;

            try
            {
                IQueryable<TitleOfCourtesy> query = (from x in this.UnitOfWork.Context.TitleOfCourtesies
                                                     select x);

                // Add predicate for dynamic search
                var predicate = PredicateBuilder.True<TitleOfCourtesy>();
                if (searchText != null && searchText.Length > 0)
                {
                    predicate = predicate.And(p => p.TitleOfCourtesyName.ToLower().Contains(searchText.ToLower()));
                }

                query = query.Where(predicate);

                list = GenericSorterPager.GetSortedPagedList<TitleOfCourtesy>(query, paging, out totalCount);
                totCount = totalCount;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": TitleOfCourtesyGetAll" + " ErrorMessage: " + message.Trim());
            }

            // Had to do this asignment as after I put the try {} catch(() block in, code was looking
            // for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItem> TitleOfCourtesyGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleOfCourtesyGetAllList");
            List<ListItem> list = null;

            try
            {
                list = (from x in this.UnitOfWork.Context.TitleOfCourtesies
                        orderby x.TitleOfCourtesyName
                        select new ListItem
                        {
                            ID = x.TitleOfCourtesyID,
                            Name = x.TitleOfCourtesyName
                        }).ToList();
                totalCount = list.Count();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": TitleOfCourtesyGetAllList;" + " ErrorMessage: " + message.Trim());
                totalCount = 0;
            }

            return list;
        }

        public TitleOfCourtesy TitleOfCourtesyGetByID(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleOfCourtesyGetByID; TitleOfCourtesyID= " + id.ToString());
            TitleOfCourtesy x = null;

            try
            {
                x = this.GetByID(id);

                if (x != null)
                {
                    IQueryable<Employee> employees = this.UnitOfWork.Context.Employees.Where(y => y.TitleOfCourtesyID == id);
                    x.Employees = employees.ToList();
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": TitleOfCourtesyGetByID; TitleOfCourtesyID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return x;
        }

        // Update
        public bool TitleOfCourtesyUpdate(TitleOfCourtesy titleOfCourtesy, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleOfCourtesyUpdate; TitleOfCourtesyID= " + titleOfCourtesy.TitleOfCourtesyID.ToString());
            bool isUpdateSuccessful = false;

            try
            {
                // Get titleOfCourtesy to be updated
                TitleOfCourtesy updateEntity = this.GetByID(titleOfCourtesy.TitleOfCourtesyID);

                if (updateEntity != null)
                {
                    if (TimeStampExtensions.Matches(updateEntity.Modified, titleOfCourtesy.Modified))
                    {
                        // Update columns
                        this.UnitOfWork.Context.Entry(updateEntity).CurrentValues.SetValues(titleOfCourtesy);
                        updateEntity.ModifiedDate = DateTime.Now;

                        // Commit the updates
                        this.CommitAllChanges();
                        isUpdateSuccessful = true;
                    }
                    else
                    {
                        message = "The record you attempted to edit was modified by another user after you got the original value. The edit operation was canceled!";
                        _log.Debug(THIS_CLASS + ": TitleOfCourtesyUpdate; TitleOfCourtesyID= " + titleOfCourtesy.TitleOfCourtesyID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                    }
                }
                else
                {
                    message = "The record you attempted to edit was deleted by another user after you got the original value. The edit operation cannot be completed!";
                    _log.Debug(THIS_CLASS + ": TitleOfCourtesyUpdate; TitleOfCourtesyID= " + titleOfCourtesy.TitleOfCourtesyID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": TitleOfCourtesyUpdate; TitleOfCourtesyID= " + titleOfCourtesy.TitleOfCourtesyID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool TitleOfCourtesyDelete(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleOfCourtesyDelete; TitleOfCourtesyID= " + id.ToString());
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
                _log.Error(THIS_CLASS + ": TitleOfCourtesyDelete; TitleOfCourtesyID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations
    }
}
