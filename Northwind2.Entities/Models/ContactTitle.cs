using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class ContactTitle
    {
        public ContactTitle()
        {
            this.Customers = new List<Customer>();
            this.Suppliers = new List<Supplier>();
        }

        public int ContactTitleID { get; set; }
        public string ContactTitleName { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ICollection<Customer> Customers { get; set; }
        public virtual ICollection<Supplier> Suppliers { get; set; }
    }
}
