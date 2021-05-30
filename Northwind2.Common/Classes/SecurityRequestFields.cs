/*****************************************************************************
 *         Enum Name: LoginRequestFields
 *  Class Decription: Contains fields to validate user login name and password
 *              Date: Friday, May 13, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.Common.Classes
{
    public class SecurityRequestFields
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string RoleName { get; set; }
    }
}
