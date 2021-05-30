/*****************************************************************************
 *        Class Name: ApplicationUserSDO
 *  Class Decription: Contains the ApplicationUserSDO information for the service
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Northwind2.Common.Constants;

namespace Northwind2.ServiceWcf.SDO
{
    [DataContract(Namespace = Constants.NAMESPACE, IsReference = true)]
    [KnownType(typeof(ApplicationUserToApplicationRoleNamesSDO))]
    public class ApplicationUserSDO
    {
        public ApplicationUserSDO()
        {
            this.ApplicationUserToApplicationRoles = new HashSet<ApplicationUserToApplicationRoleNamesSDO>();
        }

        [DataMember(Order = 0)]
        public int ApplicationUserID { get; set; }
        [DataMember(Order = 1)]
        public string LastName { get; set; }
        [DataMember(Order = 2)]
        public string FirstName { get; set; }
        [DataMember(Order = 3)]
        public string Username { get; set; }
        [DataMember(Order = 4)]
        public string Password { get; set; }
        [DataMember(Order = 5)]
        public string Email { get; set; }
        [DataMember(Order = 6)]
        public Nullable<DateTime> LastLoginDate { get; set; }
        [DataMember(Order = 7)]
        public Nullable<DateTime> LastActivityDate { get; set; }
        [DataMember(Order = 8)]
        public DateTime LastPasswordChangeDate { get; set; }
        [DataMember(Order = 9)]
        public string AddedBy { get; set; }
        [DataMember(Order = 10)]
        public DateTime AddedDate { get; set; }
        [DataMember(Order = 11)]
        public string ModifiedBy { get; set; }
        [DataMember(Order = 12)]
        public DateTime ModifiedDate { get; set; }
        [DataMember(Order = 13)]
        public byte[] Modified { get; set; }

        [DataMember(Order = 14)]
        public virtual ICollection<ApplicationUserToApplicationRoleNamesSDO> ApplicationUserToApplicationRoles { get; set; }
    }
}
