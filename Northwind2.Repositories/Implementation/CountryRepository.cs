
/*****************************************************************************
 *        Class Name: CountryRepository
 *  Class Decription: Contains data repository functionality for Country
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
    public sealed class CountryRepository : RepositoryBase<Country>, ICountryRepository
    {
        #region Private Member Variables

        // Private Member Variables
        private const string THIS_CLASS = "CountryRepository";

        #endregion Private Member Variables

        #region Public Constructor
        // Public Constructor
        public CountryRepository(IUnitOfWork unitOfWork)
            : base(unitOfWork)
        {
            // Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int CountryAdd(Country country, ref string message)
        {
            _log.Info(THIS_CLASS + ": CountryAdd; CountryName= " + country.CountryName.Trim());

            try
            {
                country.CountryID = 0;
                country.AddedDate = DateTime.Now;
                country.ModifiedDate = DateTime.Now;
                this.Add(country);

                this.CommitAllChanges();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                country.CountryID = -1;
                _log.Error(THIS_CLASS + ": CountryAdd; CountryName= " + country.CountryName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return country.CountryID;
        }

        // Read
        public IList<Country> CountryGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CountryGetAll");
            IList<Country> list = null;
            int totCount = 0;

            try
            {
                IQueryable<Country> query = (from x in this.UnitOfWork.Context.Countries
                                             select x);

                // Add predicate for dynamic search
                var predicate = PredicateBuilder.True<Country>();
                if (searchText != null && searchText.Length > 0)
                {
                    predicate = predicate.And(p => p.CountryName.ToLower().Contains(searchText.ToLower()));
                }

                query = query.Where(predicate);

                list = GenericSorterPager.GetSortedPagedList<Country>(query, paging, out totalCount);
                totCount = totalCount;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CountryGetAll" + " ErrorMessage: " + message.Trim());
            }

            // Had to do this asignment as after I put the try {} catch(() block in, code was looking
            // for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItem> CountryGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CountryGetAllList");
            List<ListItem> list = null;

            try
            {
                list = (from x in this.UnitOfWork.Context.Countries
                        orderby x.CountryName
                        select new ListItem
                        {
                            ID = x.CountryID,
                            Name = x.CountryName
                        }).ToList();
                totalCount = list.Count();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CountryGetAllList;" + " ErrorMessage: " + message.Trim());
                totalCount = 0;
            }

            return list;
        }

        public Country CountryGetByID(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": CountryGetByID; CountryID= " + id.ToString());
            Country ct = null;

            try
            {
                ct = this.GetByID(id);

                if (ct != null)
                {
                    IQueryable<Customer> customers = this.UnitOfWork.Context.Customers.Where(x => x.CountryID == id);
                    IQueryable<Supplier> suppliers = this.UnitOfWork.Context.Suppliers.Where(x => x.CountryID == id);
                    ct.Customers = customers.ToList();
                    ct.Suppliers = suppliers.ToList();
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CountryGetByID; CountryID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return ct;
        }

        // Update
        public bool CountryUpdate(Country country, ref string message)
        {
            _log.Info(THIS_CLASS + ": CountryUpdate; CountryID= " + country.CountryID.ToString());
            bool isUpdateSuccessful = false;

            try
            {
                // Get country to be updated
                Country updateEntity = this.GetByID(country.CountryID);

                if (updateEntity != null)
                {
                    if (TimeStampExtensions.Matches(updateEntity.Modified, country.Modified))
                    {
                        // Update columns
                        this.UnitOfWork.Context.Entry(updateEntity).CurrentValues.SetValues(country);
                        updateEntity.ModifiedDate = DateTime.Now;

                        // Commit the updates
                        this.CommitAllChanges();
                        isUpdateSuccessful = true;
                    }
                    else
                    {
                        message = "The record you attempted to edit was modified by another user after you got the original value. The edit operation was canceled!";
                        _log.Debug(THIS_CLASS + ": CountryUpdate; CountryID= " + country.CountryID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                    }
                }
                else
                {
                    message = "The record you attempted to edit was deleted by another user after you got the original value. The edit operation cannot be completed!";
                    _log.Debug(THIS_CLASS + ": CountryUpdate; CountryID= " + country.CountryID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CountryUpdate; CountryID= " + country.CountryID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool CountryDelete(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": CountryDelete; CountryID= " + id.ToString());
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
                _log.Error(THIS_CLASS + ": CountryDelete; CountryID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations
    }
}
