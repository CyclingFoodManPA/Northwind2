/*****************************************************************************
 *         Enum Name: CustomerSearchFields
 *  Class Decription: Contains search fields for Customer
 *              Date: Friday, July 1, 2016
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
    public class CustomerSearchFields : SearchBase
    {
        public string CustomerName { get; set; }
        public string ContactName { get; set; }
        public int ContactTitleID { get; set; }
        public string ContactTitleName { get; set; }
        public string Address1 { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string PostalCode { get; set; }
        public int CountryID { get; set; }
        public string CountryName { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
        public bool IsActive { get; set; }
    }
}