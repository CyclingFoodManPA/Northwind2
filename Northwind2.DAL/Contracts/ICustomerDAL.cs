/*****************************************************************************
 *       Interface Name: ICustomerDAL
 * Interface Decription: Contains Interface for SystemRole data access layer
 *                 Date: Friday, July 1, 2016
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
    public interface ICustomerDAL
    {
        // Create
        int CustomerAdd(CustomerBDO customer, ref string message);

        // Read
        IList<CustomerBDO> CustomerGetAll(CustomerSearchFields searchFields, PaginationRequest paging, 
            out int totalCount, ref string message);
        IList<ListItemBDO> CustomerGetAllList(out int totalCount, ref string message);
        CustomerBDO CustomerGetByID(int productID, ref string message);

        // Update
        bool CustomerUpdate(CustomerBDO systemUser, ref string message);

        // Delete
        bool CustomerDelete(int customerID, ref string message);
    }
}
