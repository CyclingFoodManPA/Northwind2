
/*****************************************************************************
 *        Class Name: RegionRepository
 *  Class Decription: Contains data repository functionality for Region
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
    public sealed class RegionRepository : RepositoryBase<Region>, IRegionRepository
    {
        #region Private Member Variables

        // Private Member Variables
        private const string THIS_CLASS = "RegionRepository";

        #endregion Private Member Variables

        #region Public Constructor
        // Public Constructor
        public RegionRepository(IUnitOfWork unitOfWork)
            : base(unitOfWork)
        {
            // Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int RegionAdd(Region region, ref string message)
        {
            _log.Info(THIS_CLASS + ": RegionAdd; RegionName= " + region.RegionName.Trim());

            try
            {
                region.RegionID = 0;
                region.AddedDate = DateTime.Now;
                region.ModifiedDate = DateTime.Now;
                this.Add(region);

                this.CommitAllChanges();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                region.RegionID = -1;
                _log.Error(THIS_CLASS + ": RegionAdd; RegionName= " + region.RegionName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return region.RegionID;
        }

        // Read
        public IList<Region> RegionGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": RegionGetAll");
            IList<Region> list = null;
            int totCount = 0;

            try
            {
                IQueryable<Region> query = (from x in this.UnitOfWork.Context.Regions
                                                  select x);

                // Add predicate for dynamic search
                var predicate = PredicateBuilder.True<Region>();
                if (searchText != null && searchText.Length > 0)
                {
                    predicate = predicate.And(p => p.RegionName.ToLower().Contains(searchText.ToLower()));
                }

                query = query.Where(predicate);

                list = GenericSorterPager.GetSortedPagedList<Region>(query, paging, out totalCount);
                totCount = totalCount;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": RegionGetAll" + " ErrorMessage: " + message.Trim());
            }

            // Had to do this asignment as after I put the try {} catch(() block in, code was looking
            // for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItem> RegionGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": RegionGetAllList");
            List<ListItem> list = null;

            try
            {
                list = (from x in this.UnitOfWork.Context.Regions
                        orderby x.RegionName
                        select new ListItem
                        {
                            ID = x.RegionID,
                            Name = x.RegionName
                        }).ToList();
                totalCount = list.Count();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": RegionGetAllList;" + " ErrorMessage: " + message.Trim());
                totalCount = 0;
            }

            return list;
        }

        public Region RegionGetByID(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": RegionGetByID; RegionID= " + id.ToString());
            Region x = null;

            try
            {
                x = this.GetByID(id);

                if (x != null)
                {
                    IQueryable<Territory> territories = this.UnitOfWork.Context.Territories.Where(y => y.RegionID == id);
                    x.Territories = territories.ToList();
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": RegionGetByID; RegionID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return x;
        }

        // Update
        public bool RegionUpdate(Region region, ref string message)
        {
            _log.Info(THIS_CLASS + ": RegionUpdate; RegionID= " + region.RegionID.ToString());
            bool isUpdateSuccessful = false;

            try
            {
                // Get region to be updated
                Region updateEntity = this.GetByID(region.RegionID);

                if (updateEntity != null)
                {
                    if (TimeStampExtensions.Matches(updateEntity.Modified, region.Modified))
                    {
                        // Update columns
                        this.UnitOfWork.Context.Entry(updateEntity).CurrentValues.SetValues(region);
                        updateEntity.ModifiedDate = DateTime.Now;

                        // Commit the updates
                        this.CommitAllChanges();
                        isUpdateSuccessful = true;
                    }
                    else
                    {
                        message = "The record you attempted to edit was modified by another user after you got the original value. The edit operation was canceled!";
                        _log.Debug(THIS_CLASS + ": RegionUpdate; RegionID= " + region.RegionID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                    }
                }
                else
                {
                    message = "The record you attempted to edit was deleted by another user after you got the original value. The edit operation cannot be completed!";
                    _log.Debug(THIS_CLASS + ": RegionUpdate; RegionID= " + region.RegionID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": RegionUpdate; RegionID= " + region.RegionID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool RegionDelete(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": RegionDelete; RegionID= " + id.ToString());
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
                _log.Error(THIS_CLASS + ": RegionDelete; RegionID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations
    }
}
