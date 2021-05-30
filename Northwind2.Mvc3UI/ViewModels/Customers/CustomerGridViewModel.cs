/*****************************************************************************
 *        Class Name: CustomerGridViewModel
 *  Class Decription: Inherits from GridViewModelBase to display list
 *					  of Customers.
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford 
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;
using System.Web.Mvc;
using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;

namespace Northwind2.Mvc3UI.ViewModels.Customers
{
    public class CustomerGridViewModel : GridViewModelBase
    {
        // ConstruPublic Constructor
        public CustomerGridViewModel()
            : base()
        {
            // Define any default values here...
            this.SearchName = string.Empty;
        }

        // Data properties
        public IEnumerable<CustomerSDO> Customers { get; set; }

        // Filtering-related properties
        public string SearchName { get; set; }
        public int? ContactTitleID { get; set; }
        public int? CountryID { get; set; }
        public IEnumerable<SelectListItem> ContactTitleList { get; set; }
        public IEnumerable<SelectListItem> CountryList { get; set;}
    }
}