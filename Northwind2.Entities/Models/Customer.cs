using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class Customer
    {
        public Customer()
        {
            this.Invoices = new List<Invoice>();
        }

        public int CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string ContactName { get; set; }
        public int ContactTitleID { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string PostalCode { get; set; }
        public int CountryID { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
        public string CustomerIDOld { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ContactTitle ContactTitle { get; set; }
        public virtual Country Country { get; set; }
        public virtual ICollection<Invoice> Invoices { get; set; }
    }
}
