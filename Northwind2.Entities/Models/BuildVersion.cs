using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class BuildVersion
    {
        public int BuildVersionID { get; set; }
        public string DatabaseVersion { get; set; }
        public System.DateTime VersionDate { get; set; }
        public System.DateTime ModifiedDate { get; set; }
    }
}
