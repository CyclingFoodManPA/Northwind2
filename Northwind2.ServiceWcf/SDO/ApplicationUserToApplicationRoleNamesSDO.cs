/*****************************************************************************
 *        Class Name: ApplicationUserToApplicationRoleSDO
 *  Class Decription: Contains the ApplicationUserToApplicationRoleSDO 
 *                    information for the service
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Runtime.Serialization;
using Northwind2.Common.Constants;

namespace Northwind2.ServiceWcf.SDO
{
    [DataContract(Namespace = Constants.NAMESPACE, IsReference = true)]
    public class ApplicationUserToApplicationRoleNamesSDO
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
        [DataMember(Order = 5)]
        public string ApplicationRoleName { get; set; }
    }
}
