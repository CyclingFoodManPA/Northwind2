
/*****************************************************************************
 *        Class Name: CategoryRepository
 *  Class Decription: Contains data repository functionality for Category
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
    public sealed class CategoryRepository : RepositoryBase<Category>, ICategoryRepository
    {
        #region Private Member Variables

        // Private Member Variables
        private const string THIS_CLASS = "CategoryRepository";

        #endregion Private Member Variables

        #region Public Constructor
        // Public Constructor
        public CategoryRepository(IUnitOfWork unitOfWork)
            : base(unitOfWork)
        {
            // Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int CategoryAdd(Category region, ref string message)
        {
            _log.Info(THIS_CLASS + ": CategoryAdd; CategoryName= " + region.CategoryName.Trim());

            try
            {
                region.CategoryID = 0;
                region.AddedDate = DateTime.Now;
                region.ModifiedDate = DateTime.Now;
                this.Add(region);

                this.CommitAllChanges();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                region.CategoryID = -1;
                _log.Error(THIS_CLASS + ": CategoryAdd; CategoryName= " + region.CategoryName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return region.CategoryID;
        }

        // Read
        public IList<Category> CategoryGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CategoryGetAll");
            IList<Category> list = null;
            int totCount = 0;

            try
            {
                IQueryable<Category> query = (from x in this.UnitOfWork.Context.Categories
                                              select x);

                // Add predicate for dynamic search
                var predicate = PredicateBuilder.True<Category>();
                if (searchText != null && searchText.Length > 0)
                {
                    predicate = predicate.And(p => p.CategoryName.ToLower().Contains(searchText.ToLower()));
                }

                query = query.Where(predicate);

                list = GenericSorterPager.GetSortedPagedList<Category>(query, paging, out totalCount);
                totCount = totalCount;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CategoryGetAll" + " ErrorMessage: " + message.Trim());
            }

            // Had to do this asignment as after I put the try {} catch(() block in, code was looking
            // for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItem> CategoryGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CategoryGetAllList");
            List<ListItem> list = null;

            try
            {
                list = (from x in this.UnitOfWork.Context.Categories
                        orderby x.CategoryName
                        select new ListItem
                        {
                            ID = x.CategoryID,
                            Name = x.CategoryName
                        }).ToList();
                totalCount = list.Count();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CategoryGetAllList;" + " ErrorMessage: " + message.Trim());
                totalCount = 0;
            }

            return list;
        }

        public Category CategoryGetByID(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": CategoryGetByID; CategoryID= " + id.ToString());
            Category x = null;

            try
            {
                x = this.GetByID(id);

                if (x != null)
                {
                    IQueryable<Product> products = this.UnitOfWork.Context.Products.Where(y => y.CategoryID == id);
                    x.Products = products.ToList();
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CategoryGetByID; CategoryID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return x;
        }

        // Update
        public bool CategoryUpdate(Category category, ref string message)
        {
            _log.Info(THIS_CLASS + ": CategoryUpdate; CategoryID= " + category.CategoryID.ToString());
            bool isUpdateSuccessful = false;

            try
            {
                // Get category to be updated
                Category updateEntity = this.GetByID(category.CategoryID);

                if (updateEntity != null)
                {
                    if (TimeStampExtensions.Matches(updateEntity.Modified, category.Modified))
                    {
                        // Update columns
                        this.UnitOfWork.Context.Entry(updateEntity).CurrentValues.SetValues(category);
                        updateEntity.ModifiedDate = DateTime.Now;

                        // Commit the updates
                        this.CommitAllChanges();
                        isUpdateSuccessful = true;
                    }
                    else
                    {
                        message = "The record you attempted to edit was modified by another user after you got the original value. The edit operation was canceled!";
                        _log.Debug(THIS_CLASS + ": CategoryUpdate; CategoryID= " + category.CategoryID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                    }
                }
                else
                {
                    message = "The record you attempted to edit was deleted by another user after you got the original value. The edit operation cannot be completed!";
                    _log.Debug(THIS_CLASS + ": CategoryUpdate; CategoryID= " + category.CategoryID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CategoryUpdate; CategoryID= " + category.CategoryID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool CategoryDelete(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": CategoryDelete; CategoryID= " + id.ToString());
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
                _log.Error(THIS_CLASS + ": CategoryDelete; CategoryID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations
    }
}
