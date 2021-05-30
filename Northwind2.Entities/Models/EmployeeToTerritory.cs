using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class EmployeeToTerritory
    {
        public int EmployeeToTerritoryID { get; set; }
        public int EmployeeID { get; set; }
        public int TerritoryID { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual Employee Employee { get; set; }
        public virtual Territory Territory { get; set; }
    }
}
