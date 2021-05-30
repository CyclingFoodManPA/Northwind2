/*****************************************************************************
 *       Interface Name: ITitleOfCourtesyRepository
 * Interface Decription: Contains Interface for TitleOfCourtesy repository
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
    public interface ITitleOfCourtesyRepository
    {
        // Create
        int TitleOfCourtesyAdd(TitleOfCourtesy titleOfCourtesy, ref string message);

        // Read
        IList<TitleOfCourtesy> TitleOfCourtesyGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message);
        IList<ListItem> TitleOfCourtesyGetAllList(out int totalCount, ref string message);
        TitleOfCourtesy TitleOfCourtesyGetByID(int titleOfCourtesyID, ref string message);

        // Update
        bool TitleOfCourtesyUpdate(TitleOfCourtesy titleOfCourtesy, ref string message);

        // Delete
        bool TitleOfCourtesyDelete(int titleOfCourtesyID, ref string message);
    }
}
