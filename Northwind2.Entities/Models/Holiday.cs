using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class Holiday
    {
        public int HolidayID { get; set; }
        public System.DateTime HolidayDate { get; set; }
        public int HolidayDescriptionID { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual HolidayDescription HolidayDescription { get; set; }
    }
}
