/*****************************************************************************
 *       Interface Name: IShipperRepository
 * Interface Decription: Contains Interface for Shipper repository
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
    public interface IShipperRepository
    {
        // Create
        int ShipperAdd(Shipper shipper, ref string message);

        // Read
        IList<Shipper> ShipperGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message);
        IList<ListItem> ShipperGetAllList(out int totalCount, ref string message);
        Shipper ShipperGetByID(int shipperID, ref string message);

        // Update
        bool ShipperUpdate(Shipper shipper, ref string message);

        // Delete
        bool ShipperDelete(int shipperID, ref string message);
    }
}
