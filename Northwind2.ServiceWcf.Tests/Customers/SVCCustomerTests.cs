namespace Northwind2.ServiceWcf.Tests.Customers
{
    using Northwind2.ServiceTestWcf.Tests;
    using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;
    using NUnit.Framework;

    [TestFixture]
    public class SVCCustomerTests : SVCNorthwind2WcfTests
    {
        //Setup Routines
        private const string THIS_CLASS = "SVCWcfCustomerTests";

        [Test]
        public void SVCWcf_Custs_Customer_A_GetByID()
        {
            _log.Info(THIS_CLASS + ": SVC_Customer_A_GetByID()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - set CustomerID to 1
            QueryByIdRequest getItem = new QueryByIdRequest { Id = 1 };

            //Act - read customer
            CustomerResponse getItemResponse = proxy.CustomerGetByID(getItem);

            //Assert - ensure the correct customer name
            Assert.True(getItemResponse.Customer.CustomerName == "Alfreds Futterkiste");
        }

        [Test]
        public void SVCWcf_Custs_Customer_B_GetAllList()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_B_GetAllList()");

            //Arrange - get contact title service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Act - get the list
            CustomerSelectListResponse response = proxy.CustomerGetAllList();
            
            //Assert - see if action worked or failed
            Assert.IsTrue(response.CustomerSelectList.Count == 91
                && response.TotalCount == 91);
        }

        [Test]
        public void SVCWcf_Custs_Customer_C_GetAllSearchNothing()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_C_GetAllSearchNothing()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            CustomersGetBySearchRequest searchRequest = new CustomersGetBySearchRequest
            {
                CustomerSearchFields = null,
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 4,
                    PageIndex = 0,
                    Sort = new Sort()
                    {
                        SortBy = "CustomerName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            CustomerListResponse response = proxy.CustomerGetAll(searchRequest);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.Customers.Count == 4
                && response.TotalCount == 4);
        }

        [Test]
        public void SVCWcf_Custs_Customer_D_GetAllSearch1()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_D_GetAllSearch1()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            CustomersGetBySearchRequest searchRequest = new CustomersGetBySearchRequest
            {
                CustomerSearchFields = null,
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 20,
                    PageIndex = 3,
                    Sort = new Sort()
                    {
                        SortBy = "CustomerName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            CustomerListResponse response = proxy.CustomerGetAll(searchRequest);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.Customers.Count == 20
                && response.TotalCount == 20);
        }


        [Test]
        public void SVCWcf_Custs_Customer_E_GetAllSearch2()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_E_GetAllSearch2()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            CustomersGetBySearchRequest searchRequest = new CustomersGetBySearchRequest
            {
                CustomerSearchFields = null,
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 15,
                    PageIndex = 6,
                    Sort = new Sort()
                    {
                        SortBy = "CustomerName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            CustomerListResponse response = proxy.CustomerGetAll(searchRequest);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.Customers.Count == 1
                && response.TotalCount == 1);
        }

        [Test]
        public void SVCWcf_Custs_Customer_F_GetAllSearch3()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_F_GetAllSearch3()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            CustomersGetBySearchRequest searchRequest = new CustomersGetBySearchRequest
            {
                CustomerSearchFields = new CustomerSearchFields
                {
                    CustomerName = "an",
                    IsActive = true                 
                },
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 15,
                    PageIndex = 0,
                    Sort = new Sort()
                    {
                        SortBy = "CustomerName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            CustomerListResponse response = proxy.CustomerGetAll(searchRequest);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.Customers.Count == 15
                && response.TotalCount == 15);
        }

        [Test]
        public void SVCWcf_Custs_Customer_G_GetAllSearch4()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_G_GetAllSearch4()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            CustomersGetBySearchRequest searchRequest = new CustomersGetBySearchRequest
            {
                CustomerSearchFields = new CustomerSearchFields
                {
                    CustomerName = "an",
                    IsActive = true
                },
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 15,
                    PageIndex = 1,
                    Sort = new Sort()
                    {
                        SortBy = "CustomerName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            CustomerListResponse response = proxy.CustomerGetAll(searchRequest);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.Customers.Count == 8
                && response.TotalCount == 8);
        }

        [Test]
        public void SVCWcf_Custs_Customer_H_GetAllSearch5()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_H_GetAllSearch5()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            CustomersGetBySearchRequest searchRequest = new CustomersGetBySearchRequest
            {
                CustomerSearchFields = new CustomerSearchFields
                {
                    CustomerName = "an",
                    ContactTitleName = "sale",
                    IsActive = true
                },
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 15,
                    PageIndex = 0,
                    Sort = new Sort()
                    {
                        SortBy = "CustomerName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            CustomerListResponse response = proxy.CustomerGetAll(searchRequest);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.Customers.Count == 12
                && response.TotalCount == 12);
        }

        [Test]
        public void SVCWcf_Custs_Customer_I_GetAllSearch6()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_I_GetAllSearch6()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            CustomersGetBySearchRequest searchRequest = new CustomersGetBySearchRequest
            {
                CustomerSearchFields = new CustomerSearchFields
                {
                    CustomerName = "an",
                    ContactName = "an",
                    ContactTitleName = "sale",
                    IsActive = true
                },
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 15,
                    PageIndex = 0,
                    Sort = new Sort()
                    {
                        SortBy = "CustomerName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            CustomerListResponse response = proxy.CustomerGetAll(searchRequest);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.Customers.Count == 5
                && response.TotalCount == 5);
        }

        [Test]
        public void SVCWcf_Custs_Customer_J_GetAllSearch7()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_J_GetAllSearch7()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            CustomersGetBySearchRequest searchRequest = new CustomersGetBySearchRequest
            {
                CustomerSearchFields = new CustomerSearchFields
                {
                    CustomerName = "an",
                    ContactName = "an",
                    ContactTitleName = "sale",
                    Address1 = "6",
                    IsActive = true
                },
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 15,
                    PageIndex = 0,
                    Sort = new Sort()
                    {
                        SortBy = "CustomerName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            CustomerListResponse response = proxy.CustomerGetAll(searchRequest);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.Customers.Count == 2
                && response.TotalCount == 2);
        }


        [Test]
        public void SVCWcf_Custs_Customer_ZA_Add_ReturnsNewID()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_ZA_Add_ReturnsNewID()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            CustomerSaveRequest saveRequest = new CustomerSaveRequest
            {
                Customer = new CustomerSDO
                {
                    CustomerName = "Test CustomerSVCTest",
                    ContactName = "Mr. BLL Test",
                    ContactTitleID = 19,
                    Address1 = "BLL Test Street",
                    Address2 = null,
                    City = "BLL",
                    Region = "PA",
                    PostalCode = "17363",
                    CountryID = 24,
                    Phone = "(717) 555-1212",
                    Fax = "(717) 555-1213",
                    Email = "testcust@test.com",
                    CustomerIDOld = "TESTC",
                    IsActive = true,
                    AddedBy = "SVCCustomerTests",
                    ModifiedBy = "SVCCustomerTests"
                }
            };

            ReturnNumber response = proxy.CustomerAdd(saveRequest);

            //Assert - see if action worked or failed
            Assert.True(response.NumberValue > 0 && response.Message == "Customer= Test CustomerSVCTest was inserted successfully!"); 
        }

        [Test]
        public void SVCWcf_Custs_Customer_ZA_Add_ReturnsNotInserted()
        {
            _log.Info(THIS_CLASS + ": SVC_Custs_Customer_ZA_Add_ReturnsNotInserted()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            CustomerSaveRequest saveRequest = new CustomerSaveRequest
            {
                Customer = new CustomerSDO
                {
                    CustomerName = "Test CustomerSVCTest",
                    ContactName = "Mr. BLL Test",
                    ContactTitleID = 19,
                    Address1 = "BLL Test Street",
                    Address2 = null,
                    City = "BLL",
                    Region = "PA",
                    PostalCode = "17363",
                    CountryID = 24,
                    Phone = "(717) 555-1212",
                    Fax = "(717) 555-1213",
                    Email = "testcust@test.com",
                    CustomerIDOld = "TESTC",
                    IsActive = true,
                    AddedBy = "SVCCustomerTests",
                    ModifiedBy = "SVCCustomerTests"
                }
            };

            ReturnNumber response = proxy.CustomerAdd(saveRequest);

              //Assert - see if action worked or failed
            Assert.True(response.NumberValue == 0 
                && response.Message == "Customer= Test CustomerSVCTest was **NOT** inserted successfully!");
        }
    }
}
