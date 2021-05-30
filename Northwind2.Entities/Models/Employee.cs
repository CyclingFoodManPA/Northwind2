using System;
using System.Collections.Generic;

namespace Northwind2.Entities.Models
{
    public partial class Employee
    {
        public Employee()
        {
            this.EmployeeToTerritories = new List<EmployeeToTerritory>();
            this.Invoices = new List<Invoice>();
        }

        public int EmployeeID { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public int TitleID { get; set; }
        public int TitleOfCourtesyID { get; set; }
        public System.DateTime BirthDate { get; set; }
        public System.DateTime HireDate { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string PostalCode { get; set; }
        public int CountryID { get; set; }
        public string HomePhone { get; set; }
        public string Extension { get; set; }
        public byte[] Picture { get; set; }
        public string Notes { get; set; }
        public Nullable<int> ReportsToID { get; set; }
        public string PicturePath { get; set; }
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        public System.DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public System.DateTime ModifiedDate { get; set; }
        public byte[] Modified { get; set; }
        public virtual Country Country { get; set; }
        public virtual ICollection<EmployeeToTerritory> EmployeeToTerritories { get; set; }
        public virtual ICollection<Invoice> Invoices { get; set; }
        public virtual Title Title { get; set; }
        public virtual TitleOfCourtesy TitleOfCourtesy { get; set; }
    }
}
