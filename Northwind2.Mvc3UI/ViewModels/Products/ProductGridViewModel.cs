/*****************************************************************************
 *        Class Name: ProductGridViewModel
 *  Class Decription: Inherits from GridViewModelBase to display list
 *					  of Products.
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

namespace Northwind2.Mvc3UI.ViewModels.Products
{
    public class ProductGridViewModel : GridViewModelBase
    {
        // ConstruPublic Constructor
        public ProductGridViewModel()
            : base()
        {
            // Define any default values here...
            this.SearchName = string.Empty;
        }

        // Data properties
        public IEnumerable<ProductSDO> Products { get; set; }

        // Filtering-related properties
        public string SearchName { get; set; }
        public int? SupplierID { get; set; }
        public int? CategoryID { get; set; }
        public IEnumerable<SelectListItem> SupplierList { get; set; }
        public IEnumerable<SelectListItem> CategoryList { get; set; }
    }
}