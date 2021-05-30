/*****************************************************************************
 *        Class Name: SecurityResponse
 *  Class Decription: Contains response functionality for Security
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;
using System.Runtime.Serialization;
using Northwind2.Common.Constants;
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.Other.DataContracts.Responses
{
    [DataContract(Name = "LoginResponse", Namespace = Constants.NAMESPACE)]
    public class LoginResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public bool IsValid { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public string ErrorMessage { get; set; }
    }

    [DataContract(Name = "UserInRoleResponse", Namespace = Constants.NAMESPACE)]
    public class UserInRoleResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public bool IsInRole { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public string ErrorMessage { get; set; }
    }

    [DataContract(Name = "UserInRolesResponse", Namespace = Constants.NAMESPACE)]
    public class UserInRolesResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public UserToRoleNames UserToRoleNames { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }

    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = " UserToRoleNames", ItemName = "UserToRoleNameSDO")]
    public class UserToRoleNames : List<UserFullNameToRoleNameSDO> { }
}
