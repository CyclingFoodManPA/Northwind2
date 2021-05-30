using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class vw_InvoiceSubtotals
    {
        public int InvoiceID { get; set; }
        public Nullable<decimal> Subtotal { get; set; }
    }
}
