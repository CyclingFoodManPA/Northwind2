/*****************************************************************************
 *       Interface Name: ICategoryRepository
 * Interface Decription: Contains Interface for Category repository
 *                 Date: Friday, July 8, 2016
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
    public interface ICategoryRepository
    {
        // Create
        int CategoryAdd(Category category, ref string message);

        // Read
        IList<Category> CategoryGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message);
        IList<ListItem> CategoryGetAllList(out int totalCount, ref string message);
        Category CategoryGetByID(int categoryID, ref string message);

        // Update
        bool CategoryUpdate(Category category, ref string message);

        // Delete
        bool CategoryDelete(int categoryID, ref string message);
    }
}
