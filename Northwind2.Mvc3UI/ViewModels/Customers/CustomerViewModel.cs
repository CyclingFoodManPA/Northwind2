/*****************************************************************************
 *        Class Name: CustomerViewModel
 *  Class Decription: For displaying and editing a Customer.
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford 
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.Mvc3UI.ViewModels.Customers
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using Northwind2.Mvc3UI.ViewModels;
    using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;

    public class CustomerViewModel : ViewModelBase
    {
        #region ConstruPublic Constructor

        public CustomerViewModel()
        {
            this.Invoices = new HashSet<ListItemSDO>();
        }

        #endregion ConstruPublic Constructor

        #region Primitive Properties

        [Key]
        [Display(Name = "CustomerID:")]
        public int CustomerID { get; set; }

        [Display(Name = "CustomerName:")]
        [Required(ErrorMessage = "CustomerName is required.")]
        [StringLength(40, MinimumLength = 2, ErrorMessage = "CustomerName must be between 2 and 50 characters.")]
        public string CustomerName { get; set; }

        [Display(Name = "ContactName:")]
        [Required(ErrorMessage = "ContactName is required.")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "ContactName must be between 2 and 50 characters.")]
        public string ContactName { get; set; }
        public int ContactTitleID { get; set; }

        [Display(Name = "Address1:")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "Address1 must be between 2 and 50 characters.")]
        public virtual string Address1  { get; set; }

        [Display(Name = "Address2:")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "Address2 must be between 2 and 50 characters.")]
        public virtual string Address2 { get; set; }
              
        [Display(Name = "City:")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "City must be between 2 and 50 characters.")]
        public virtual string City { get; set; }

        [Display(Name = "Region:")]
        [StringLength(15, MinimumLength = 2, ErrorMessage = "Region must be between 2 and 15 characters.")]
        public virtual string Region { get; set; }

        [Display(Name = "PostalCode:")]
        [StringLength(10, MinimumLength = 2, ErrorMessage = "PostalCode must be between 2 and 10 characters.")]
        public virtual string PostalCode { get; set; }

        public int CountryID { get; set; }

        [Display(Name = "Phone:")]
        [StringLength(40,
                      MinimumLength = 10,
                      ErrorMessage = "Phone must be between 10 and 40 characters.")]
        public string Phone { get; set; }

        [Display(Name = "Fax:")]
        [StringLength(40,
                      MinimumLength = 10,
                      ErrorMessage = "Fax must be between 10 and 40 characters.")]
        public string Fax { get; set; }

        [Display(Name = "Fax:")]
        [StringLength(100,
                      MinimumLength = 0,
                      ErrorMessage = "Email must be between 0 and 100 characters.")]
        public string Email { get; set; }

        public string CustomerIDOld { get; set; }

        public bool IsActive { get; set; }

        #endregion Primitive Properties

        #region Overrides

        public override string ToString()
        {
            return CustomerID.ToString() + " " + CustomerName;
        }

        #endregion Overrides

        #region Navigation Properties

        public virtual ICollection<ListItemSDO>  Invoices { get; set; }

        #endregion Navigation Properties
    }
}