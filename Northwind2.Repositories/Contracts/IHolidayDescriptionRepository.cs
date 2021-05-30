/*****************************************************************************
 *       Interface Name: IHolidayDescriptionRepository
 * Interface Decription: Contains Interface for HolidayDescription repository
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
    public interface IHolidayDescriptionRepository
    {
        // Create
        int HolidayDescriptionAdd(HolidayDescription holidayDescription, ref string message);

        // Read
        IList<HolidayDescription> HolidayDescriptionGetAll(string searchText, PaginationRequest paging, out int totalCount, ref string message);
        IList<ListItem> HolidayDescriptionGetAllList(out int totalCount, ref string message);
        HolidayDescription HolidayDescriptionGetByID(int holidayDescriptionID, ref string message);

        // Update
        bool HolidayDescriptionUpdate(HolidayDescription holidayDescription, ref string message);

        // Delete
        bool HolidayDescriptionDelete(int holidayDescriptionID, ref string message);
    }
}
