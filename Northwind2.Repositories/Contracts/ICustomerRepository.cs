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
using Northwind2.Common.Classes;
using Northwind2.Entities.Models;

namespace Northwind2.Repositories.Contracts
{
    public interface ICustomerRepository
    {
        // Create
        int CustomerAdd(Customer customer, ref string message);

        // Read
        IList<Customer> CustomerGetAll(CustomerSearchFields searchFields, PaginationRequest paging,
            out int totalCount, ref string message);
        IList<ListItem> CustomerGetAllList(out int totalCount, ref string message);
        Customer CustomerGetByID(int id, ref string message);

        // Update
        bool CustomerUpdate(Customer systemUser, ref string message);

        // Delete
        bool CustomerDelete(int id, ref string message);
    }
}
