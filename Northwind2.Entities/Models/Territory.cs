using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class Territory
    {
        public Territory()
        {
            this.EmployeeToTerritories = new List<EmployeeToTerritory>();
        }

        public int TerritoryID { get; set; }
        public string TerritoryCode { get; set; }
        public string TerritoryName { get; set; }
        public int RegionID { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual ICollection<EmployeeToTerritory> EmployeeToTerritories { get; set; }
        public virtual Region Region { get; set; }
    }
}
