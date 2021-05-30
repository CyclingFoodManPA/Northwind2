/*****************************************************************************
 *        Class Name: CustomerController
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
using Northwind2.Mvc3UI.ViewModels.Customers;
using Northwind2SvcRef = Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;

namespace Northwind2.Mvc3UI.Controllers
{
    [Authorize(Roles = "Administrator, Customer")]
    public class CustomerController : Controller
    {
        #region Private Member Variables

        private readonly Northwind2SvcRef.INorthwind2Service _proxy;

        private readonly ILog _log;
        private const string THIS_CONTROLLER = "CustomerController";
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

        public CustomerController(Northwind2SvcRef.INorthwind2Service northwind2Service)
        {
            //Get _logger for CustomerService
            _log = LogManager.GetLogger(typeof(CustomerController));
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

        public ActionResult Index(string sortBy = "CustomerName", bool ascending = true, int page = 1, string searchName = "", int selectedContactTitle = -1, int selectedCountry = -1)
        {
            _log.Info(THIS_CONTROLLER + " Index Call");
            string message = string.Empty;

            var model = new CustomerGridViewModel()
            {
                // Sorting-related properties
                SortBy = sortBy,
                SortAscending = ascending,

                // Paging-related properties
                CurrentPageIndex = page,

                // Search-related properties
                SearchName = searchName,
                ContactTitleID = selectedContactTitle,
                CountryID = selectedCountry
            };

            Northwind2SvcRef.CustomersGetBySearchRequest searchRequest = new Northwind2SvcRef.CustomersGetBySearchRequest
            {
                CustomerSearchFields = null,
                PaginationRequest = null                
            };

            Northwind2SvcRef.CustomerListResponse resp = _proxy.CustomerGetAll(searchRequest);

            // Get the results
            var results = resp.Customers.AsQueryable();

            // Filter
            var predicate = PredicateBuilder.True<Northwind2SvcRef.CustomerSDO>();

            if ((searchName != "") || (searchName != string.Empty))
                predicate = predicate.And(c => c.CustomerName.ToLower().Contains(searchName.ToLower()));

            if (selectedContactTitle != -1)
                predicate = predicate.And(c => c.ContactTitleID == selectedContactTitle);
            
            if (selectedCountry != -1)
                predicate = predicate.And(c => c.CountryID == selectedCountry);

            var filteredResults = results.Where(predicate);

            // Determine the total number of FILTERED products being paged through (needed to compute PageCount)
            model.TotalRecordCount = filteredResults.Count();

            // Populate filter drop down lists
            PopulateCustomerDropDownLists(ref message, selectedContactTitle, selectedCountry);

            // Get the current page of sorted, filtered products         
            model.Customers = filteredResults
                //.OrderBy(model.SortExpression)                
                .Skip((model.CurrentPageIndex - 1) * model.PageSize)
                .Take(model.PageSize);

            return View(model);
        }

        #endregion Index

        #region Details

        public ActionResult Details(int id)
        {
            _log.Info(THIS_CONTROLLER + " Details Call for Id = " + id.ToString());
            string message = string.Empty;

            try
            {
                Northwind2SvcRef.QueryByIdRequest inputItem = new Northwind2SvcRef.QueryByIdRequest { Id = id };
                Northwind2SvcRef.CustomerResponse resp = _proxy.CustomerGetByID(inputItem);

                Northwind2SvcRef.CustomerSDO model = resp.Customer;

                if (model == null)
                {
                    message = "Customer for Id = " + id.ToString() + " not found";
                    TempData["message"] = string.Format("{0}", message);

                    return RedirectToAction("Index");
                }

                Mapper.CreateMap<Northwind2SvcRef.CustomerSDO, CustomerViewModel>();
                var viewModel = Mapper.Map<Northwind2SvcRef.CustomerSDO, CustomerViewModel>(model);

                PopulateCustomerDropDownLists(ref message, viewModel.ContactTitleID, viewModel.CountryID);

                return View(viewModel);
            }
            catch (Exception ex)
            {
                _log.Error(THIS_CONTROLLER + " Detail Error - Exception", ex);
                message = ExceptionHelpers.GetAllMessages(ex);
                ModelState.AddModelError(string.Empty, "Something went wrong. Message: " + message);
            }

            TempData["message"] = string.Format("{0}", message);

            return RedirectToAction("Index");
        }

        #endregion Details

        #region Edit

        public ActionResult Edit(int id)
        {
            _log.Info(THIS_CONTROLLER + " Edit Call for Id = " + id.ToString());
            string message = string.Empty;

            try
            {
                Northwind2SvcRef.QueryByIdRequest inputItem = new Northwind2SvcRef.QueryByIdRequest { Id = id };
                Northwind2SvcRef.CustomerResponse resp = _proxy.CustomerGetByID(inputItem);

                Northwind2SvcRef.CustomerSDO model = resp.Customer;

                if (model == null)
                {
                    message = "Customer for Id = " + id.ToString() + " not found";
                    TempData["message"] = string.Format("{0}", message);

                    return RedirectToAction("Index");
                }

                Mapper.CreateMap<Northwind2SvcRef.CustomerSDO, CustomerViewModel>();
                var viewModel = Mapper.Map<Northwind2SvcRef.CustomerSDO, CustomerViewModel>(model);

                PopulateCustomerDropDownLists(ref message, viewModel.ContactTitleID, viewModel.CountryID);

                return View(viewModel);
            }
            catch (Exception ex)
            {
                _log.Error(THIS_CONTROLLER + " Edit Error - Exception", ex);
                message = ExceptionHelpers.GetAllMessages(ex);
                ModelState.AddModelError(string.Empty, "Something went wrong. Message: " + message);
            }

            TempData["message"] = string.Format("{0}", message);

            return RedirectToAction("Index");
        }

        [ActionName("Edit"), HttpPost]
        public ActionResult Edit_post(CustomerViewModel viewModel)
        {
            _log.Info(THIS_CONTROLLER + " Edit_post Call for Id = " + viewModel.CustomerID.ToString());
            string message = string.Empty;

            try
            {
                if (!ModelState.IsValid)
                {
                    return View(viewModel);
                }

                Northwind2SvcRef.QueryByIdRequest inputItem = new Northwind2SvcRef.QueryByIdRequest { Id = viewModel.CustomerID };
                Northwind2SvcRef.CustomerResponse resp = _proxy.CustomerGetByID(inputItem);

                if (resp.Customer == null)
                {
                    message = "CustomerID= " + viewModel.CustomerID + " not found to update!";
                    TempData["message"] = string.Format("{0}", message);

                    return RedirectToAction("Index");
                }

                Mapper.CreateMap<CustomerViewModel, Northwind2SvcRef.CustomerSDO>();
                resp.Customer = Mapper.Map<CustomerViewModel, Northwind2SvcRef.CustomerSDO>(viewModel);

                resp.Customer.ModifiedBy = string.IsNullOrEmpty(HttpContext.User.Identity.Name)
                    ? Constants.UNKNOWN_USER
                    : HttpContext.User.Identity.Name;

                Northwind2SvcRef.CustomerSaveRequest saveRequest = new Northwind2SvcRef.CustomerSaveRequest { Customer = resp.Customer };
                Northwind2SvcRef.ReturnNumber saveResponse = _proxy.CustomerUpdate(saveRequest);

                if (!(saveResponse.NumberValue == 0))
                {
                    TempData["message"] = string.Format("{0}", saveResponse.Message);

                    return View(viewModel);
                }
                else
                {
                    message = "Customer with CustomerID= " + viewModel.CustomerID.ToString().Trim() + " updated successfully!";
                    TempData["message"] = string.Format("{0}", message);

                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                ModelState.AddModelError(string.Empty, "Something went wrong. Message: " + message);
            }

            TempData["message"] = string.Format("{0}", message);

            return View("Edit", viewModel);
        }

        #endregion Edit

        #region Utility Routines

        private void PopulateCustomerDropDownLists(ref string message, object selectedContactTitle = null, object selectedCountry = null)
        {
            PopulateContactTitleDropDownList(ref message, selectedContactTitle);
            PopulateCountryDropDownList(ref message, selectedCountry);
        }

        private void PopulateContactTitleDropDownList(ref string message, object selectedContactTitle = null)
        {
            try
            {
                Northwind2SvcRef.ContactTitleSelectListResponse respContactTitle = _proxy.ContactTitleGetAllList();
                ViewBag.SelectedContactTitle = new SelectList(respContactTitle.ContactTitleSelectList, "ID", "Name", selectedContactTitle);
            }
            catch (Exception e)
            {
                message = ExceptionHelpers.GetAllMessages(e);
            }
        }

        private void PopulateCountryDropDownList(ref string message, object selectedCountry = null)
        {
            try
            {
                Northwind2SvcRef.CountrySelectListResponse respCountry = _proxy.CountryGetAllList();
                ViewBag.SelectedCountry = new SelectList(respCountry.CountrySelectList, "ID", "Name", selectedCountry);
            }
            catch (Exception e)
            {
                message = ExceptionHelpers.GetAllMessages(e);
            }
        }

        #endregion Utility Routines
    }
}
