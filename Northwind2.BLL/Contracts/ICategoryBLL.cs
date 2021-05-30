/*****************************************************************************
 *       Interface Name: ICategoryBLL
 * Interface Decription: Contains Interface for the Category business logic
 *                       layer
 *                 Date: Friday, July 1, 2016
 *               Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.BLL.Contracts
{
    using System.Collections.Generic;
    using Northwind2.BDO;
    using Northwind2.Common.Classes;

    public interface ICategoryBLL
    {
        IList<ListItemBDO> CategoryGetAllList(out int totalCount, ref string message);
    }
}
