/*****************************************************************************
 *        Class Name: ApplicationRoleSDO
 *  Class Decription: Contains the ApplicationRoleSDO information for the service
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
    public class ApplicationRoleSDO
    {
        public ApplicationRoleSDO()
        {
            this.ApplicationUserToApplicationRoleNamesSDOs = new HashSet<ApplicationUserToApplicationRoleNamesSDO>();
        }

        [DataMember(Order = 0)]
        public int ApplicationRoleID { get; set; }
        [DataMember(Order = 1)]
        public string ApplicationRoleName { get; set; }
        [DataMember(Order = 2)]
        public string AddedBy { get; set; }
        [DataMember(Order = 3)]
        public DateTime AddedDate { get; set; }
        [DataMember(Order = 4)]
        public string ModifiedBy { get; set; }
        [DataMember(Order = 5)]
        public DateTime ModifiedDate { get; set; }
        [DataMember(Order = 6)]
        public byte[] Modified { get; set; }

        [DataMember(Order = 7)]
        public virtual ICollection<ApplicationUserToApplicationRoleNamesSDO> ApplicationUserToApplicationRoleNamesSDOs { get; set; }
    }
}