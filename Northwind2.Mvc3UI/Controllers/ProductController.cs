/*****************************************************************************
 *        Class Name: ProductController
 *  Class Decription: Inherits from Controller in System.Web.Mvc for 
 *					  CRUD events for CotnactTitle
 *              Date: Wednesday, July 6, 2016
 *            Author: ksafford        
 *            
 *  http://www.userinexperience.com/?p=568
 *  http://lostechies.com/jimmybogard/2009/09/18/the-case-for-two-way-mapping-in-automapper/
 *  http://www.codeproject.com/Articles/576393/Solutionplusto-3aplus-22Theplusoperationplusfailed
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Linq;
using System.Web.Mvc;
using AutoMapper;
using log4net;
using Northwind2.Common.Classes;
using Northwind2.Common.Constants;
using Northwind2.Common.Infrastructure;
using Northwind2.Mvc3UI.ViewModels.Products;
using Northwind2SvcRef = Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;

namespace Northwind2.Mvc3UI.Controllers
{
    [Authorize(Roles = "Administrator, Product")]
    public class ProductController : Controller
    {
        #region Private Member Variables

        private readonly Northwind2SvcRef.INorthwind2Service _proxy;

        private readonly ILog _log;
        private const string THIS_CONTROLLER = "ProductController";
        private bool _testing = false;

        #endregion Private Member Variables

        #region Public Methods

        public bool Testing
        {
            get { return _testing; }
            set { _testing = value; }
        }

        #endregion Public Methods

        #region Public Constructor

        public ProductController(Northwind2SvcRef.INorthwind2Service northwind2Service)
        {
            //Get _logger for ProductService
            _log = LogManager.GetLogger(typeof(ProductController));
            _log.Debug(THIS_CONTROLLER + ": Public Constructor");

            try
            {
                _proxy = northwind2Service;
            }
            catch (Exception ex)
            {
                string msg = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(msg);
            }
        }

        #endregion Public Constructor

        #region Index

        public ActionResult Index(string sortBy = "ProductName", bool ascending = true, int page = 1, string searchName = "", int selectedSupplier = -1, int selectedCategory = -1)
        {
            _log.Info(THIS_CONTROLLER + " Index Call");
            string message = string.Empty;

            var model = new ProductGridViewModel()
            {
                // Sorting-related properties
                SortBy = sortBy,
                SortAscending = ascending,

                // Paging-related properties
                CurrentPageIndex = page,

                // Search-related properties
                SearchName = searchName,
                SupplierID = selectedSupplier,
                CategoryID = selectedCategory
            };

            Northwind2SvcRef.ProductsGetBySearchRequest searchRequest = new Northwind2SvcRef.ProductsGetBySearchRequest
            {
                ProductSearchFields = null,
                PaginationRequest = null
            };

            Northwind2SvcRef.ProductListResponse resp = _proxy.ProductGetAll(searchRequest);

            // Get the results
            var results = resp.Products.AsQueryable();

            // Filter
            var predicate = PredicateBuilder.True<Northwind2SvcRef.ProductSDO>();

            if ((searchName != "") || (searchName != string.Empty))
                predicate = predicate.And(p => p.ProductName.ToLower().Contains(searchName.ToLower()));

            if (selectedSupplier != -1)
                predicate = predicate.And(p => p.SupplierID == selectedSupplier);

            if (selectedCategory != -1)
                predicate = predicate.And(p => p.CategoryID == selectedCategory);

            var filteredResults = results.Where(predicate);

            // Determine the total number of FILTERED products being paged through (needed to compute PageCount)
            model.TotalRecordCount = filteredResults.Count();

            // Populate filter drop down lists
            //PopulateProductDropDownLists(ref message, selectedSupplier, selectedCategory);

            // Get the current page of sorted, filtered products         
            model.Products = filteredResults
                //.OrderBy(model.SortExpression)                
                .Skip((model.CurrentPageIndex - 1) * model.PageSize)
                .Take(model.PageSize);

            return View(model);
        }

        #endregion Index


        #region Utility Routines

        private void PopulateProductDropDownLists(ref string message, object selectedSupplier = null, object selectedCategory = null)
        {
            PopulateSupplierDropDownList(ref message, selectedSupplier);
            PopulateCategoryDropDownList(ref message, selectedCategory);
        }

        private void PopulateSupplierDropDownList(ref string message, object selectedSupplier = null)
        {
            try
            {
                Northwind2SvcRef.SupplierSelectListResponse respSupplier = _proxy.SupplierGetAllList();
                ViewBag.SelectedSupplier = new SelectList(respSupplier.SupplierSelectList, "ID", "Name", selectedSupplier);
            }
            catch (Exception e)
            {
                message = ExceptionHelpers.GetAllMessages(e);
            }
        }

        private void PopulateCategoryDropDownList(ref string message, object selectedCategory = null)
        {
            try
            {
                Northwind2SvcRef.CategorySelectListResponse respCategory = _proxy.CategoryGetAllList();
                ViewBag.SelectedCountry = new SelectList(respCategory.CategorySelectList, "ID", "Name", selectedCategory);
            }
            catch (Exception e)
            {
                message = ExceptionHelpers.GetAllMessages(e);
            }
        }

        #endregion Utility Routines
    }
}
