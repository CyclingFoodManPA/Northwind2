using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class ApplicationRole
    {
        public ApplicationRole()
        {
            this.ApplicationUserToApplicationRoles = new List<ApplicationUserToApplicationRole>();
        }

        public int ApplicationRoleID { get; set; }
        public string ApplicationRoleName { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ICollection<ApplicationUserToApplicationRole> ApplicationUserToApplicationRoles { get; set; }
    }
}
