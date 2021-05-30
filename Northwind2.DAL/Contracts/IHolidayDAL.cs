/*****************************************************************************
 *       Interface Name: IHolidayDAL
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
    public interface IHolidayDAL
    {
        // Create
        int HolidayAdd(HolidayBDO holiday, ref string message);

        // Read
        IList<HolidayBDO> HolidayGetAll(HolidaySearchFields searchFields, PaginationRequest paging,
            out int totalCount, ref string message);
        IList<ListItemBDO> HolidayGetAllList(out int totalCount, ref string message);
        HolidayBDO HolidayGetByID(int systemUserID, ref string message);

        // Update
        bool HolidayUpdate(HolidayBDO systemUser, ref string message);

        // Delete
        bool HolidayDelete(int holidayID, ref string message);
    }
}
