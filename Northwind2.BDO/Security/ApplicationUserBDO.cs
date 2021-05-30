/*****************************************************************************
 *        Class Name: ApplicationUserBDO
 *  Class Decription: Contains the ApplicationUser information from the DB
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Collections.Generic;

namespace Northwind2.BDO
{
    public class ApplicationUserBDO : EntityBaseBDO
    {
        public ApplicationUserBDO()
        {
            ApplicationRoles = new HashSet<ListItemBDO>();
        }

        public int ApplicationUserID { get; set; }
        public string ApplicationUserLastName { get; set; }
        public string ApplicationUserFirstName { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public DateTime LastLoginDate { get; set; }
        public DateTime LastActivityDate { get; set; }
        public DateTime LastPasswordChangeDate { get; set; }
        public bool IsActive { get; set; }

        public virtual ICollection<ListItemBDO> ApplicationRoles { get; set; }
    }
}
