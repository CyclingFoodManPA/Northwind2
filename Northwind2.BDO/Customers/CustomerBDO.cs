/*****************************************************************************
 *        Class Name: CustomerBDO
 *  Class Decription: Contains the Customer information from the DB
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;

namespace Northwind2.BDO
{
    public class CustomerBDO : EntityBaseBDO
    {
        public CustomerBDO()
        {
            Invoices = new HashSet<ListItemBDO>();
        }

        public int CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string ContactName { get; set; }
        public int ContactTitleID { get; set; }
        public string ContactTitleName { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string PostalCode { get; set; }
        public int CountryID { get; set; }
        public string CountryName { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
        public string CustomerIDOld { get; set; }
        public bool IsActive { get; set; }

        public virtual ICollection<ListItemBDO> Invoices { get; set; }
    }
}
