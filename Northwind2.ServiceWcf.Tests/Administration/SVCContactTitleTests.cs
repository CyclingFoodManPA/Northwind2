namespace Northwind2.ServiceWcf.Test.Administration
{
    using Northwind2.ServiceTestWcf.Tests;
    using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;
    using NUnit.Framework;

    [TestFixture]
    public class SVCContactTitleTests : SVCNorthwind2WcfTests
    {
        //Setup Routines
        private const string THIS_CLASS = "SVCWcfContactTitleTests";
        
        [Test]
        public void SVCWcf_Admin_ContactTitle_A_GetByID()
        {
            _log.Info(THIS_CLASS + ": SVCWcf_Admin_ContactTitle_A_GetByID()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - set CategoryID to 1
            QueryByIdRequest getItem = new QueryByIdRequest { Id = 1 };

            //Act - read updated Category
            ContactTitleResponse getItemResponse = proxy.ContactTitleGetByID(getItem);

            //Assert - ensure it was deleted
            Assert.True(getItemResponse.ContactTitle.ContactTitleName == "Accounting Manager" &&
                getItemResponse.ContactTitle.Customers.Count == 10 &&
                getItemResponse.ContactTitle.Suppliers.Count == 2);
        }

        [Test]
        public void SVCWcf_Admin_ContactTitle_B_GetAllList_ReturnsActualCountEQ20TotalCountEQ20()
        {
            _log.Info(THIS_CLASS + ":  SVCWcf_Admin_ContactTitle_B_GetAllList_ReturnsActualCountEQ20TotalCountEQ20()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Act - get the listst
            ContactTitleSelectListResponse response = proxy.ContactTitleGetAllList();

            //Assert - see if action worked or failed
            Assert.IsTrue(response.ContactTitleSelectList.Count == 20
                && response.TotalCount == 20);
        }

        [Test]
        public void SVCWcf_Admin_ContactTitle_C_GetAll_ReturnsCountEQ4TotalCountEQ20()
        {
            _log.Info(THIS_CLASS + ": SVCWcf_Admin_ContactTitle_C_GetAll_ReturnsCountEQ4TotalCountEQ20()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            ContactTitlesGetBySearchRequest searchRequest = new ContactTitlesGetBySearchRequest
            {
                ContactTitleSearchText = "",
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 4,
                    PageIndex = 0,
                    Sort = new Sort()
                    {
                        SortBy = "ContactTitleName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            ContactTitleListResponse response = proxy.ContactTitleGetAll(searchRequest);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.ContactTitles.Count == 4 
                && response.TotalCount == 20);
        }

        [Test]
        public void SVCWcf_Admin_ContactTitle_D_GetAll_ReturnsCountEQ4TotalCountEQ6()
        {
            _log.Info(THIS_CLASS + ": SVCWcf_Admin_ContactTitle_D_GetAll_ReturnsCountEQ4TotalCountEQ6()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            ContactTitlesGetBySearchRequest searchRequest = new ContactTitlesGetBySearchRequest
            {
                ContactTitleSearchText = "as",
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 4,
                    PageIndex = 0,
                    Sort = new Sort()
                    {
                        SortBy = "ContactTitleName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            ContactTitleListResponse response = proxy.ContactTitleGetAll(searchRequest);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.ContactTitles.Count == 4 
                && response.TotalCount == 5);
        }

        [Test]
        public void SVCWcf_Admin_ContactTitle_E_GetAll_ReturnsCountEQ2TotalCountEQ6()
        {
            _log.Info(THIS_CLASS + ": SVCWcf_Admin_ContactTitle_E_GetAll_ReturnsCountEQ2TotalCountEQ6()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            ContactTitlesGetBySearchRequest request = new ContactTitlesGetBySearchRequest
            {
                ContactTitleSearchText = "as",
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 4,
                    PageIndex = 1,
                    Sort = new Sort()
                    {
                        SortBy = "ContactTitleName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            ContactTitleListResponse response = proxy.ContactTitleGetAll(request);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.ContactTitles.Count == 2 && response.TotalCount == 6);
        }

        [Test]
        public void SVCWcf_Admin_ContactTitle_F_GetAll_ReturnsCountEQ2TotalCountEQ2()
        {
            _log.Info(THIS_CLASS + ": SVCWcf_Admin_ContactTitle_F_GetAll_ReturnsCountEQ2TotalCountEQ2()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            ContactTitlesGetBySearchRequest request = new ContactTitlesGetBySearchRequest
            {
                ContactTitleSearchText = "ad",
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 4,
                    PageIndex = 0,
                    Sort = new Sort()
                    {
                        SortBy = "ContactTitleName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            ContactTitleListResponse response = proxy.ContactTitleGetAll(request);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.ContactTitles.Count == 2 && response.TotalCount == 2);
        }

        [Test]
        public void SVCWcf_Admin_ContactTitle_G_GetAll_ReturnsCountEQ0TotalCountEQ0()
        {
            _log.Info(THIS_CLASS + ": SVCWcf_Admin_ContactTitle_G_GetAll_ReturnsCountEQ0TotalCountEQ0()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - prepare request
            ContactTitlesGetBySearchRequest request = new ContactTitlesGetBySearchRequest
            {
                ContactTitleSearchText = "ad",
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 4,
                    PageIndex = 1,
                    Sort = new Sort()
                    {
                        SortBy = "ContactTitleName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            ContactTitleListResponse response = proxy.ContactTitleGetAll(request);

            //Assert - see if action worked or failed
            Assert.IsTrue(response.ContactTitles.Count == 0 && response.TotalCount == 0);
        }

        [Test]
        public void SVCWcf_Admin_ContactTitle_H_Add_ReturnsNewID()
        {
            _log.Info(THIS_CLASS + ": SVCWcf_Admin_ContactTitle_H_Add_ReturnsNewID()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();


            //Arrange - create new Category
            ContactTitleSaveRequest request = new ContactTitleSaveRequest
            {
                ContactTitle = new ContactTitleSDO
                {
                    ContactTitleName = "Test SVCContactTitleTests",
                    AddedBy = "SVCContactTitleTests",
                    ModifiedBy = "SVCContactTitleTests"
                }
            };

            //Act - insert new Category
            ReturnNumber response = proxy.ContactTitleAdd(request);

            //Assert - see if action worked or failed
            Assert.True(response.NumberValue > 0); 
        }

        [Test]
        public void SVCWcf_Admin_ContactTitle_I_Add_ReturnsNotInserted()
        {
            _log.Info(THIS_CLASS + ": SVCWcf_Admin_ContactTitle_I_Add_ReturnsNotInserted()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();

            //Arrange - create new Category
            ContactTitleSaveRequest request = new ContactTitleSaveRequest
            {
                ContactTitle = new ContactTitleSDO
                {
                    ContactTitleName = "Test SVCContactTitleTests",
                    AddedBy = "SVCContactTitleTests",
                    ModifiedBy = "SVCContactTitleTests"
                }
            };

            //Act - insert new Category
            ReturnNumber response = proxy.ContactTitleAdd(request);

            // Assert - did add work
            Assert.True(response.NumberValue == -1 
                && response.Message == "Cannot insert duplicate key row in object 'Administration.ContactTitle' with unique index 'IDX_ContactTitle_1'. The duplicate key value is (Test ContactTitleBLL).\r\nThe statement has been terminated.");        
        }

        [Test]
        public void SVCWcf_Admin_ContactTitle_J_Update()
        {
            _log.Info(THIS_CLASS + ": SVCWcf_Admin_ContactTitle_J_Update()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();
            ContactTitleSDO ct = ContactTitleByContactTitleNameGet(proxy, "Test SVCContactTitleTests");

            if (ct != null)
            {
                ct.ContactTitleName = "Test Test SVCContactTitleTests";
                ContactTitleSaveRequest request = new ContactTitleSaveRequest { ContactTitle = ct };

                ReturnNumber response = proxy.ContactTitleUpdate(request);
                //Assert - see if action worked or failed
                Assert.True(response.NumberValue == 0);
            }  
        }

        [Test]
        public void SVCWcf_Admin_ContactTitle_K_Delete()
        {
            _log.Info(THIS_CLASS + ": SVCWcf_Admin_ContactTitle_K_Delete()");

            //Arrange - get service
            Northwind2ServiceClient proxy = GetServiceClient();
            ContactTitleSDO ct = ContactTitleByContactTitleNameGet(proxy, "Test Test SVCContactTitleTests");

            if (ct != null)
            {
                QueryByIdRequest request = new QueryByIdRequest { Id = ct.ContactTitleID };
                
                //Act - delete the contact title
                ReturnNumber response = proxy.ContactTitleDelete(request);
                
                ct.ContactTitleName = "Test Test SVCContactTitleTests";
                ContactTitleSaveRequest saveRequest = new ContactTitleSaveRequest
                {
                    ContactTitle = ct
                };

                ReturnNumber updatedResponse = proxy.ContactTitleUpdate(saveRequest);
                //Assert - see if action worked or failed
                Assert.True(updatedResponse.NumberValue == 0);
            }
        }
        
        private ContactTitleSDO ContactTitleByContactTitleNameGet(Northwind2ServiceClient proxy, string contactTitleName)
        {
            _log.Info(THIS_CLASS + ": ContactTitleByContactTitleNameGet for value:" + contactTitleName.Trim());

            //Arrange - prepare request
            ContactTitlesGetBySearchRequest request = new ContactTitlesGetBySearchRequest
            {
                ContactTitleSearchText = contactTitleName,
                PaginationRequest = new PaginationRequest
                {
                    PageSize = 4,
                    PageIndex = 0,
                    Sort = new Sort()
                    {
                        SortBy = "ContactTitleName",
                        SortDirection = SortDirection.Ascending
                    }
                }
            };

            //Action - get the list
            ContactTitleListResponse response = proxy.ContactTitleGetAll(request);

            if (response.ContactTitles.Count == 1)
                return response.ContactTitles[0];
            else
                return null;
        }
    }
}
