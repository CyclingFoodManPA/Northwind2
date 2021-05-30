/*****************************************************************************
 *       Interface Name: IProductDAL
 * Interface Decription: Contains Interface for Product data access layer
 *                 Date: Tuesday, October 31, 2016
 *               Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;
using Northwind2.BDO;
using Northwind2.Common.Classes;

namespace Northwind2.DAL.Contracts
{
    public interface IProductDAL
    {
        // Create
        //int ProductAdd(ProductBDO product, ref string message);

        // Read
        IList<ProductBDO> ProductGetAll(ProductSearchFields searchFields, PaginationRequest paging,
            out int totalCount, ref string message);
        //IList<ListItemBDO> ProductGetAllList(out int totalCount, ref string message);
        //ProductBDO ProductGetByID(int productID, ref string message);

        //// Update
        //bool ProductUpdate(ProductBDO systemUser, ref string message);

        //// Delete
        //bool ProductDelete(int productID, ref string message);
    }
}
