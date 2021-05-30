/*****************************************************************************
 *        Class Name: ApplicationUserToApplicationRoleBDO
 *  Class Decription: Contains the ApplicationUserToApplicationRole 
 *                    information from the DB
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.BDO
{
    public class ApplicationUserToApplicationRoleNamesBDO : EntityBaseBDO
    {
        public int ApplicationUserToApplicationRoleID { get; set; }
        public int ApplicationRoleID { get; set; }
        public int ApplicationUserID { get; set; }
        public bool IsActive { get; set; }
        public virtual ListItemBDO ApplicationRole { get; set; }
        public virtual ListItemBDO ApplicationUser { get; set; }
    }
}
