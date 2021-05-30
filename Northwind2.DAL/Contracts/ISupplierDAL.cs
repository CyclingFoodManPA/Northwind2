/*****************************************************************************
 *       Interface Name: ISupplierDAL
 * Interface Decription: Contains Interface for Supplier data access layer
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
    public interface ISupplierDAL
    {
        IList<ListItemBDO> SupplierGetAllList(out int totalCount, ref string message);
    }
}
