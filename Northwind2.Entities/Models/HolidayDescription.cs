using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class HolidayDescription
    {
        public HolidayDescription()
        {
            this.Holidays = new List<Holiday>();
        }

        public int HolidayDescriptionID { get; set; }
        public string HolidayDescriptionName { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ICollection<Holiday> Holidays { get; set; }
    }
}
