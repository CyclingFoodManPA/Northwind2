/*****************************************************************************
 *       Interface Name: ITitleRepository
 * Interface Decription: Contains Interface for Title repository
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
    public interface ITitleRepository
    {
        // Create
        int TitleAdd(Title title, ref string message);

        // Read
        IList<Title> TitleGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message);
        IList<ListItem> TitleGetAllList(out int totalCount, ref string message);
        Title TitleGetByID(int titleID, ref string message);

        // Update
        bool TitleUpdate(Title title, ref string message);

        // Delete
        bool TitleDelete(int titleID, ref string message);
    }
}
