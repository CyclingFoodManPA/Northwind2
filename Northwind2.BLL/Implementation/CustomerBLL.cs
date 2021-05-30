/*****************************************************************************
 *        Class Name: CustomerBLL
 *  Class Decription: Contains functionality for the business logic layer for 
 *                    Customer
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.BLL.Implementation
{
    using System.Collections.Generic;
    using Northwind2.BDO;
    using Northwind2.BLL;
    using Northwind2.BLL.Contracts;
    using Northwind2.Common.Classes;
    using Northwind2.DAL.Contracts;

    public sealed class CustomerBLL : Northwind2BLL, ICustomerBLL
    {
        private const string THIS_CLASS = "CustomerBLL";
        private ICustomerDAL _dal;

        public CustomerBLL(ICustomerDAL customerDAL)
        {
            // Get _logger for CustomerBLL
            _log.Info(THIS_CLASS + ": Public Constructor");
            _dal = customerDAL;
        }

        #region CRUD Operations

        // Create
        public int CustomerAdd(CustomerBDO customer, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerAdd; CustomerName= " + customer.CustomerName.Trim());
            return _dal.CustomerAdd(customer, ref message);
        }

        // Read
        public IList<CustomerBDO> CustomerGetAll(CustomerSearchFields searchFields, 
            PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerGetAll");
            return this._dal.CustomerGetAll(searchFields, paging, out totalCount, ref message);
        }

        public IList<ListItemBDO> CustomerGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerGetAllList");
            return _dal.CustomerGetAllList(out totalCount, ref message);
        }

        public CustomerBDO CustomerGetByID(int customerID, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerGetByID; CustomerID= " + customerID.ToString());
            return _dal.CustomerGetByID(customerID, ref message);
        }

        // Update
        public bool CustomerUpdate(CustomerBDO customer, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerUpdate; CustomerID= " + customer.CustomerID.ToString());
            return this._dal.CustomerUpdate(customer, ref message);
        }

        // Delete
        public bool CustomerDelete(int customerID, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerDelete; CustomerID= " + customerID.ToString());
            return this._dal.CustomerDelete(customerID, ref message);
        }

        #endregion CRUD Operations
    }
}
