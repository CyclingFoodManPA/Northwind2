
/*****************************************************************************
 *        Class Name: ShipperRepository
 *  Class Decription: Contains data repository functionality for Shipper
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
    public sealed class ShipperRepository : RepositoryBase<Shipper>, IShipperRepository
    {
        #region Private Member Variables

        // Private Member Variables
        private const string THIS_CLASS = "ShipperRepository";

        #endregion Private Member Variables

        #region Public Constructor
        // Public Constructor
        public ShipperRepository(IUnitOfWork unitOfWork)
            : base(unitOfWork)
        {
            // Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int ShipperAdd(Shipper region, ref string message)
        {
            _log.Info(THIS_CLASS + ": ShipperAdd; ShipperName= " + region.ShipperName.Trim());

            try
            {
                region.ShipperID = 0;
                region.AddedDate = DateTime.Now;
                region.ModifiedDate = DateTime.Now;
                this.Add(region);

                this.CommitAllChanges();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                region.ShipperID = -1;
                _log.Error(THIS_CLASS + ": ShipperAdd; ShipperName= " + region.ShipperName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return region.ShipperID;
        }

        // Read
        public IList<Shipper> ShipperGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": ShipperGetAll");
            IList<Shipper> list = null;
            int totCount = 0;

            try
            {
                IQueryable<Shipper> query = (from x in this.UnitOfWork.Context.Shippers
                                             select x);

                // Add predicate for dynamic search
                var predicate = PredicateBuilder.True<Shipper>();
                if (searchText != null && searchText.Length > 0)
                {
                    predicate = predicate.And(p => p.ShipperName.ToLower().Contains(searchText.ToLower()));
                }

                query = query.Where(predicate);

                list = GenericSorterPager.GetSortedPagedList<Shipper>(query, paging, out totalCount);
                totCount = totalCount;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": ShipperGetAll" + " ErrorMessage: " + message.Trim());
            }

            // Had to do this asignment as after I put the try {} catch(() block in, code was looking
            // for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItem> ShipperGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": ShipperGetAllList");
            List<ListItem> list = null;

            try
            {
                list = (from x in this.UnitOfWork.Context.Shippers
                        orderby x.ShipperName
                        select new ListItem
                        {
                            ID = x.ShipperID,
                            Name = x.ShipperName
                        }).ToList();
                totalCount = list.Count();
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": ShipperGetAllList;" + " ErrorMessage: " + message.Trim());
                totalCount = 0;
            }

            return list;
        }

        public Shipper ShipperGetByID(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": ShipperGetByID; ShipperID= " + id.ToString());
            Shipper x = null;

            try
            {
                x = this.GetByID(id);

                if (x != null)
                {
                    IQueryable<Invoice> invoices = this.UnitOfWork.Context.Invoices.Where(y => y.ShipperID == id);
                    x.Invoices = invoices.ToList();
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": ShipperGetByID; ShipperID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return x;
        }

        // Update
        public bool ShipperUpdate(Shipper shipper, ref string message)
        {
            _log.Info(THIS_CLASS + ": ShipperUpdate; ShipperID= " + shipper.ShipperID.ToString());
            bool isUpdateSuccessful = false;

            try
            {
                // Get shipper to be updated
                Shipper updateEntity = this.GetByID(shipper.ShipperID);

                if (updateEntity != null)
                {
                    if (TimeStampExtensions.Matches(updateEntity.Modified, shipper.Modified))
                    {
                        // Update columns
                        this.UnitOfWork.Context.Entry(updateEntity).CurrentValues.SetValues(shipper);
                        updateEntity.ModifiedDate = DateTime.Now;

                        // Commit the updates
                        this.CommitAllChanges();
                        isUpdateSuccessful = true;
                    }
                    else
                    {
                        message = "The record you attempted to edit was modified by another user after you got the original value. The edit operation was canceled!";
                        _log.Debug(THIS_CLASS + ": ShipperUpdate; ShipperID= " + shipper.ShipperID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                    }
                }
                else
                {
                    message = "The record you attempted to edit was deleted by another user after you got the original value. The edit operation cannot be completed!";
                    _log.Debug(THIS_CLASS + ": ShipperUpdate; ShipperID= " + shipper.ShipperID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": ShipperUpdate; ShipperID= " + shipper.ShipperID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool ShipperDelete(int id, ref string message)
        {
            _log.Info(THIS_CLASS + ": ShipperDelete; ShipperID= " + id.ToString());
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
                _log.Error(THIS_CLASS + ": ShipperDelete; ShipperID= " + id.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations
    }
}
