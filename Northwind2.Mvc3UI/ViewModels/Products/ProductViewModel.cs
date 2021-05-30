/*****************************************************************************
 *        Class Name: ProductViewModel
 *  Class Decription: For displaying and editing a Product.
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford 
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.Mvc3UI.ViewModels.Products
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using Northwind2.Mvc3UI.ViewModels;
    using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;

    public class ProductViewModel : ViewModelBase
    {
        #region ConstruPublic Constructor

        public ProductViewModel()
        {
            this.InvoiceItems = new HashSet<ListItemSDO>();
        }

        #endregion ConstruPublic Constructor

        #region Primitive Properties

        [Key]
        [Display(Name = "ProductID:")]
        public int ProductID { get; set; }

        [Display(Name = "ProductName:")]
        [Required(ErrorMessage = "ProductName is required.")]
        [StringLength(40, MinimumLength = 2, ErrorMessage = "ProductName must be between 2 and 40 characters.")]
        public string ProductName { get; set; }

        [Required(ErrorMessage = "Supplier is required.")]
        public int SupplierID { get; set; }

        [Required(ErrorMessage = "Category is required.")]
        public int CategoryID { get; set; }        [Required(ErrorMessage = "ProductName is required.")]
        
        [Display(Name = "QuantityPerUnit")]
        [StringLength(20, MinimumLength = 2, ErrorMessage = "Quantity Per Unit 2 and 20 characters.")]
        public virtual string QuantityPerUnit { get; set; }

        [Display(Name = "UnitPrice:")]
        [Required(ErrorMessage = "UnitPrice is required.")]
        public virtual string Address2 { get; set; }

        [Display(Name = "UnitsInStock:")]
        [Required(ErrorMessage = "UnitsInStock is required.")]
        public virtual int UnitsInStock { get; set; }

        [Display(Name = "UnitsOnOrder:")]
        [Required(ErrorMessage = "UnitsOnOrder is required.")]
        public virtual int UnitsOnOrder { get; set; }

        [Display(Name = "ReorderLevel:")]
        [Required(ErrorMessage = "ReorderLevel is required.")]
        public virtual int ReorderLevel { get; set; }

        public bool IsActive { get; set; }

        #endregion Primitive Properties

        #region Overrides

        public override string ToString()
        {
            return ProductID.ToString() + " " + ProductName;
        }

        #endregion Overrides

        #region Navigation Properties

        public virtual ICollection<ListItemSDO> InvoiceItems { get; set; }

        #endregion Navigation Properties
    }
}