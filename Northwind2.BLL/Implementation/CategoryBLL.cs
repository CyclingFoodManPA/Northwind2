/*****************************************************************************
 *        Class Name: CategoryBLL
 *  Class Decription: Contains functionality for the business logic layer for 
 *                    Category
 *              Date: Wednesday, November 1, 2017
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.BLL.Implementation
{
    using System.Collections.Generic;
    using Northwind2.BDO;
    using Northwind2.BLL;
    using Northwind2.BLL.Contracts;
    using Northwind2.Common.Classes;
    using Northwind2.DAL.Contracts;

    public sealed class CategoryBLL : Northwind2BLL, ICategoryBLL
    {
        private const string THIS_CLASS = "CategoryBLL";
        private ICategoryDAL _dal;

        public CategoryBLL(ICategoryDAL productDAL)
        {
            // Get _logger for CategoryBLL
            _log.Info(THIS_CLASS + ": Public Constructor");
            _dal = productDAL;
        }

        #region CRUD Operations

        public IList<ListItemBDO> CategoryGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CategoryGetAllList");
            return _dal.CategoryGetAllList(out totalCount, ref message);
        }

        #endregion CRUD Operations
    }
}
