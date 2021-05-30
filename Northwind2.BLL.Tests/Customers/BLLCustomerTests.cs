/*****************************************************************************
 *        Class Name: BLLCustomerTests
 *  Class Decription: Contains all unit tests for Customer bll
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using Northwind2.BDO;
using Northwind2.BLL.Contracts;
using Northwind2.BLL.Tests.UnityDI;
using Northwind2.Common.Classes;
using NUnit.Framework;

namespace Northwind2.BLL.Tests.Customers
{
    [TestFixture]
    public class BLLCustomerTests : BLLNorthwind2Tests
    {
        // Setup Routines DAL
        private const string THIS_CLASS = "CustomerBLLTests";

        private ICustomerBLL CustomerBLLGet()
        {
            //return DIFactoryForDesigntime.GetInstance<IContactTitleBLL>();
            return DIFactoryForRuntime.Resolve<ICustomerBLL>();
        }

        [Test]
        public void BLL_Custs_Customer_A_GetByID()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_A_GetByID()");

            ICustomerBLL bll = null;
            CustomerBDO c = null;
            string message = string.Empty;
            int id = 0;

            // Arrange - get Customer bll
            bll = CustomerBLLGet();

            // Arrange - set CustomerID to 1
            id = 1;

            // Act - read Customer and save child entity counts   
            c = bll.CustomerGetByID(id, ref message);

            // Assert - see if action worked or failed
            Assert.True(c.CustomerName == "Alfreds Futterkiste" && c.Invoices.Count == 12);
        }

        [Test]
        public void BLL_Custs_Customer_B_GetAllList()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_B_GetAllList()");

            ICustomerBLL bll = null;
            string message = string.Empty;
            int totalCount = 0;

            // Arrange - get SystemUser bll
            bll = CustomerBLLGet();

            // Act - get the list of Customers 
            var actual = bll.CustomerGetAllList(out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 91 && totalCount == 91);
        }

        //Paging Tests
        [Test]
        public void BLL_Custs_Customer_C_GetAllSearchNothing()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_C_GetAllSearchNothing()");

            ICustomerBLL bll = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser bll
            bll = CustomerBLLGet();

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
            var actual = bll.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 15 && totalCount == 15);
        }

        [Test]
        public void BLL_Custs_Customer_D_GetAllSearch1()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_D_GetAllSearch1()");

            ICustomerBLL bll = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser bll
            bll = CustomerBLLGet();

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
            var actual = bll.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 20 && totalCount == 20);
        }


        [Test]
        public void BLL_Custs_Customer_E_GetAllSearch2()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_E_GetAllSearch2()");

            ICustomerBLL bll = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser bll
            bll = CustomerBLLGet();

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
            var actual = bll.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 1 && totalCount == 1);
        }


        [Test]
        public void BLL_Custs_Customer_F_GetAllSearch3()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_F_GetAllSearch3()");

            ICustomerBLL bll = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser bll
            bll = CustomerBLLGet();

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
            var actual = bll.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 15 && totalCount == 15);
        }

        [Test]
        public void BLL_Custs_Customer_G_GetAllSearch4()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_G_GetAllSearch4()");

            ICustomerBLL bll = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser bll
            bll = CustomerBLLGet();

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
            var actual = bll.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 8 && totalCount == 8);
        }


        [Test]
        public void BLL_Custs_Customer_H_GetAllSearch5()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_H_GetAllSearch5()");

            ICustomerBLL bll = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser bll
            bll = CustomerBLLGet();

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
            var actual = bll.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 12 && totalCount == 12);
        }

        [Test]
        public void BLL_Custs_Customer_I_GetAllSearch6()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_I_GetAllSearch6()");

            ICustomerBLL bll = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser bll
            bll = CustomerBLLGet();

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
            var actual = bll.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 5 && totalCount == 5);
        }

        [Test]
        public void BLL_Custs_Customer_J_GetAllSearch7()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_J_GetAllSearch7()");

            ICustomerBLL bll = null;
            int totalCount = 0;
            string message = string.Empty;

            // Arrange - get SystemUser bll
            bll = CustomerBLLGet();

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
            var actual = bll.CustomerGetAll(csf, paging, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(actual.Count == 2 && totalCount == 2);
        }

        [Test]
        public void BLL_Custs_Customer_ZA_Add_ReturnsNewID()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_ZA_Add_ReturnsNewID()");

            ICustomerBLL bll = null;
            CustomerBDO c = null;
            string message = string.Empty;
            int custID = 0;

            // Arrange - get CustomerDALBLL
            bll = CustomerBLLGet();

            // Arrange - create new Customer
            c = new CustomerBDO
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
            custID = bll.CustomerAdd(c, ref message);

            // Assert - did add work
            Assert.True(custID > 0);
        }

        [Test]
        public void BLL_Custs_Customer_ZB_Add_ReturnsNotInserted()
        {
            _log.Info(THIS_CLASS + ": BLL_Custs_Customer_ZB_Add_ReturnsNotInserted()");

            ICustomerBLL bll = null;
            CustomerBDO c = null;
            string message = string.Empty;
            int custID = 0;

            //Arrange - get CustomerDALBLL
            bll = CustomerBLLGet();

            // Arrange - create new Customer
            c = new CustomerBDO
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
            custID = bll.CustomerAdd(c, ref message);

            // Assert - did add work
            Assert.True(custID == 0
                && message == "Cannot insert duplicate key row in object 'Customers.Customer' with unique index 'IDX_Customer_1'. The duplicate key value is (Test CustomerBLLTest).\r\nThe statement has been terminated.");
        }
    }
}
