
/*****************************************************************************
 *        Class Name: ContactTitleRepository
 *  Class Decription: Contains data repository functionality for ContactTitle
 *     Inherits From: RepositoryBase
 *              Date: Friday, July 1, 2016
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
    public sealed class ContactTitleRepository : RepositoryBase<ContactTitle>, IContactTitleRepository
    {
        #region Private Member Variables

        // Private Member Variables
        private const string THIS_CLASS = "ContactTitleRepository";

        #endregion Private Member Variables

        #region Public Constructor
        // Public Constructor
        public ContactTitleRepository(IUnitOfWork unitOfWork)
            : base(unitOfWork)
        {
            // Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int ContactTitleAdd(ContactTitle contactTitle, ref string message)
        {
            _log.Info(THIS_CLASS + ": ContactTitleAdd; ContactTitleName= " + contactTitle.ContactTitleName.Trim());

            try
            {
                contactTitle.ContactTitleID = 0;
                contactTitle.AddedDate = DateTime.Now;
                contactTitle.ModifiedDate = DateTime.Now;
                this.Add(contactTitle);

                this.CommitAllChanges();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                contactTitle.ContactTitleID = -1;
                _log.Error(THIS_CLASS + ": ContactTitleAdd; ContactTitleName= " + contactTitle.ContactTitleName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return contactTitle.ContactTitleID;
        }

        // Read
        public IList<ContactTitle> ContactTitleGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": ContactTitleGetAll");
            IList<ContactTitle> list = null;
            int totCount = 0;

            try
            {
                IQueryable<ContactTitle> query = (from x in this.UnitOfWork.Context.ContactTitles
                                                  select x);

                // Add predicate for dynamic search
                var predicate = PredicateBuilder.True<ContactTitle>();
                if (searchText != null && searchText.Length > 0)
                {
                    predicate = predicate.And(p => p.ContactTitleName.ToLower().Contains(searchText.ToLower()));
                }

                query = query.Where(predicate);

                list = GenericSorterPager.GetSortedPagedList<ContactTitle>(query, paging, out totalCount);
                totCount = totalCount;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": ContactTitleGetAll" + " ErrorMessage: " + message.Trim());
            }

            // Had to do this asignment as after I put the try {} catch(() block in, code was looking
            // for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItem> ContactTitleGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": ContactTitleGetAllList");
            List<ListItem> list = null;

            try
            {
                list = (from x in this.UnitOfWork.Context.ContactTitles
                        orderby x.ContactTitleName
                        select new ListItem
                        {
                            ID = x.ContactTitleID,
                            Name = x.ContactTitleName
                        }).ToList();
                totalCount = list.Count();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": ContactTitleGetAllList;" + " ErrorMessage: " + message.Trim());
                totalCount = 0;
            }

            return list;
        }

        public ContactTitle ContactTitleGetByID(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": ContactTitleGetByID; ContactTitleID= " + id.ToString());
            ContactTitle x = null;

            try
            {
                x = this.GetByID(id);

                if (x != null)
                {
                    IQueryable<Customer> customers = this.UnitOfWork.Context.Customers.Where(y => y.ContactTitleID == id);
                    IQueryable<Supplier> suppliers = this.UnitOfWork.Context.Suppliers.Where(y => y.ContactTitleID == id);
                    x.Customers = customers.ToList();
                    x.Suppliers = suppliers.ToList();
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": ContactTitleGetByID; ContactTitleID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return x;
        }

        // Update
        public bool ContactTitleUpdate(ContactTitle contactTitle, ref string message)
        {
            _log.Info(THIS_CLASS + ": ContactTitleUpdate; ContactTitleID= " + contactTitle.ContactTitleID.ToString());
            bool isUpdateSuccessful = false;

            //
            // https://visualstudiomagazine.com/articles/2016/06/01/implementing-updates-without-query.aspx
            // Tried above but did not work, thought I was trying to update the primary key
            //try
            //{
            //    ContactTitle newContactTitle = new ContactTitle();
            //    this.UnitOfWork.Context.ContactTitles.Attach(newContactTitle);
            //    newContactTitle.ContactTitleID = contactTitle.ContactTitleID;
            //    newContactTitle.ContactTitleName = contactTitle.ContactTitleName;
            //    newContactTitle.IsActive = contactTitle.IsActive;
            //    newContactTitle.AddedBy = contactTitle.AddedBy;
            //    newContactTitle.AddedDate = contactTitle.AddedDate;
            //    newContactTitle.ModifiedBy = contactTitle.ModifiedBy;
            //    newContactTitle.ModifiedDate = DateTime.Now;
            //    newContactTitle.Modified = contactTitle.Modified;
            //    this.Update(newContactTitle);             
            //    this.CommitAllChanges();
            //    isUpdateSuccessful = true;
            //}
            //catch (Exception ex)
            //{
            //    message = ExceptionHelpers.GetAllMessages(ex);
            //    _log.Error(THIS_CLASS + ": ContactTitleUpdate; ContactTitleID= " + contactTitle.ContactTitleID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            //}


            try
            {
                // Get contactTitle to be updated
                ContactTitle updateEntity = this.GetByID(contactTitle.ContactTitleID);

                if (updateEntity != null)
                {
                    if (TimeStampExtensions.Matches(updateEntity.Modified, contactTitle.Modified))
                    {
                        // Update columns
                        this.UnitOfWork.Context.Entry(updateEntity).CurrentValues.SetValues(contactTitle);
                        updateEntity.ModifiedDate = DateTime.Now;

                        // Commit the updates
                        this.CommitAllChanges();
                        isUpdateSuccessful = true;
                    }
                    else
                    {
                        message = "The record you attempted to edit was modified by another user after you got the original value. The edit operation was canceled!";
                        _log.Debug(THIS_CLASS + ": ContactTitleUpdate; ContactTitleID= " + contactTitle.ContactTitleID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                    }
                }
                else
                {
                    message = "The record you attempted to edit was deleted by another user after you got the original value. The edit operation cannot be completed!";
                    _log.Debug(THIS_CLASS + ": ContactTitleUpdate; ContactTitleID= " + contactTitle.ContactTitleID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": ContactTitleUpdate; ContactTitleID= " + contactTitle.ContactTitleID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool ContactTitleDelete(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": ContactTitleDelete; ContactTitleID= " + id.ToString());
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
                _log.Error(THIS_CLASS + ": ContactTitleDelete; ContactTitleID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations
    }
}
