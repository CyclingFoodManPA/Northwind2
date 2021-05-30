using System;
using System.Collections.Generic;
using System.Linq;
using Northwind2.Common.Classes;
using Northwind2.Common.Infrastructure;
using Northwind2.Entities.Models;
using Northwind2.Repositories.Contracts;

namespace Northwind2.Repositories.Implementation
{
    public class CustomerRepository : RepositoryBase<Customer>, ICustomerRepository
    {
        #region Private Member Variables

        // Private Member Variables
        private const string THIS_CLASS = "CustomerRepository";

        #endregion Private Member Variables

        #region Public Constructor
        // Public Constructor
        public CustomerRepository(IUnitOfWork unitOfWork)
            : base(unitOfWork)
        {
            // Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int CustomerAdd(Customer customer, ref string message)
        {
            _log.Info(THIS_CLASS + ": ContactTitleAdd; ContactTitleName= " + customer.CustomerName.Trim());

            try
            {             
                customer.CustomerID = 0;
                customer.AddedDate = DateTime.Now;
                customer.ModifiedDate = DateTime.Now;
                this.Add(customer);

                this.CommitAllChanges();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                customer.CustomerID = -1;
                _log.Error(THIS_CLASS + ": ContactTitleAdd; ContactTitleName= " + customer.CustomerName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return customer.ContactTitleID;
        }

        // Read
        public IList<Customer> CustomerGetAll(CustomerSearchFields searchFields, PaginationRequest paging,
            out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerGetAll");
            IList<Customer> list = null;
            int totCount = 0;
            
            try
            {
                IQueryable<Customer> query = (from x in this.UnitOfWork.Context.Customers
                                              select x);
                // Add predicate for dynamic search
                var predicate = PredicateBuilder.True<Customer>();

                //Build predicate conditionally including criteria or not
                if (searchFields != null)
                {
                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.CustomerName))
                    {
                        predicate = predicate.And(c => c.CustomerName.ToLower().Contains(searchFields.CustomerName.ToLower()));
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.ContactName))
                    {
                        predicate = predicate.And(c => c.ContactName.ToLower().Contains(searchFields.ContactName.ToLower()));
                    }

                    if (searchFields.ContactTitleID != 0)
                    {
                        predicate = predicate.And(c => c.ContactTitleID == searchFields.ContactTitleID);
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.ContactTitleName))
                    {
                        predicate = predicate.And(c => c.ContactTitle.ContactTitleName.ToLower().Contains(searchFields.ContactTitleName));
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.Address1))
                    {
                        predicate = predicate.And(c => c.Address1.ToLower().Contains(searchFields.Address1.ToLower()));
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.City))
                    {
                        predicate = predicate.And(c => c.City.ToLower().Contains(searchFields.City.ToLower()));
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.Region))
                    {
                        predicate = predicate.And(c => c.Region.ToLower().Contains(searchFields.Region.ToLower()));
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.PostalCode))
                    {
                        predicate = predicate.And(c => c.PostalCode.ToLower().Contains(searchFields.PostalCode.ToLower()));
                    }

                    if (searchFields.CountryID != 0)
                    {
                        predicate = predicate.And(c => c.CountryID == searchFields.CountryID);
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.CountryName))
                    {
                        predicate = predicate.And(c => c.Country.CountryName.ToLower().Contains(searchFields.CountryName));
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.Phone))
                    {
                        predicate = predicate.And(c => c.Phone.ToLower().Contains(searchFields.Phone.ToLower()));
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.Fax))
                    {
                        predicate = predicate.And(c => c.Fax.ToLower().Contains(searchFields.Fax.ToLower()));
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.Email))
                    {
                        predicate = predicate.And(c => c.Email.ToLower().Contains(searchFields.Email.ToLower()));
                    }

                    predicate = predicate.And(c => c.IsActive == searchFields.IsActive);

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.AddedBy))
                    {
                        predicate = predicate.And(c => c.AddedBy.ToLower().Contains(searchFields.AddedBy.ToLower()));
                    }

                    if (searchFields.AddedDate != DateTime.MinValue)
                    {
                        predicate = predicate.And(c => c.AddedDate.Equals(searchFields.AddedDate));
                    }

                    if (Utilities.SearchFieldNotNullOrEmpty(searchFields.ModifiedBy))
                    {
                        predicate = predicate.And(c => c.ModifiedBy.ToLower().Contains(searchFields.ModifiedBy.ToLower()));
                    }

                    if (searchFields.ModifiedDate != DateTime.MinValue)
                    {
                        predicate = predicate.And(c => c.ModifiedDate.Equals(searchFields.ModifiedDate));
                    }
                }

                query = query.Where(predicate);

                list = GenericSorterPager.GetSortedPagedList<Customer>(query, paging, out totalCount);
                totCount = totalCount;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CustomerGetAll" + " ErrorMessage: " + message.Trim());
            }

            // Had to do this asignment as after I put the try {} catch(() block in, code was looking
            // for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItem> CustomerGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerGetAllList");
            List<ListItem> list = null;

            try
            {
                list = (from x in this.UnitOfWork.Context.Customers
                        orderby x.CustomerName
                        select new ListItem
                        {
                            ID = x.CustomerID,
                            Name = x.CustomerName
                        }).ToList();
                totalCount = list.Count();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CustomerGetAllList;" + " ErrorMessage: " + message.Trim());
                totalCount = 0;
            }

            return list;
        }


        public Customer CustomerGetByID(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerGetByID; CustomerID= " + id.ToString());
            Customer c = null;

            try
            {
                c = this.GetByID(id);

                if (c != null)
                {
                    IQueryable<Invoice> invoices = this.UnitOfWork.Context.Invoices.Where(x => x.CustomerID == id);
                    c.Invoices = invoices.ToList();
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": ContactTitleGetByID; ContactTitleID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return c;
        }

        // Update
        public bool CustomerUpdate(Customer customer, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerUpdate; CustomerID= " + customer.CustomerID.ToString());
            bool isUpdateSuccessful = false;

            try
            {
                // Get contactTitle to be updated
                Customer updateEntity = this.GetByID(customer.CustomerID);

                if (updateEntity != null)
                {
                    if (TimeStampExtensions.Matches(updateEntity.Modified, customer.Modified))
                    {
                        // Update columns
                        this.UnitOfWork.Context.Entry(updateEntity).CurrentValues.SetValues(customer);
                        updateEntity.ModifiedDate = DateTime.Now;

                        // Commit the updates
                        this.CommitAllChanges();
                        isUpdateSuccessful = true;
                    }
                    else
                    {
                        message = "The record you attempted to edit was modified by another user after you got the original value. The edit operation was canceled!";
                        _log.Debug(THIS_CLASS + ": CustomerUpdate; CustomerID= " + customer.CustomerID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                    }
                }
                else
                {
                    message = "The record you attempted to edit was deleted by another user after you got the original value. The edit operation cannot be completed!";
                    _log.Debug(THIS_CLASS + ": CustomerUpdate; CustomerID= " + customer.CustomerID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CustomerUpdate; CustomerID= " + customer.CustomerID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool CustomerDelete(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerDelete; CustomerID= " + id.ToString());
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
                _log.Error(THIS_CLASS + ": CustomerDelete; CustomerID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations
    }
}
