using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class ApplicationUser
    {
        public ApplicationUser()
        {
            this.ApplicationUserToApplicationRoles = new List<ApplicationUserToApplicationRole>();
        }

        public int ApplicationUserID { get; set; }
        public string ApplicationUserLastName { get; set; }
        public string ApplicationUserFirstName { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public Nullable<System.DateTime> LastLoginDate { get; set; }
        public Nullable<System.DateTime> LastActivityDate { get; set; }
        public System.DateTime LastPasswordChangeDate { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ICollection<ApplicationUserToApplicationRole> ApplicationUserToApplicationRoles { get; set; }
    }
}
