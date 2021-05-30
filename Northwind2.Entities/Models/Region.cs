using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class Region
    {
        public Region()
        {
            this.Territories = new List<Territory>();
        }

        public int RegionID { get; set; }
        public string RegionName { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ICollection<Territory> Territories { get; set; }
    }
}
