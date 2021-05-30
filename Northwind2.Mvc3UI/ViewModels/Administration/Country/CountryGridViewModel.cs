/*****************************************************************************
 *        Class Name: CountryGridViewModel
 *  Class Decription: Inherits from GridViewModelBase to display list
 *					  of Countries.
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford 
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;
using System.Collections.Generic;

namespace Northwind2.Mvc3UI.ViewModels.Administration
{
    public class CountryGridViewModel : GridViewModelBase
    {
        public CountryGridViewModel()
            : base()
        {
            this.SearchName = string.Empty;
        }

        // Data properties
        public IEnumerable<CountrySDO> Countrys { get; set; }

        // Filtering-related properties
        public string SearchName { get; set; }
    }
}