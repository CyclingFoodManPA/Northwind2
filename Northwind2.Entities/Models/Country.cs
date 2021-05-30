using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class Country
    {
        public Country()
        {
            this.Customers = new List<Customer>();
            this.Employees = new List<Employee>();
            this.Invoices = new List<Invoice>();
            this.Suppliers = new List<Supplier>();
        }

        public int CountryID { get; set; }
        public string CountryName { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ICollection<Customer> Customers { get; set; }
        public virtual ICollection<Employee> Employees { get; set; }
        public virtual ICollection<Invoice> Invoices { get; set; }
        public virtual ICollection<Supplier> Suppliers { get; set; }
    }
}
