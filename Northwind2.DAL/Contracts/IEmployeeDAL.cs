/*****************************************************************************
 *       Interface Name: IEmployeeDAL
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
    public interface IEmployeeDAL
    {
        // Create
        int EmployeeAdd(EmployeeBDO customer, ref string message);

        // Read
        IList<EmployeeBDO> EmployeeGetAll(EmployeeSearchFields searchFields, PaginationRequest paging,
            out int totalCount, ref string message);
        IList<ListItemBDO> EmployeeGetAllList(out int totalCount, ref string message);
        EmployeeBDO EmployeeGetByID(int systemUserID, ref string message);

        // Update
        bool EmployeeUpdate(EmployeeBDO systemUser, ref string message);

        // Delete
        bool EmployeeDelete(int customerID, ref string message);
    }
}
