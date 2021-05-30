/*****************************************************************************
 *        Class Name: ApplicationRoleBDO
 *  Class Decription: Contains the ApplicationRole information from the DB
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;

namespace Northwind2.BDO
{
    public class ApplicationRoleBDO : EntityBaseBDO
    {
        public ApplicationRoleBDO()
        {
            ApplicationUsers = new HashSet<ListItemBDO>();
        }

        public int ApplicationRoleID { get; set; }
        public string ApplicationRoleName {get; set;}
        public bool IsActive { get; set; }

        public virtual ICollection<ListItemBDO> ApplicationUsers { get; set; }
    }
}
