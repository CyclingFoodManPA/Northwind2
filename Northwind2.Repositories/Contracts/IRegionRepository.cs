/*****************************************************************************
 *       Interface Name: IRegionRepository
 * Interface Decription: Contains Interface for Region repository
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
    public interface IRegionRepository
    {
        // Create
        int RegionAdd(Region region, ref string message);

        // Read
        IList<Region> RegionGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message);
        IList<ListItem> RegionGetAllList(out int totalCount, ref string message);
        Region RegionGetByID(int regionID, ref string message);

        // Update
        bool RegionUpdate(Region region, ref string message);

        // Delete
        bool RegionDelete(int regionID, ref string message);
    }
}
