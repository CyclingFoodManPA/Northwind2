using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class Title
    {
        public Title()
        {
            this.Employees = new List<Employee>();
        }

        public int TitleID { get; set; }
        public string TitleName { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ICollection<Employee> Employees { get; set; }
    }
}
