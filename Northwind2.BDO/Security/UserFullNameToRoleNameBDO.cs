/*****************************************************************************
 *        Class Name: UserToRoleBDO
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
    public class UserFullNameToRoleNameBDO
    {
        public int ApplicationUserID { get; set; }
        public string ApplicationUserLastName { get; set; }
        public string ApplicationUserFirstName { get; set; }
        public string Username { get; set; }
        public int ApplicationRoleID { get; set; }
        public string ApplicationRoleName { get; set; }
    }
}
