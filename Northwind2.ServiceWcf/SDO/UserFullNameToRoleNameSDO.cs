/*****************************************************************************
 *        Class Name: UserFullNameToRoleNameSDO
 *  Class Decription: Contains the UserFullNameToRoleNameSDO
 *                    information for the service
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Runtime.Serialization;

namespace Northwind2.ServiceWcf.SDO
{
    public class UserFullNameToRoleNameSDO
    {
        [DataMember(Order = 0)]
        public int ApplicationUserID { get; set; }
        [DataMember(Order = 1)]
        public string ApplicationUserLastName { get; set; }
        [DataMember(Order = 2)]
        public string ApplicationUserFirstName { get; set; }
        [DataMember(Order = 3)]
        public string Username { get; set; }
        [DataMember(Order = 4)]
        public int ApplicationRoleID { get; set; }
        [DataMember(Order = 4)]
        public string ApplicationRoleName { get; set; }
    }
}