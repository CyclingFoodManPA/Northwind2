/*****************************************************************************
 *       Interface Name: Northwind2Service
 * Interface Decription: Contains functionality for the Northwind2Service
 *                 Date: Tuesday, July 5, 2016
 *               Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using log4net;
using Northwind2.BDO;
using Northwind2.BLL.Contracts;
using Northwind2.Common.Classes;
using Northwind2.Common.Constants;
using Northwind2.Entities.Models;
using Northwind2.Repositories.Contracts;
using Northwind2.ServiceWcf.Contracts;
using Northwind2.ServiceWcf.Converters;
using Northwind2.ServiceWcf.Converters.Infrastructure;
using Northwind2.ServiceWcf.DataContracts.Requests;
using Northwind2.ServiceWcf.DataContracts.Responses;
using Northwind2.ServiceWcf.Other.DataContracts.Responses;
using Northwind2.ServiceWcf.SDO;
using Northwind2.ServiceWcf.UnityDI;
using System.Collections.Generic;
using System.ServiceModel;

namespace Northwind2.ServiceWcf.Implementation
{
    [ServiceBehavior(Namespace = Constants.NAMESPACE)]
    public class Northwind2Service : ServiceBase, INorthwind2Service
    {
        #region Private Member Variables

        private const string THIS_CLASS = "Northwind2ServiceWcf";

        #endregion Private Member Variables

        #region Public Constructor

        public Northwind2Service()
            : base()
        {
            //Get _logger for ContactTitleService
            _log = LogManager.GetLogger(typeof(Northwind2Service));
            _log.Debug(THIS_CLASS + ": Constructor Call");
        }

        #endregion Public Constructor

        #region Administration Services

        // Private Routines
        private IContactTitleRepository ContactTitleRepositoryGet()
        {
            // Use runtime configuration for Unity DI
            return DIFactoryForRuntime.Resolve<IContactTitleRepository>();

        }

        private ICountryRepository CountryRepositoryGet()
        {
            // Use runtime configuration for Unity DI
            return DIFactoryForRuntime.Resolve<ICountryRepository>();

        }

        #region ContactTitle Services

        public ReturnNumber ContactTitleAdd(ContactTitleSaveRequest input)
        {
            _log.Info(THIS_CLASS + ": ContactTitleAdd" + " " + input.ContactTitle.ContactTitleName.Trim());

            string message = string.Empty;
            var resp = new ReturnNumber();
            IContactTitleRepository repo = ContactTitleRepositoryGet();

            //Use simple auto mapping
            IBaseConverter<ContactTitleSDO, ContactTitle> convtInput = new AutoMapConverter<ContactTitleSDO, ContactTitle>();
            ContactTitle entity = convtInput.ConvertObject(input.ContactTitle);

            // Add the ContactTitle
            resp.NumberValue = repo.ContactTitleAdd(entity, ref message);
            resp.Message = message;

            return resp;
        }

        public ContactTitleListResponse ContactTitleGetAll(ContactTitlesGetBySearchRequest request)
        {
            string logText = (request.ContactTitleSearchText == null) ? "" : request.ContactTitleSearchText.Trim();
            _log.Debug(THIS_CLASS + ": ContactTitleGetAll; Search by: " + logText);

            var resp = new ContactTitleListResponse();
            string message = string.Empty;
            resp.ContactTitles = new ContactTitles();
            IContactTitleRepository repo = ContactTitleRepositoryGet();

            //Use simple auto mapping
            Common.Classes.PaginationRequest paging = new PaginationAutoMapConverter().ConvertObject(request.PaginationRequest);

            int totalCount = 0;

            // Get the ContactTitle List by search criteria
            IList<ContactTitle> ContactTitleList =
                repo.ContactTitleGetAll(request.ContactTitleSearchText, paging, out totalCount, ref message);

            //Use simple auto mapping
            ContactTitleManualConverterList convertResult = new ContactTitleManualConverterList();
            List<ContactTitleSDO> list = convertResult.ConvertObjectCollection(ContactTitleList);

            resp.ContactTitles.AddRange(list);
            resp.TotalCount = totalCount;
            resp.ErrorMessage = message;

            return resp;
        }

        public ContactTitleSelectListResponse ContactTitleGetAllList()
        {
            _log.Debug(THIS_CLASS + ": ContactTitleGetAllList");

            int totalCount = 0;
            string message = string.Empty;
            var resp = new ContactTitleSelectListResponse();
            resp.ContactTitleSelectList = new ContactTitleSelectList();
            IContactTitleRepository repo = ContactTitleRepositoryGet();

            // Get the ContactTitle List
            IList<ListItem> ContactTitleList = repo.ContactTitleGetAllList(out totalCount, ref message);

            //Use custom configured auto mapping
            ListItemManualConverterEntity convertResult = new ListItemManualConverterEntity();
            List<ListItemSDO> list = convertResult.ConvertObjectCollection(ContactTitleList);
            resp.ContactTitleSelectList.AddRange(list);
            resp.TotalCount = totalCount;

            return resp;
        }

        public ContactTitleResponse ContactTitleGetByID(QueryByIdRequest request)
        {
            _log.Debug(THIS_CLASS + ": ContactTitleGetByID; ContactTitleID = " + request.Id.ToString().Trim());

            string message = string.Empty;
            ContactTitleResponse resp = new ContactTitleResponse();
            IContactTitleRepository repo = ContactTitleRepositoryGet();

            // Get the ContactTitle by the ID   
            ContactTitle entity = repo.ContactTitleGetByID(request.Id, ref message);

            //Use manual mapping.
            ContactTitleManualConverter convtResult = new ContactTitleManualConverter();
            resp.ContactTitle = convtResult.ConvertObject(entity);

            return resp;
        }

        public ReturnNumber ContactTitleUpdate(ContactTitleSaveRequest input)
        {
            _log.Debug(THIS_CLASS + ": ContactTitleUpdate;" + "ContactTitleID = " + input.ContactTitle.ContactTitleID.ToString());

            string message = string.Empty;
            var resp = new ReturnNumber();
            IContactTitleRepository repo = ContactTitleRepositoryGet();

            //Use simple auto mapping
            IBaseConverter<ContactTitleSDO, ContactTitle> convtInput =
              new AutoMapConverter<ContactTitleSDO, ContactTitle>();
            ContactTitle entity = convtInput.ConvertObject(input.ContactTitle);

            // Update the ContactTitle
            bool updateSuccessful = repo.ContactTitleUpdate(entity, ref message);

            resp.Message = message;
            resp.NumberValue = (updateSuccessful == true) ? 1 : 0;

            return resp;
        }

        public ReturnNumber ContactTitleDelete(QueryByIdRequest input)
        {
            _log.Info(THIS_CLASS + ": ContactTitleDelete" + " ContactTitleID=" + input.Id.ToString());

            var resp = new ReturnNumber();
            string message = string.Empty;
            IContactTitleRepository repo = ContactTitleRepositoryGet();

            // Delete the ContactTitle
            bool deleteSuccessful = repo.ContactTitleDelete(input.Id, ref message);

            resp.Message = message;
            resp.NumberValue = (deleteSuccessful == true) ? 1 : 0;

            return resp;
        }

        #endregion ContactTitle Services

        #region Country Services

        public ReturnNumber CountryAdd(CountrySaveRequest input)
        {
            _log.Info(THIS_CLASS + ": CountryAdd" + " " + input.Country.CountryName.Trim());

            string message = string.Empty;
            var resp = new ReturnNumber();
            ICountryRepository repo = CountryRepositoryGet();

            //Use simple auto mapping
            IBaseConverter<CountrySDO, Country> convtInput = new AutoMapConverter<CountrySDO, Country>();
            Country entity = convtInput.ConvertObject(input.Country);

            // Add the Country
            resp.NumberValue = repo.CountryAdd(entity, ref message);
            resp.Message = message;

            return resp;
        }

        public CountryListResponse CountryGetAll(CountriesGetBySearchRequest request)
        {
            string logText = (request.CountrySearchText == null) ? "" : request.CountrySearchText.Trim();
            _log.Debug(THIS_CLASS + ": CountryGetAll; Search by: " + logText);

            var resp = new CountryListResponse();
            string message = string.Empty;
            resp.Countries = new Countries();
            ICountryRepository repo = CountryRepositoryGet();

            //Use simple auto mapping
            Common.Classes.PaginationRequest paging = new PaginationAutoMapConverter().ConvertObject(request.PaginationRequest);

            int totalCount = 0;

            // Get the Country List by search criteria
            IList<Country> CountryList =
                repo.CountryGetAll(request.CountrySearchText, paging, out totalCount, ref message);

            //Use simple auto mapping
            CountryManualConverterList convertResult = new CountryManualConverterList();
            List<CountrySDO> list = convertResult.ConvertObjectCollection(CountryList);

            resp.Countries.AddRange(list);
            resp.TotalCount = totalCount;
            resp.ErrorMessage = message;

            return resp;
        }

        public CountrySelectListResponse CountryGetAllList()
        {
            _log.Debug(THIS_CLASS + ": CountryGetAllList");

            int totalCount = 0;
            string message = string.Empty;
            var resp = new CountrySelectListResponse();
            resp.CountrySelectList = new CountrySelectList();
            ICountryRepository repo = CountryRepositoryGet();

            // Get the Country List
            IList<ListItem> CountryList = repo.CountryGetAllList(out totalCount, ref message);

            //Use custom configured auto mapping
            ListItemManualConverterEntity convertResult = new ListItemManualConverterEntity();
            List<ListItemSDO> list = convertResult.ConvertObjectCollection(CountryList);
            resp.CountrySelectList.AddRange(list);
            resp.TotalCount = totalCount;

            return resp;
        }

        public CountryResponse CountryGetByID(QueryByIdRequest request)
        {
            _log.Debug(THIS_CLASS + ": CountryGetByID; CountryID = " + request.Id.ToString().Trim());

            string message = string.Empty;
            CountryResponse resp = new CountryResponse();
            ICountryRepository repo = CountryRepositoryGet();

            // Get the Country by the ID   
            Country entity = repo.CountryGetByID(request.Id, ref message);

            //Use manual mapping.
            CountryManualConverter convtResult = new CountryManualConverter();
            resp.Country = convtResult.ConvertObject(entity);

            return resp;
        }

        public ReturnNumber CountryUpdate(CountrySaveRequest input)
        {
            _log.Debug(THIS_CLASS + ": CountryUpdate;" + "CountryID = " + input.Country.CountryID.ToString());

            string message = string.Empty;
            var resp = new ReturnNumber();
            ICountryRepository repo = CountryRepositoryGet();

            //Use simple auto mapping
            IBaseConverter<CountrySDO, Country> convtInput =
              new AutoMapConverter<CountrySDO, Country>();
            Country entity = convtInput.ConvertObject(input.Country);

            // Update the Country
            bool updateSuccessful = repo.CountryUpdate(entity, ref message);

            resp.Message = message;
            resp.NumberValue = (updateSuccessful == true) ? 1 : 0;

            return resp;
        }

        public ReturnNumber CountryDelete(QueryByIdRequest input)
        {
            _log.Info(THIS_CLASS + ": CountryDelete" + " CountryID=" + input.Id.ToString());

            var resp = new ReturnNumber();
            string message = string.Empty;
            ICountryRepository repo = CountryRepositoryGet();

            // Delete the Country
            bool deleteSuccessful = repo.CountryDelete(input.Id, ref message);

            resp.Message = message;
            resp.NumberValue = (deleteSuccessful == true) ? 1 : 0;

            return resp;
        }

        #endregion Country Services


        #endregion Administration Services

        #region Customers Contracts

        // Private Routines
        private ICustomerBLL CustomerBLLGet()
        {
            // Use runtime configuration for Unity DI
            return DIFactoryForRuntime.Resolve<ICustomerBLL>();
        }

        #region Customer Contracts

        public ReturnNumber CustomerAdd(CustomerSaveRequest input)
        {
            _log.Info(THIS_CLASS + ": CustomerAdd" + " " + input.Customer.CustomerName.Trim());

            string message = string.Empty;
            var resp = new ReturnNumber();
            ICustomerBLL bll = CustomerBLLGet();

            //Use simple auto mapping
            IBaseConverter<CustomerSDO, CustomerBDO> convtInput =
              new AutoMapConverter<CustomerSDO, CustomerBDO>();
            CustomerBDO entity = convtInput.ConvertObject(input.Customer);

            // Add the Customer
            resp.NumberValue = bll.CustomerAdd(entity, ref message);
            resp.Message = message;

            return resp;
        }

        public CustomerListResponse CustomerGetAll(CustomersGetBySearchRequest request)
        {
            _log.Debug(THIS_CLASS + ": CustomerGetAll");

            string message = string.Empty;
            int totalCount = 0;
            var resp = new CustomerListResponse();
            resp.Customers = new Customers();
            ICustomerBLL bll = CustomerBLLGet();

            Common.Classes.CustomerSearchFields searchFields = new CustomerSearchFieldsAutoMapConverter().ConvertObject(request.CustomerSearchFields);

            //Use simple auto mapping
            Common.Classes.PaginationRequest paging = new PaginationAutoMapConverter().ConvertObject(request.PaginationRequest);

            // Get the Customer List by search criteria
            IList<CustomerBDO> customerList = bll.CustomerGetAll(searchFields, paging, out totalCount, ref message);

            //Use simple auto mapping
            IBaseConverter<CustomerBDO, CustomerSDO> convtResult = new AutoMapConverter<CustomerBDO, CustomerSDO>();
            List<CustomerSDO> dcList = convtResult.ConvertObjectCollection(customerList);

            resp.Customers.AddRange(dcList);
            resp.TotalCount = totalCount;

            return resp;
        }

        public CustomerSelectListResponse CustomerGetAllList()
        {
            _log.Debug(THIS_CLASS + ": CustomerGetAllList()");

            string message = string.Empty;
            int totalCount = 0;
            var resp = new CustomerSelectListResponse();
            resp.CustomerSelectList = new CustomerSelectList();

            ICustomerBLL bll = CustomerBLLGet();

            // Get the ContactTitle List
            IList<ListItemBDO> customerList = bll.CustomerGetAllList(out totalCount, ref message);

            //Use custom configured auto mapping
            ListItemManualConverterBDO convertResult = new ListItemManualConverterBDO();
            List<ListItemSDO> list = convertResult.ConvertObjectCollection(customerList);
            resp.CustomerSelectList.AddRange(list);
            resp.TotalCount = totalCount;

            return resp;
        }

        public CustomerResponse CustomerGetByID(QueryByIdRequest request)
        {
            _log.Debug(THIS_CLASS + ": CustomerGetByID; CustomerID = " + request.Id.ToString().Trim());

            CustomerResponse resp = new CustomerResponse();
            string message = string.Empty;

            ICustomerBLL bll = CustomerBLLGet();

            // Get the Customer by the ID   
            CustomerBDO entity = bll.CustomerGetByID(request.Id, ref message);

            //Use custom configured auto mapping
            CustomerManualConverter convtResult = new CustomerManualConverter();
            resp.Customer = convtResult.ConvertObject(entity);

            return resp;
        }

        public ReturnNumber CustomerUpdate(CustomerSaveRequest input)
        {
            _log.Debug(THIS_CLASS + ": CustomerUpdate");

            string message = string.Empty;
            var resp = new ReturnNumber();

            ICustomerBLL bll = CustomerBLLGet();

            //Use simple auto mapping
            IBaseConverter<CustomerSDO, CustomerBDO> convtInput = new AutoMapConverter<CustomerSDO, CustomerBDO>();
            CustomerBDO entity = convtInput.ConvertObject(input.Customer);

            // Update the Customer
            bool updateSuccessful = bll.CustomerUpdate(entity, ref message);

            resp.Message = message;
            resp.NumberValue = (updateSuccessful == true) ? 1 : 0;

            return resp;
        }

        public ReturnNumber CustomerDelete(QueryByIdRequest input)
        {
            _log.Info(THIS_CLASS + ": CustomerDelete" + " CustomerID=" + input.Id.ToString());

            var resp = new ReturnNumber();
            string message = string.Empty;

            ICustomerBLL bll = CustomerBLLGet();

            // Delete the Customer
            bool deleteSuccessful = bll.CustomerDelete(input.Id, ref message);

            resp.Message = message;
            resp.NumberValue = (deleteSuccessful == true) ? 1 : 0;

            return resp;
        }

        #endregion Customer Contracts

        #endregion Customers Contracts

        #region Products Contracts

        #region Category Contracts

        // Private Routines

        private ICategoryBLL CategoryBLLGet()
        {
            // Use runtime configuration for Unity DI
            return DIFactoryForRuntime.Resolve<ICategoryBLL>();
        }

        public CategorySelectListResponse CategoryGetAllList()
        {
            _log.Debug(THIS_CLASS + ": CategoryGetAllList()");

            string message = string.Empty;
            int totalCount = 0;
            var resp = new CategorySelectListResponse();
            resp.CategorySelectList = new CategorySelectList();

            ICategoryBLL bll = CategoryBLLGet();

            // Get the ContactTitle List
            IList<ListItemBDO> productList = bll.CategoryGetAllList(out totalCount, ref message);

            //Use custom configured auto mapping
            ListItemManualConverterBDO convertResult = new ListItemManualConverterBDO();
            List<ListItemSDO> list = convertResult.ConvertObjectCollection(productList);
            resp.CategorySelectList.AddRange(list);
            resp.TotalCount = totalCount;

            return resp;
        }

        #endregion Category Contracts

        #region Product Contracts

        private IProductBLL ProductBLLGet()
        {
            // Use runtime configuration for Unity DI
            return DIFactoryForRuntime.Resolve<IProductBLL>();
        }

        //public ReturnNumber ProductAdd(ProductSaveRequest input)
        //{
        //    _log.Info(THIS_CLASS + ": ProductAdd" + " " + input.Product.ProductName.Trim());

        //    string message = string.Empty;
        //    var resp = new ReturnNumber();
        //    IProductBLL bll = ProductBLLGet();

        //    //Use simple auto mapping
        //    IBaseConverter<ProductSDO, ProductBDO> convtInput =
        //      new AutoMapConverter<ProductSDO, ProductBDO>();
        //    ProductBDO entity = convtInput.ConvertObject(input.Product);

        //    // Add the Product
        //    resp.NumberValue = bll.ProductAdd(entity, ref message);
        //    resp.Message = message;

        //    return resp;
        //}

        public ProductListResponse ProductGetAll(ProductsGetBySearchRequest request)
        {
            _log.Debug(THIS_CLASS + ": ProductGetAll");

            string message = string.Empty;
            int totalCount = 0;
            var resp = new ProductListResponse();
            resp.Products = new Products();
            IProductBLL bll = ProductBLLGet();

            Common.Classes.ProductSearchFields searchFields = new ProductSearchFieldsAutoMapConverter().ConvertObject(request.ProductSearchFields);

            //Use simple auto mapping
            Common.Classes.PaginationRequest paging = new PaginationAutoMapConverter().ConvertObject(request.PaginationRequest);

            // Get the Product List by search criteria
            IList<ProductBDO> productList = bll.ProductGetAll(searchFields, paging, out totalCount, ref message);

            //Use simple auto mapping
            IBaseConverter<ProductBDO, ProductSDO> convtResult = new AutoMapConverter<ProductBDO, ProductSDO>();
            List<ProductSDO> dcList = convtResult.ConvertObjectCollection(productList);

            resp.Products.AddRange(dcList);
            resp.TotalCount = totalCount;

            return resp;
        }

        //public ProductSelectListResponse ProductGetAllList()
        //{
        //    _log.Debug(THIS_CLASS + ": ProductGetAllList()");

        //    string message = string.Empty;
        //    int totalCount = 0;
        //    var resp = new ProductSelectListResponse();
        //    resp.ProductSelectList = new ProductSelectList();

        //    IProductBLL bll = ProductBLLGet();

        //    // Get the ContactTitle List
        //    IList<ListItemBDO> productList = bll.ProductGetAllList(out totalCount, ref message);

        //    //Use custom configured auto mapping
        //    ListItemManualConverterBDO convertResult = new ListItemManualConverterBDO();
        //    List<ListItemSDO> list = convertResult.ConvertObjectCollection(productList);
        //    resp.ProductSelectList.AddRange(list);
        //    resp.TotalCount = totalCount;

        //    return resp;
        //}

        //public ProductResponse ProductGetByID(QueryByIdRequest request)
        //{
        //    _log.Debug(THIS_CLASS + ": ProductGetByID; ProductID = " + request.Id.ToString().Trim());

        //    ProductResponse resp = new ProductResponse();
        //    string message = string.Empty;

        //    IProductBLL bll = ProductBLLGet();

        //    // Get the Product by the ID   
        //    ProductBDO entity = bll.ProductGetByID(request.Id, ref message);

        //    //Use custom configured auto mapping
        //    ProductManualConverter convtResult = new ProductManualConverter();
        //    resp.Product = convtResult.ConvertObject(entity);

        //    return resp;
        //}

        //public ReturnNumber ProductUpdate(ProductSaveRequest input)
        //{
        //    _log.Debug(THIS_CLASS + ": ProductUpdate");

        //    string message = string.Empty;
        //    var resp = new ReturnNumber();

        //    IProductBLL bll = ProductBLLGet();

        //    //Use simple auto mapping
        //    IBaseConverter<ProductSDO, ProductBDO> convtInput = new AutoMapConverter<ProductSDO, ProductBDO>();
        //    ProductBDO entity = convtInput.ConvertObject(input.Product);

        //    // Update the Product
        //    bool updateSuccessful = bll.ProductUpdate(entity, ref message);

        //    resp.Message = message;
        //    resp.NumberValue = (updateSuccessful == true) ? 1 : 0;

        //    return resp;
        //}

        //public ReturnNumber ProductDelete(QueryByIdRequest input)
        //{
        //    _log.Info(THIS_CLASS + ": ProductDelete" + " ProductID=" + input.Id.ToString());

        //    var resp = new ReturnNumber();
        //    string message = string.Empty;

        //    IProductBLL bll = ProductBLLGet();

        //    // Delete the Product
        //    bool deleteSuccessful = bll.ProductDelete(input.Id, ref message);

        //    resp.Message = message;
        //    resp.NumberValue = (deleteSuccessful == true) ? 1 : 0;

        //    return resp;
        //}

        #endregion Product Contracts


        #region Supplier Contracts

        // Private Routines

        private ISupplierBLL SupplierBLLGet()
        {
            // Use runtime configuration for Unity DI
            return DIFactoryForRuntime.Resolve<ISupplierBLL>();
        }

        public SupplierSelectListResponse SupplierGetAllList()
        {
            _log.Debug(THIS_CLASS + ": SupplierGetAllList()");

            string message = string.Empty;
            int totalCount = 0;
            var resp = new SupplierSelectListResponse();
            resp.SupplierSelectList = new SupplierSelectList();

            ISupplierBLL bll = SupplierBLLGet();

            // Get the ContactTitle List
            IList<ListItemBDO> productList = bll.SupplierGetAllList(out totalCount, ref message);

            //Use custom configured auto mapping
            ListItemManualConverterBDO convertResult = new ListItemManualConverterBDO();
            List<ListItemSDO> list = convertResult.ConvertObjectCollection(productList);
            resp.SupplierSelectList.AddRange(list);
            resp.TotalCount = totalCount;

            return resp;
        }

        #endregion Supplier Contracts


        #endregion Products Contracts

        #region Security Services

        // Private Routines
        private ISecurityBLL SecurityBLLGet()
        {
            // Use runtime configuration for Unity DI
            //return DIFactoryForRuntime.Resolve<ISecurityBLL>();

            // Use designtime configuration for Unity DI
            return DIFactoryForDesigntime.GetInstance<ISecurityBLL>();
        }

        public LoginResponse LoginAuthentication(LoginRequest request)
        {
            _log.Debug(THIS_CLASS + ": LoginAuthentication; " + "Username = " + request.Username.Trim());

            string message = string.Empty;
            LoginResponse resp = new LoginResponse();

            ISecurityBLL bll = SecurityBLLGet();

            SecurityRequestFields srf = new SecurityRequestFields
            {
                Username = request.Username,
                Password = request.Password
            };

            resp.IsValid = bll.LoginAuthentication(srf, ref message);
            resp.ErrorMessage = message;

            return resp;
        }

        public UserInRoleResponse ApplicationUserToApplicationRoleIsIn(UserInRoleRequest request)
        {
            _log.Debug(THIS_CLASS + ": ApplicationUserToApplicationRoleIsIn; " +
                " Username: = " + request.Username.Trim() +
                " RoleName: = " + request.RoleName.Trim());

            string message = string.Empty;
            UserInRoleResponse resp = new UserInRoleResponse();
            ISecurityBLL bll = SecurityBLLGet();

            SecurityRequestFields srf = new SecurityRequestFields
            {
                Username = request.Username,
                RoleName = request.RoleName
            };

            resp.IsInRole = bll.ApplicationUserToApplicationRole_IsIn(srf, ref message);
            resp.ErrorMessage = message;

            return resp;
        }

        public UserInRolesResponse UsernameInApplicationRoles(UserInRoleRequest request)
        {
            _log.Debug(THIS_CLASS + ": ApplicationUserToApplicationRoleIsIn; " +
                " Username = " + request.Username.Trim());

            string message = string.Empty;
            int totalCount = 0;
            UserInRolesResponse resp = new UserInRolesResponse();
            resp.UserToRoleNames = new UserToRoleNames();
            SecurityRequestFields srf = new SecurityRequestFields
            {
                Username = request.Username
            };

            ISecurityBLL bll = SecurityBLLGet();

            IList<UserFullNameToRoleNameBDO> usernameRoleNameList = bll.UsernameApplicationRoles(srf, out totalCount, ref message);

            //Use manual mapping.
            UserFullNameToRoleNameManualConverter convtResult = new UserFullNameToRoleNameManualConverter();
            IList<UserFullNameToRoleNameSDO> list = convtResult.ConvertObjectCollection(usernameRoleNameList);

            // KSS
            resp.UserToRoleNames.AddRange(list);
            resp.ErrorMessage = message;
            resp.TotalCount = totalCount;

            return resp;
        }

        #endregion Security Services
    }
}
