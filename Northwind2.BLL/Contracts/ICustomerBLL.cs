/*****************************************************************************
 *       Interface Name: ICustomerBLL
 * Interface Decription: Contains Interface for the Customer business logic
 *                       layer
 *                 Date: Friday, July 1, 2016
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

    public interface ICustomerBLL
    {
        // Create
        int CustomerAdd(CustomerBDO customer, ref string message);

        // Read
        IList<CustomerBDO> CustomerGetAll(CustomerSearchFields searchFields, PaginationRequest paging, out int totalCount, ref string message);
        IList<ListItemBDO> CustomerGetAllList(out int totalCount, ref string message);
        CustomerBDO CustomerGetByID(int productID, ref string message);

        // Update
        bool CustomerUpdate(CustomerBDO customer, ref string message);

        // Delete
        bool CustomerDelete(int productID, ref string message);
    }
}
