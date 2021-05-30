/*****************************************************************************
 *        Class Name: REPOContactTitleTests
 *  Class Decription: Contains all unit tests for Customer Repository
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using Northwind2.Common.Classes;
using Northwind2.Entities.Models;
using Northwind2.Repositories.Contracts;
using Northwind2.Repositories.Tests.UnityDI;
using NUnit.Framework;

namespace Northwind2.Repositories.Tests.Customers
{
    public class REPCustomerTests : REPONorthwind2Tests
    {
        // Private Variables
        private const string THIS_CLASS = "REPOCustomerTests";

        // Private Routines
        private ICustomerRepository CustomerRepositoryGet()
        {
            //return DIFactoryForDesigntime.GetInstance<IContactTitleBLL>();
            return DIFactoryForRuntime.Resolve<ICustomerRepository>();
        }

        [Test]
        public void REPO_Custs_Customer_A_GetByID()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_A_GetByID()");

            ICustomerRepository repo = null;
            string message = string.Empty;

            //Arrange - get ContactTitleRepository
            repo = CustomerRepositoryGet();

            //Act - get list of ContactTitle's
            var actual = repo.CustomerGetByID(1, ref message);
            Assert.True(actual.CustomerName == "Alfreds Futterkiste");
        }

        [Test]
        public void REPO_Custs_Customer_B_GetAllList()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_B_GetAllList()");

            ICustomerRepository repo = null;
            string message = string.Empty;
            int totalCount = 0;

            // Arrange - get SystemUser repo
            repo = CustomerRepositoryGet();

            // Act - get the list of Customers 
            var actual = repo.CustomerGetAllList(out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 91 && totalCount == 91);
        }

        //Paging Tests
        [Test]
        public void REPO_Custs_Customer_C_GetAllSearchNothing()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_C_GetAllSearchNothing()");

            ICustomerRepository repo = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser repo
            repo = CustomerRepositoryGet();

            // Arrange - set search criteria and totalCount
            CustomerSearchFields csf = null;

            PaginationRequest paging = new PaginationRequest
            {
                PageSize = 15,
                PageIndex = 0,
                Sort = new Sort()
                {
                    SortBy = "CustomerName",
                    SortDirection = SortDirection.Ascending
                },
            };

            // Act - get the list of SystemUsers 
            var actual = repo.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 15 && totalCount == 91);
        }

        [Test]
        public void REPO_Custs_Customer_D_GetAllSearch1()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_D_GetAllSearch1()");

            ICustomerRepository repo = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser repo
            repo = CustomerRepositoryGet();

            // Arrange - set search criteria and totalCount
            CustomerSearchFields csf = null;

            PaginationRequest paging = new PaginationRequest
            {
                PageSize = 20,
                PageIndex = 3,
                Sort = new Sort()
                {
                    SortBy = "CustomerName",
                    SortDirection = SortDirection.Ascending
                },
            };

            // Act - get the list of SystemUsers 
            var actual = repo.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 20 && totalCount == 91);
        }


        [Test]
        public void REPO_Custs_Customer_E_GetAllSearch2()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_E_GetAllSearch2()");

            ICustomerRepository repo = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser repo
            repo = CustomerRepositoryGet();

            // Arrange - set search criteria and totalCount
            CustomerSearchFields csf = null;

            PaginationRequest paging = new PaginationRequest
            {
                PageSize = 15,
                PageIndex = 6,
                Sort = new Sort()
                {
                    SortBy = "CustomerName",
                    SortDirection = SortDirection.Ascending
                },
            };

            // Act - get the list of SystemUsers 
            var actual = repo.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 1 && totalCount == 91);
        }


        [Test]
        public void REPO_Custs_Customer_F_GetAllSearch3()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_F_GetAllSearch3()");

            ICustomerRepository repo = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser repo
            repo = CustomerRepositoryGet();

            // Arrange - set search criteria and totalCount
            CustomerSearchFields csf = new CustomerSearchFields
            {
                CustomerName = "an",
                IsActive = true
            };

            PaginationRequest paging = new PaginationRequest
            {
                PageSize = 15,
                PageIndex = 0,
                Sort = new Sort()
                {
                    SortBy = "CustomerName",
                    SortDirection = SortDirection.Ascending
                },
            };

            // Act - get the list of SystemUsers 
            var actual = repo.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 15 && totalCount == 23);
        }

        [Test]
        public void REPO_Custs_Customer_G_GetAllSearch4()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_G_GetAllSearch4()");

            ICustomerRepository repo = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser repo
            repo = CustomerRepositoryGet();

            // Arrange - set search criteria and totalCount
            CustomerSearchFields csf = new CustomerSearchFields
            {
                CustomerName = "an",
                IsActive = true
            };

            PaginationRequest paging = new PaginationRequest
            {
                PageSize = 15,
                PageIndex = 1,
                Sort = new Sort()
                {
                    SortBy = "CustomerName",
                    SortDirection = SortDirection.Ascending
                },
            };

            // Act - get the list of SystemUsers 
            var actual = repo.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 8 && totalCount == 23);
        }


        [Test]
        public void REPO_Custs_Customer_H_GetAllSearch5()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_H_GetAllSearch5()");

            ICustomerRepository repo = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser repo
            repo = CustomerRepositoryGet();

            // Arrange - set search criteria and totalCount
            CustomerSearchFields csf = new CustomerSearchFields
            {
                CustomerName = "an",
                ContactTitleName = "sale",
                IsActive = true
            };

            PaginationRequest paging = new PaginationRequest
            {
                PageSize = 15,
                PageIndex = 0,
                Sort = new Sort()
                {
                    SortBy = "CustomerName",
                    SortDirection = SortDirection.Ascending
                },
            };

            // Act - get the list of SystemUsers 
            var actual = repo.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 12 && totalCount == 12);
        }

        [Test]
        public void REPO_Custs_Customer_I_GetAllSearch6()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_I_GetAllSearch6()");

            ICustomerRepository repo = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser repo
            repo = CustomerRepositoryGet();

            // Arrange - set search criteria and totalCount
            CustomerSearchFields csf = new CustomerSearchFields
            {
                CustomerName = "an",
                ContactName = "an",
                ContactTitleName = "sale",
                IsActive = true
            };

            PaginationRequest paging = new PaginationRequest
            {
                PageSize = 15,
                PageIndex = 0,
                Sort = new Sort()
                {
                    SortBy = "CustomerName",
                    SortDirection = SortDirection.Ascending
                },
            };

            // Act - get the list of SystemUsers 
            var actual = repo.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 5 && totalCount == 5);
        }

        [Test]
        public void REPO_Custs_Customer_J_GetAllSearch7()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_J_GetAllSearch7()");

            ICustomerRepository repo = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser repo
            repo = CustomerRepositoryGet();

            // Arrange - set search criteria and totalCount
            CustomerSearchFields csf = new CustomerSearchFields
            {
                CustomerName = "an",
                ContactName = "an",
                ContactTitleName = "sale",
                Address1 = "6",
                IsActive = true
            };

            PaginationRequest paging = new PaginationRequest
            {
                PageSize = 15,
                PageIndex = 0,
                Sort = new Sort()
                {
                    SortBy = "CustomerName",
                    SortDirection = SortDirection.Ascending
                },
            };

            // Act - get the list of SystemUsers 
            var actual = repo.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 2 && totalCount == 2);
        }

        [Test]
        public void REPO_Custs_Customer_ZA_Add_ReturnsNewID()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_ZA_Add_ReturnsNewID()");

            ICustomerRepository repo = null;
            Customer c = null;
            string message = string.Empty;
            int custID = 0;

            // Arrange - get CustomerDALBLL
            repo = CustomerRepositoryGet();

            // Arrange - create new Customer
            c = new Customer
            {
                CustomerName = "Test CustomerBLLTest",
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
                AddedBy = "CustomerBLLTests",
                ModifiedBy = "CustomerBLLTests"
            };

            // Act - actually add the Customer
            custID = repo.CustomerAdd(c, ref message);

            // Assert - did add work
            Assert.True(custID > 0);
        }

        [Test]
        public void REPO_Custs_Customer_ZB_Add_ReturnsNotInserted()
        {
            _log.Info(THIS_CLASS + ": REPO_Custs_Customer_ZB_Add_ReturnsNotInserted()");

            ICustomerRepository repo = null;
            Customer c = null;
            string message = string.Empty;
            int custID = 0;

            //Arrange - get CustomerDALBLL
            repo = CustomerRepositoryGet();

            // Arrange - create new Customer
            c = new Customer
            {
                CustomerName = "Test CustomerBLLTest",
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
                AddedBy = "CustomerBLLTests",
                ModifiedBy = "CustomerBLLTests"
            };

            // Act - actually add the Customer
            custID = repo.CustomerAdd(c, ref message);

            // Assert - did add work
            Assert.True(custID == -1
                && message == "Cannot insert duplicate key row in object 'Customers.Customer' with unique index 'IDX_Customer_1'. The duplicate key value is (Test CustomerBLLTest).\r\nThe statement has been terminated.");
        }
    }
}
