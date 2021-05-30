
/*****************************************************************************
 *        Class Name: TitleRepository
 *  Class Decription: Contains data repository functionality for Title
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
    public sealed class TitleRepository : RepositoryBase<Title>, ITitleRepository
    {
        #region Private Member Variables

        // Private Member Variables
        private const string THIS_CLASS = "TitleRepository";

        #endregion Private Member Variables

        #region Public Constructor
        // Public Constructor
        public TitleRepository(IUnitOfWork unitOfWork)
            : base(unitOfWork)
        {
            // Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int TitleAdd(Title region, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleAdd; TitleName= " + region.TitleName.Trim());

            try
            {
                region.TitleID = 0;
                region.AddedDate = DateTime.Now;
                region.ModifiedDate = DateTime.Now;
                this.Add(region);

                this.CommitAllChanges();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                region.TitleID = -1;
                _log.Error(THIS_CLASS + ": TitleAdd; TitleName= " + region.TitleName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return region.TitleID;
        }

        // Read
        public IList<Title> TitleGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleGetAll");
            IList<Title> list = null;
            int totCount = 0;

            try
            {
                IQueryable<Title> query = (from x in this.UnitOfWork.Context.Titles
                                            select x);

                // Add predicate for dynamic search
                var predicate = PredicateBuilder.True<Title>();
                if (searchText != null && searchText.Length > 0)
                {
                    predicate = predicate.And(p => p.TitleName.ToLower().Contains(searchText.ToLower()));
                }

                query = query.Where(predicate);

                list = GenericSorterPager.GetSortedPagedList<Title>(query, paging, out totalCount);
                totCount = totalCount;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": TitleGetAll" + " ErrorMessage: " + message.Trim());
            }

            // Had to do this asignment as after I put the try {} catch(() block in, code was looking
            // for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItem> TitleGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleGetAllList");
            List<ListItem> list = null;

            try
            {
                list = (from x in this.UnitOfWork.Context.Titles
                        orderby x.TitleName
                        select new ListItem
                        {
                            ID = x.TitleID,
                            Name = x.TitleName
                        }).ToList();
                totalCount = list.Count();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": TitleGetAllList;" + " ErrorMessage: " + message.Trim());
                totalCount = 0;
            }

            return list;
        }

        public Title TitleGetByID(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleGetByID; TitleID= " + id.ToString());
            Title x = null;

            try
            {
                x = this.GetByID(id);

                if (x != null)
                {
                    IQueryable<Employee> employees = this.UnitOfWork.Context.Employees.Where(y => y.TitleID == id);
                    x.Employees = employees.ToList();
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": TitleGetByID; TitleID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return x;
        }

        // Update
        public bool TitleUpdate(Title title, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleUpdate; TitleID= " + title.TitleID.ToString());
            bool isUpdateSuccessful = false;

            try
            {
                // Get title to be updated
                Title updateEntity = this.GetByID(title.TitleID);

                if (updateEntity != null)
                {
                    if (TimeStampExtensions.Matches(updateEntity.Modified, title.Modified))
                    {
                        // Update columns
                        this.UnitOfWork.Context.Entry(updateEntity).CurrentValues.SetValues(title);
                        updateEntity.ModifiedDate = DateTime.Now;

                        // Commit the updates
                        this.CommitAllChanges();
                        isUpdateSuccessful = true;
                    }
                    else
                    {
                        message = "The record you attempted to edit was modified by another user after you got the original value. The edit operation was canceled!";
                        _log.Debug(THIS_CLASS + ": TitleUpdate; TitleID= " + title.TitleID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                    }
                }
                else
                {
                    message = "The record you attempted to edit was deleted by another user after you got the original value. The edit operation cannot be completed!";
                    _log.Debug(THIS_CLASS + ": TitleUpdate; TitleID= " + title.TitleID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": TitleUpdate; TitleID= " + title.TitleID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool TitleDelete(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": TitleDelete; TitleID= " + id.ToString());
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
                _log.Error(THIS_CLASS + ": TitleDelete; TitleID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations
    }
}
