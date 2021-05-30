using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class ApplicationUserToApplicationRole
    {
        public int ApplicationUserToApplicationRoleID { get; set; }
        public int ApplicationRoleID { get; set; }
        public int ApplicationUserID { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ApplicationRole ApplicationRole { get; set; }
        public virtual ApplicationUser ApplicationUser { get; set; }
    }
}
