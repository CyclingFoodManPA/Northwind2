/*****************************************************************************
 *       Interface Name: IProductBLL
 * Interface Decription: Contains Interface for the Product business logic
 *                       layer
 *                 Date: Wednesday, November 1, 2017
 *               Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.BLL.Contracts
{
    using System.Collections.Generic;
    using Northwind2.BDO;
    using Northwind2.Common.Classes;

    public interface IProductBLL
    {
        //// Create
        //int ProductAdd(ProductBDO product, ref string message);

        // Read
        IList<ProductBDO> ProductGetAll(ProductSearchFields searchFields, PaginationRequest paging, out int totalCount, ref string message);
        //IList<ListItemBDO> ProductGetAllList(out int totalCount, ref string message);
        //ProductBDO ProductGetByID(int productID, ref string message);

        //// Update
        //bool ProductUpdate(ProductBDO product, ref string message);

        //// Delete
        //bool ProductDelete(int productID, ref string message);
    }
}
