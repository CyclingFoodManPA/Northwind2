using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class Product
    {
        public Product()
        {
            this.InvoiceItems = new List<InvoiceItem>();
        }

        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public int SupplierID { get; set; }
        public int CategoryID { get; set; }
        public string QuantityPerUnit { get; set; }
        public decimal UnitPrice { get; set; }
        public int UnitsInStock { get; set; }
        public int UnitsOnOrder { get; set; }
        public int ReorderLevel { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual Category Category { get; set; }
        public virtual ICollection<InvoiceItem> InvoiceItems { get; set; }
        public virtual Supplier Supplier { get; set; }
    }
}
