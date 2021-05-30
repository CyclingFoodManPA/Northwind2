/*****************************************************************************
 *        Class Name: SupplierBLL
 *  Class Decription: Contains functionality for the business logic layer for 
 *                    Supplier
 *              Date: Wednesday, November 1, 2017
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

    public sealed class SupplierBLL : Northwind2BLL, ISupplierBLL
    {
        private const string THIS_CLASS = "SupplierBLL";
        private ISupplierDAL _dal;

        public SupplierBLL(ISupplierDAL productDAL)
        {
            // Get _logger for SupplierBLL
            _log.Info(THIS_CLASS + ": Public Constructor");
            _dal = productDAL;
        }

        #region CRUD Operations

        public IList<ListItemBDO> SupplierGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": SupplierGetAllList");
            return _dal.SupplierGetAllList(out totalCount, ref message);
        }

        #endregion CRUD Operations
    }
}
