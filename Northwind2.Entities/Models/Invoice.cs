using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class Invoice
    {
        public Invoice()
        {
            this.InvoiceItems = new List<InvoiceItem>();
        }

        public int InvoiceID { get; set; }
        public int CustomerID { get; set; }
        public int EmployeeID { get; set; }
        public System.DateTime InvoiceDate { get; set; }
        public Nullable<System.DateTime> RequiredDate { get; set; }
        public Nullable<System.DateTime> ShippedDate { get; set; }
        public int ShipperID { get; set; }
        public decimal Freight { get; set; }
        public string ShipName { get; set; }
        public string ShipAddress1 { get; set; }
        public string ShipAddress2 { get; set; }
        public string ShipCity { get; set; }
        public string ShipRegion { get; set; }
        public string ShipPostalCode { get; set; }
        public int CountryID { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual Country Country { get; set; }
        public virtual Customer Customer { get; set; }
        public virtual Employee Employee { get; set; }
        public virtual ICollection<InvoiceItem> InvoiceItems { get; set; }
        public virtual Shipper Shipper { get; set; }
    }
}
