/*****************************************************************************
 *        Class Name: REPOContactTitleTests
 *  Class Decription: Contains all unit tests for ContactTitle Repository
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

namespace Northwind2.Repositories.Tests.Administration
{
    [TestFixture]
    public class REPOContactTitleTests : REPONorthwind2Tests
    {
        // Private Variables
        private const string THIS_CLASS = "REPContactTitleTests";

        // Private Routines
        private IContactTitleRepository ContactTitleRepositoryGet()
        {
            //return DIFactoryForDesigntime.GetInstance<IContactTitleBLL>();
            return DIFactoryForRuntime.Resolve<IContactTitleRepository>();
        }

        [Test]
        public void REPO_Admin_ContactTitle_A_GetByID()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_ContactTitle_A_GetByID()");

            IContactTitleRepository repo = null;
            string message = string.Empty;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            //Act - get list of ContactTitle's
            var actual = repo.ContactTitleGetByID(1, ref message);
            Assert.True(actual.ContactTitleName == "Accounting Manager"
                && actual.Customers.Count == 10
                && actual.Suppliers.Count == 2);
        }

        [Test]
        public void REPO_Admin_ContactTitle_B_GetAllList_ReturnsActualCountEQ20TotalCountEQ20()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_ContactTitle_B_GetAllList_ReturnsActualCountEQ20TotalCountEQ20()");

            IContactTitleRepository repo = null;
            int totalCount = 0;
            string message = string.Empty;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            //Act - get list of ContactTitle's
            var actual = repo.ContactTitleGetAllList(out totalCount, ref message);

            //Assert - acquired correct amount of ContactTitle's
            Assert.True(actual.Count == 20
                && totalCount == 20);
        }

        [Test]
        public void REPO_Admin_ContactTitle_C_GetAll_ReturnsCountEQ4TotalCountEQ20()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_ContactTitle_C_GetAll_ReturnsCountEQ4TotalCountEQ20()");

            IContactTitleRepository repo = null;
            string contactTitleSearchText = string.Empty;
            int totalCount = 0;
            string message = string.Empty;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            // Arrange - create search and paging criteria
            PaginationRequest paging = new PaginationRequest()
            {
                PageSize = 4,
                PageIndex = 0,
                Sort = new Sort()
                {
                    SortBy = "ContactTitleName",
                    SortDirection = SortDirection.Ascending
                },
            };

            //Act - get list of ContactTitle's
            var actual = repo.ContactTitleGetAll(contactTitleSearchText, paging, out totalCount, ref message);

            //Assert - acquired correct amount of ContactTitle's
            Assert.True(actual.Count == 4
                && totalCount == 20);
        }

        [Test]
        public void REPO_Admin_ContactTitle_D_GetAll_ReturnsCountEQ4TotalCountEQ6()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_ContactTitle_D_GetAll_ReturnsCountEQ4TotalCountEQ6()");

            IContactTitleRepository repo = null;
            string contactTitleSearchText = "as";
            int totalCount = 0;
            string message = string.Empty;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            // Arrange - create search and paging criteria
            PaginationRequest paging = new PaginationRequest()
            {
                PageSize = 4,
                PageIndex = 0,
                Sort = new Sort()
                {
                    SortBy = "ContactTitleName",
                    SortDirection = SortDirection.Ascending
                },
            };

            //Act - get list of ContactTitle's
            var actual = repo.ContactTitleGetAll(contactTitleSearchText, paging, out totalCount, ref message);

            //Assert - acquired correct amount of ContactTitle's
            Assert.True(actual.Count == 4
                && totalCount == 6);
        }

        [Test]
        public void REPO_Admin_ContactTitle_E_GetAll_ReturnsCountEQ2TotalCountEQ6()
        {
            _log.Info(THIS_CLASS + ":REPO_Admin_ContactTitle_E_GetAll_ReturnsCountEQ2TotalCountEQ6()");

            IContactTitleRepository repo = null;
            string contactTitleSearchText = "as";
            int totalCount = 0;
            string message = string.Empty;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            // Arrange - create search and paging criteria
            PaginationRequest paging = new PaginationRequest()
            {
                PageSize = 4,
                PageIndex = 1,
                Sort = new Sort()
                {
                    SortBy = "ContactTitleName",
                    SortDirection = SortDirection.Ascending
                },
            };

            //Act - get list of ContactTitle's
            var actual = repo.ContactTitleGetAll(contactTitleSearchText, paging, out totalCount, ref message);

            //Assert - acquired correct amount of ContactTitle's
            Assert.True(actual.Count == 2
                && totalCount == 6);
        }

        [Test]
        public void REPO_Admin_ContactTitle_F_GetAll_ReturnsCountEQ2TotalCountEQ2()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_ContactTitle_F_GetAll_ReturnsCountEQ2TotalCountEQ2()");

            IContactTitleRepository repo = null;
            string contactTitleSearchText = "ad";
            int totalCount = 0;
            string message = string.Empty;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            // Arrange - create search and paging criteria
            PaginationRequest paging = new PaginationRequest()
            {
                PageSize = 4,
                PageIndex = 0,
                Sort = new Sort()
                {
                    SortBy = "ContactTitleName",
                    SortDirection = SortDirection.Ascending
                },
            };

            //Act - get list of ContactTitle's
            var actual = repo.ContactTitleGetAll(contactTitleSearchText, paging, out totalCount, ref message);

            //Assert - acquired correct amount of ContactTitle's
            Assert.True(totalCount == 2
                && actual.Count == 2);
        }

        [Test]
        public void REPO_Admin_ContactTitle_G_GetAll_ReturnsCountEQ0TotalCountEQ0()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_ContactTitle_G_GetAll_ReturnsCountEQ0TotalCountEQ0()");

            IContactTitleRepository repo = null;
            string contactTitleSearchText = "ad";
            int totalCount = 0;
            string message = string.Empty;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            // Arrange - create search and paging criteria
            PaginationRequest paging = new PaginationRequest()
            {
                PageSize = 4,
                PageIndex = 1,
                Sort = new Sort()
                {
                    SortBy = "ContactTitleName",
                    SortDirection = SortDirection.Ascending
                },
            };

            //Act - get list of ContactTitle's
            var actual = repo.ContactTitleGetAll(contactTitleSearchText, paging, out totalCount, ref message);

            //Assert - acquired correct amount of ContactTitle's
            Assert.True(totalCount == 0
                && actual.Count == 0);
        }

        [Test]
        public void REPO_Admin_ContactTitle_H_Add_ReturnsNewID()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_ContactTitle_F_Add_ReturnsNewID()");

            IContactTitleRepository repo = null;
            ContactTitle ct = null;
            string message = string.Empty;
            int contactTitleID = 0;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            // Arrange - create new SystemRole
            ct = new ContactTitle
            {

                ContactTitleName = "Test BLLContactTitleTests",
                AddedBy = "BLLContactTitleTests",
                ModifiedBy = "BLLContactTitleTests"
            };

            // Act - actually add the SystemRole
            contactTitleID = repo.ContactTitleAdd(ct, ref message);

            // Assert - did add work
            Assert.True(contactTitleID > 0);
        }

        [Test]
        public void REPO_Admin_ContactTitle_I_Add_ReturnsNotInserted()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_ContactTitle_G_Add_ReturnsNotInserted()");

            IContactTitleRepository repo = null;
            ContactTitle ct = null;
            string message = string.Empty;
            int contactTitleID = 0;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            // Arrange - create new SystemRole
            ct = new ContactTitle
            {
                ContactTitleName = "Test BLLContactTitleTests",
                AddedBy = "BLLContactTitleTests",
                ModifiedBy = "BLLContactTitleTests"
            };

            // Act - actually add the SystemRole
            contactTitleID = repo.ContactTitleAdd(ct, ref message);

            // Assert - did add work
            Assert.True(contactTitleID == -1);
        }

        [Test]
        public void REPO_Admin_ContactTitle_J_Update()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_ContactTitle_H_Update()");

            IContactTitleRepository repo = null;
            string contactTitleSearchText = "Test BLLContactTitleTests";
            int totalCount = 0;
            string message = string.Empty;
            int contactTitleID = 0;
            bool updateResult = false;
            ContactTitle ct = null;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            // Arrange - create search and paging criteria
            PaginationRequest paging = new PaginationRequest()
            {
                PageSize = 4,
                PageIndex = 0,
                Sort = new Sort()
                {
                    SortBy = "ContactTitleName",
                    SortDirection = SortDirection.Ascending
                },
            };

            //Act - get list of ContactTitle's
            var actual = repo.ContactTitleGetAll(contactTitleSearchText, paging, out totalCount, ref message);

            foreach (var x in actual)
                if (x.ContactTitleName == "Test BLLContactTitleTests")
                    contactTitleID = x.ContactTitleID;

            if (contactTitleID > 0)
            {
                ct = repo.ContactTitleGetByID(contactTitleID, ref message);
                ct.ContactTitleName = "Test BLLContactTitleTests2";
                ct.IsActive = true;
                updateResult = repo.ContactTitleUpdate(ct, ref message);
                ct = repo.ContactTitleGetByID(contactTitleID, ref message);

                // Assert - did add work
                Assert.True(ct.ContactTitleName == "Test BLLContactTitleTests2");
            }
        }

        [Test]
        public void REPO_Admin_ContactTitle_K_Delete()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_ContactTitle_I_Delete()");

            IContactTitleRepository repo = null;
            string contactTitleSearchText = "Test BLLContactTitleTests2";
            int totalCount = 0;
            string message = string.Empty;
            int contactTitleID = 0;

            //Arrange - get ContactTitleRepository
            repo = ContactTitleRepositoryGet();

            // Arrange - create search and paging criteria
            PaginationRequest paging = new PaginationRequest()
            {
                PageSize = 4,
                PageIndex = 0,
                Sort = new Sort()
                {
                    SortBy = "ContactTitleName",
                    SortDirection = SortDirection.Ascending
                },
            };

            //Act - get list of ContactTitle's
            var actual = repo.ContactTitleGetAll(contactTitleSearchText, paging, out totalCount, ref message);

            foreach (var x in actual)
                if (x.ContactTitleName == "Test BLLContactTitleTests2")
                    contactTitleID = x.ContactTitleID;

            if (contactTitleID > 0)
            {
                bool result = repo.ContactTitleDelete(contactTitleID, ref message);

                // Assert - did delete work
                Assert.True(result == true);
            }
        }
    }
}
