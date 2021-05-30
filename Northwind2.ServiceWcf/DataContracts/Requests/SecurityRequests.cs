/*****************************************************************************
 *        Class Name: SecurityRequest
 *  Class Decription: Contains request functionality for security
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Runtime.Serialization;
using Northwind2.Common.Constants;

namespace Northwind2.ServiceWcf.DataContracts.Requests
{
    [DataContract(Name = "LoginRequest", Namespace = Constants.NAMESPACE)]
    public class LoginRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public string Username { get; set; }

        [DataMember(Order = 2, IsRequired = false)]
        public string Password { get; set; }
    }

    [DataContract(Name = "UserInRoleRequest", Namespace = Constants.NAMESPACE)]
    public class UserInRoleRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public string Username { get; set; }

        [DataMember(Order = 2, IsRequired = false)]
        public string RoleName { get; set; }
    }
}
