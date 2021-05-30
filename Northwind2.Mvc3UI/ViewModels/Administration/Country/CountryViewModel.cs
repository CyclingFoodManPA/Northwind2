/*****************************************************************************
 *        Class Name: CountryViewModel
 *  Class Decription: Inherits from NameViewModelBase for displaying and 
 *                    editing a Country.
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford 
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;
using Northwind2.Mvc3UI.ViewModels;

namespace Northwind2.Mvc3UI.ViewModels.Administration
{
    public class CountryViewModel : ViewModelBase
    {
        public CountryViewModel()
        {
            this.Customers = new HashSet<ListItemSDO>();
            this.Suppliers = new HashSet<ListItemSDO>();
        }

        [Key]
        [Display(Name = "CountryID:")]
        public int CountryID { get; set; }

        [Display(Name = "CountryName:")]
        [Required(ErrorMessage = "Name is required.")]
        [StringLength(40, MinimumLength = 2, ErrorMessage = "Name must be between 2 and 40 characters.")]
        public string CountryName { get; set; }

        public override string ToString()
        {
            return CountryID.ToString() + " " + CountryName.Trim();
        }

        public virtual ICollection<ListItemSDO> Customers { get; set; }
        public virtual ICollection<ListItemSDO> Suppliers { get; set; }
    }
}