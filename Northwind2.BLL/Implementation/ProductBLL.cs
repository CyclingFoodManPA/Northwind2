/*****************************************************************************
 *        Class Name: ProductBLL
 *  Class Decription: Contains functionality for the business logic layer for 
 *                    Product
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

    public sealed class ProductBLL : Northwind2BLL, IProductBLL
    {
        private const string THIS_CLASS = "ProductBLL";
        private IProductDAL _dal;

        public ProductBLL(IProductDAL productDAL)
        {
            // Get _logger for ProductBLL
            _log.Info(THIS_CLASS + ": Public Constructor");
            _dal = productDAL;
        }

        #region CRUD Operations

        //// Create
        //public int ProductAdd(ProductBDO product, ref string message)
        //{
        //    _log.Info(THIS_CLASS + ": ProductAdd; ProductName= " + product.ProductName.Trim());
        //    return _dal.ProductAdd(product, ref message);
        //}

        // Read
        public IList<ProductBDO> ProductGetAll(ProductSearchFields searchFields,
            PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": ProductGetAll");
            return this._dal.ProductGetAll(searchFields, paging, out totalCount, ref message);
        }

        //public IList<ListItemBDO> ProductGetAllList(out int totalCount, ref string message)
        //{
        //    _log.Info(THIS_CLASS + ": ProductGetAllList");
        //    return _dal.ProductGetAllList(out totalCount, ref message);
        //}

        //public ProductBDO ProductGetByID(int productID, ref string message)
        //{
        //    _log.Info(THIS_CLASS + ": ProductGetByID; ProductID= " + productID.ToString());
        //    return _dal.ProductGetByID(productID, ref message);
        //}

        //// Update
        //public bool ProductUpdate(ProductBDO product, ref string message)
        //{
        //    _log.Info(THIS_CLASS + ": ProductUpdate; ProductID= " + product.ProductID.ToString());
        //    return this._dal.ProductUpdate(product, ref message);
        //}

        //// Delete
        //public bool ProductDelete(int productID, ref string message)
        //{
        //    _log.Info(THIS_CLASS + ": ProductDelete; ProductID= " + productID.ToString());
        //    return this._dal.ProductDelete(productID, ref message);
        //}

        #endregion CRUD Operations
    }
}
