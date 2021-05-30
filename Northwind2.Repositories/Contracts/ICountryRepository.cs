/*****************************************************************************
 *       Interface Name: ICountryRepository
 * Interface Decription: Contains Interface for Country repository
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
    public interface ICountryRepository
    {
        // Create
        int CountryAdd(Country contactTitle, ref string message);

        // Read
        IList<Country> CountryGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message);
        IList<ListItem> CountryGetAllList(out int totalCount, ref string message);
        Country CountryGetByID(int contactTitleID, ref string message);

        // Update
        bool CountryUpdate(Country contactTitle, ref string message);

        // Delete
        bool CountryDelete(int contactTitleID, ref string message);
    }
}
