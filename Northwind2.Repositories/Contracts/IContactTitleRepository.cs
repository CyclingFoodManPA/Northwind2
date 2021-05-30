/*****************************************************************************
 *       Interface Name: IContactTitleRepository
 * Interface Decription: Contains Interface for ContactTitle repository
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
    public interface IContactTitleRepository
    {
        // Create
        int ContactTitleAdd(ContactTitle contactTitle, ref string message);

        // Read
        IList<ContactTitle> ContactTitleGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message);
        IList<ListItem> ContactTitleGetAllList(out int totalCount, ref string message);
        ContactTitle ContactTitleGetByID(int contactTitleID, ref string message);

        // Update
        bool ContactTitleUpdate(ContactTitle contactTitle, ref string message);

        // Delete
        bool ContactTitleDelete(int contactTitleID, ref string message);
    }
}
