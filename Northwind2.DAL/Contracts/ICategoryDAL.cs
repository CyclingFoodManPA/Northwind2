/*****************************************************************************
 *       Interface Name: ICategoryDAL
 * Interface Decription: Contains Interface for Category data access layer
 *                 Date: Tuesday, October 31, 2016
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
    public interface ICategoryDAL
    {
        IList<ListItemBDO> CategoryGetAllList(out int totalCount, ref string message);
    }
}
