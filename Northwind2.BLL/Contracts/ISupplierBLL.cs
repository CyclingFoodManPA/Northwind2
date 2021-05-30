/*****************************************************************************
 *       Interface Name: ISupplierBLL
 * Interface Decription: Contains Interface for the Supplier business logic
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

    public interface ISupplierBLL
    {
        IList<ListItemBDO> SupplierGetAllList(out int totalCount, ref string message);
    }
}
