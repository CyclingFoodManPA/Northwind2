/*****************************************************************************
 *         Enum Name: EmployeeSearchFields
 *  Class Decription: Contains search fields for Employee
 *              Date: Friday, July 8, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using Northwind2.Common.Classes.Infrastructure;

namespace Northwind2.Common.Classes
{
    public class EmployeeSearchFields : SearchBase
    {
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public int TitleID { get; set; }
        public string TitleName { get; set; }
        public int TitleOfCourtesyID { get; set; }
        public string TitleOfCourtesyName { get; set; }
        public DateTime BirthDate { get; set; }
        public DateTime HireDate { get; set; }
        public string Address1 { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string PostalCode { get; set; }
        public int CountryID { get; set; }        
        public string CountryName { get; set; }
        public string HomePhone { get; set; }
        public string Extension { get; set; }
        public int? ReportsToID { get; set; }
        public bool IsActive { get; set; }
    }
}