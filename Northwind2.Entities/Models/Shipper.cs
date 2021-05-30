using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class Shipper
    {
        public Shipper()
        {
            this.Invoices = new List<Invoice>();
        }

        public int ShipperID { get; set; }
        public string ShipperName { get; set; }
        public string Phone { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ICollection<Invoice> Invoices { get; set; }
    }
}
