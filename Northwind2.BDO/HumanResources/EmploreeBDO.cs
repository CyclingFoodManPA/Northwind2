/*****************************************************************************
 *        Class Name: EmployeeBDO
 *  Class Decription: Contains the Employee information from the DB
 *              Date: Friday, July 8, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Collections.Generic;

namespace Northwind2.BDO
{
    public class EmployeeBDO : EntityBaseBDO
    {
        public EmployeeBDO()
        {
            Invoices = new HashSet<ListItemBDO>();
        }

        public int EmployeeID { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public int TitleID { get; set; }
        public string TitleName { get; set; }
        public int TitleOfCourtesyID { get; set; }
        public string TitleOfCourtesyName { get; set; }
        public System.DateTime BirthDate { get; set; }
        public System.DateTime HireDate { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string PostalCode { get; set; }
        public int CountryID { get; set; }
        public string CountryName { get; set; }
        public string HomePhone { get; set; }
        public string Extension { get; set; }
        public byte[] Picture { get; set; }
        public string Notes { get; set; }
        public int? ReportsToID { get; set; }
        public string PicturePath { get; set; }
        public bool IsActive { get; set; }

        public virtual ICollection<ListItemBDO> Invoices { get; set; }
    }
}
