﻿/*****************************************************************************
 *        Class Name: ContactTitleController
 *  Class Decription: Inherits from Controller in System.Web.Mvc for 
 *					  CRUD events for CotnactTitle
 *              Date: Tuesday, July 5, 2016
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
using Northwind2.Common.Constants;
using Northwind2.Common.Infrastructure;
using Northwind2.Mvc3UI.ViewModels.Administration;
using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;
using Northwind2ServiceReference = Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;

namespace Northwind2.Mvc3UI.Controllers
{
    [Authorize(Roles = "Administrator")]
    public class ContactTitleController : Controller
    {
        #region Private Member Variables

        private readonly INorthwind2Service _proxy;

        private readonly ILog _log;
        private const string THIS_CONTROLLER = "ContactTitleController";
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

        public ContactTitleController(INorthwind2Service northwind2Service)
        {
            //Get _logger for ContactTitleService
            _log = LogManager.GetLogger(typeof(ContactTitleController));
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

        public ActionResult Index(string sortBy = "ContactTitleName", bool ascending = true, int page = 1, string searchName = "")
        {
            _log.Info(THIS_CONTROLLER + " Index Call");
            string message = string.Empty;

            var model = new ContactTitleGridViewModel()
            {
                // Sorting-related properties
                SortBy = sortBy,
                SortAscending = ascending,

                // Paging-related properties
                CurrentPageIndex = page,

                // Search-related properties
                SearchName = searchName
            };

            // Arrange - prepare request      
            Northwind2ServiceReference.ContactTitlesGetBySearchRequest request = new Northwind2ServiceReference.ContactTitlesGetBySearchRequest
            {
                ContactTitleSearchText = null,
                PaginationRequest = null
            };

            Northwind2ServiceReference.ContactTitleListResponse resp = _proxy.ContactTitleGetAll(request);

            // Filter the results
            var results = resp.ContactTitles.AsQueryable();
            if (searchName != "")
                results = results
                    .Where(ct => ct.ContactTitleName.ToUpper().Contains(searchName.ToUpper()));

            // Determine the total number of FILTERED products being paged through (needed to compute PageCount)
            model.TotalRecordCount = results.Count();

            // Get the current page of sorted, filtered products
            model.ContactTitles = results
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
                Northwind2ServiceReference.QueryByIdRequest inputItem = new Northwind2ServiceReference.QueryByIdRequest { Id = id };
                Northwind2ServiceReference.ContactTitleResponse resp = _proxy.ContactTitleGetByID(inputItem);

                Northwind2ServiceReference.ContactTitleSDO model = resp.ContactTitle;

                if (model == null)
                {
                    message = "ContactTitle for Id = " + id.ToString() + " not found";
                    TempData["message"] = string.Format("{0}", message);

                    return RedirectToAction("Index");
                }

                Mapper.CreateMap<Northwind2ServiceReference.ContactTitleSDO, ContactTitleViewModel>();
                var viewModel = Mapper.Map<Northwind2ServiceReference.ContactTitleSDO, ContactTitleViewModel>(model);

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
                Northwind2ServiceReference.QueryByIdRequest inputItem = new Northwind2ServiceReference.QueryByIdRequest { Id = id };
                Northwind2ServiceReference.ContactTitleResponse resp = _proxy.ContactTitleGetByID(inputItem);

                Northwind2ServiceReference.ContactTitleSDO model = resp.ContactTitle;

                if (model == null)
                {
                    message = "ContactTitle for Id = " + id.ToString() + " not found";
                    TempData["message"] = string.Format("{0}", message);

                    return RedirectToAction("Index");
                }

                Mapper.CreateMap<Northwind2ServiceReference.ContactTitleSDO, ContactTitleViewModel>();
                var viewModel = Mapper.Map<Northwind2ServiceReference.ContactTitleSDO, ContactTitleViewModel>(model);

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
        public ActionResult Edit_post(ContactTitleViewModel viewModel)
        {
            _log.Info(THIS_CONTROLLER + " Edit_post Call for Id = " + viewModel.ContactTitleID.ToString());
            string message = string.Empty;

            try
            {
                if (!ModelState.IsValid)
                {
                    return View(viewModel);
                }

                Northwind2ServiceReference.QueryByIdRequest inputItem = new Northwind2ServiceReference.QueryByIdRequest { Id = viewModel.ContactTitleID };
                Northwind2ServiceReference.ContactTitleResponse resp = _proxy.ContactTitleGetByID(inputItem);

                if (resp.ContactTitle == null)
                {
                    message = "ContactTitleID= " + viewModel.ContactTitleID + " not found to update!";
                    TempData["message"] = string.Format("{0}", message);

                    return RedirectToAction("Index");
                }

                Mapper.CreateMap<ContactTitleViewModel, Northwind2ServiceReference.ContactTitleSDO>();
                resp.ContactTitle = Mapper.Map<ContactTitleViewModel, Northwind2ServiceReference.ContactTitleSDO>(viewModel);

                resp.ContactTitle.ModifiedBy = string.IsNullOrEmpty(HttpContext.User.Identity.Name)
                    ? Constants.UNKNOWN_USER
                    : HttpContext.User.Identity.Name;

                Northwind2ServiceReference.ContactTitleSaveRequest saveRequest = new Northwind2ServiceReference.ContactTitleSaveRequest { ContactTitle = resp.ContactTitle };
                Northwind2ServiceReference.ReturnNumber saveResponse = _proxy.ContactTitleUpdate(saveRequest);

                if (!(saveResponse.NumberValue == 0))
                {
                    TempData["message"] = string.Format("{0}", saveResponse.Message);

                    return View(viewModel);
                }
                else
                {
                    message = "ContactTitle with ContactTitleID= " + viewModel.ContactTitleID.ToString().Trim() + " updated successfully!";
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
    }
}
