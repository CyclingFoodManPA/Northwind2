/*****************************************************************************
 *        Class Name: ContactTitleViewModel
 *  Class Decription: Inherits from NameViewModelBase for displaying and 
 *                    editing a ContactTitle.
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
    public class ContactTitleViewModel : ViewModelBase
    {
        public ContactTitleViewModel()
        {
            this.Customers = new HashSet<ListItemSDO>();
            this.Suppliers = new HashSet<ListItemSDO>();
        }

        [Key]
        [Display(Name = "ContactTitleID:")]
        public int ContactTitleID { get; set; }

        [Display(Name = "ContactTitleName:")]
        [Required(ErrorMessage = "Name is required.")]
        [StringLength(40, MinimumLength = 2, ErrorMessage = "Name must be between 2 and 40 characters.")]
        public string ContactTitleName { get; set; }

        public override string ToString()
        {
            return ContactTitleID.ToString() + " " + ContactTitleName.Trim();
        }

        public virtual ICollection<ListItemSDO> Customers { get; set; }
        public virtual ICollection<ListItemSDO> Suppliers { get; set; }
    }
}