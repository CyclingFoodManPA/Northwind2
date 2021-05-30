/*****************************************************************************
 *        Class Name: REPOCountryTests
 *  Class Decription: Contains all unit tests for Country Repository
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
    public class REPOCountryTests : REPONorthwind2Tests
    {
        // Private Variables
        private const string THIS_CLASS = "REPCountryTests";

        // Private Routines
        private ICountryRepository CountryRepositoryGet()
        {
            //return DIFactoryForDesigntime.GetInstance<ICountryBLL>();
            return DIFactoryForRuntime.Resolve<ICountryRepository>();
        }

        //[Test]
        //public void REPO_Admin_Country_A_GetByID()
        //{
        //    _log.Info(THIS_CLASS + ": REPO_Admin_Country_A_GetByID()");

        //    ICountryRepository repo = null;
        //    string message = string.Empty;

        //    //Arrange - get CountryRepository
        //    repo = CountryRepositoryGet();

        //    //Act - get list of Country's
        //    var actual = repo.CountryGetByID(1, ref message);
        //    Assert.True(actual.CountryName == "Accounting Manager"
        //        && actual.Customers.Count == 10
        //        && actual.Suppliers.Count == 2);
        //}

        [Test]
        public void REPO_Admin_Country_B_GetAllList_ReturnsActualCountEQ25TotalCountEQ25()
        {
            _log.Info(THIS_CLASS + ": REPO_Admin_Country_B_GetAllList_ReturnsActualCountEQ25TotalCountEQ25()");

            ICountryRepository repo = null;
            int totalCount = 0;
            string message = string.Empty;

            //Arrange - get CountryRepository
            repo = CountryRepositoryGet();

            //Act - get list of Country's
            var actual = repo.CountryGetAllList(out totalCount, ref message);

            //Assert - acquired correct amount of Country's
            Assert.True(actual.Count == 25
                && totalCount == 25);
        }

        //[Test]
        //public void REPO_Admin_Country_C_GetAll_ReturnsCountEQ4TotalCountEQ20()
        //{
        //    _log.Info(THIS_CLASS + ": REPO_Admin_Country_C_GetAll_ReturnsCountEQ4TotalCountEQ20()");

        //    ICountryRepository repo = null;
        //    string contactTitleSearchText = string.Empty;
        //    int totalCount = 0;
        //    string message = string.Empty;

        //    //Arrange - get CountryRepository
        //    repo = CountryRepositoryGet();

        //    // Arrange - create search and paging criteria
        //    PaginationRequest paging = new PaginationRequest()
        //    {
        //        PageSize = 4,
        //        PageIndex = 0,
        //        Sort = new Sort()
        //        {
        //            SortBy = "CountryName",
        //            SortDirection = SortDirection.Ascending
        //        },
        //    };

        //    //Act - get list of Country's
        //    var actual = repo.CountryGetAll(contactTitleSearchText, paging, out totalCount, ref message);

        //    //Assert - acquired correct amount of Country's
        //    Assert.True(actual.Count == 4
        //        && totalCount == 20);
        //}

        //[Test]
        //public void REPO_Admin_Country_D_GetAll_ReturnsCountEQ4TotalCountEQ6()
        //{
        //    _log.Info(THIS_CLASS + ": REPO_Admin_Country_D_GetAll_ReturnsCountEQ4TotalCountEQ6()");

        //    ICountryRepository repo = null;
        //    string contactTitleSearchText = "as";
        //    int totalCount = 0;
        //    string message = string.Empty;

        //    //Arrange - get CountryRepository
        //    repo = CountryRepositoryGet();

        //    // Arrange - create search and paging criteria
        //    PaginationRequest paging = new PaginationRequest()
        //    {
        //        PageSize = 4,
        //        PageIndex = 0,
        //        Sort = new Sort()
        //        {
        //            SortBy = "CountryName",
        //            SortDirection = SortDirection.Ascending
        //        },
        //    };

        //    //Act - get list of Country's
        //    var actual = repo.CountryGetAll(contactTitleSearchText, paging, out totalCount, ref message);

        //    //Assert - acquired correct amount of Country's
        //    Assert.True(actual.Count == 4
        //        && totalCount == 6);
        //}

        //[Test]
        //public void REPO_Admin_Country_E_GetAll_ReturnsCountEQ2TotalCountEQ6()
        //{
        //    _log.Info(THIS_CLASS + ":REPO_Admin_Country_E_GetAll_ReturnsCountEQ2TotalCountEQ6()");

        //    ICountryRepository repo = null;
        //    string contactTitleSearchText = "as";
        //    int totalCount = 0;
        //    string message = string.Empty;

        //    //Arrange - get CountryRepository
        //    repo = CountryRepositoryGet();

        //    // Arrange - create search and paging criteria
        //    PaginationRequest paging = new PaginationRequest()
        //    {
        //        PageSize = 4,
        //        PageIndex = 1,
        //        Sort = new Sort()
        //        {
        //            SortBy = "CountryName",
        //            SortDirection = SortDirection.Ascending
        //        },
        //    };

        //    //Act - get list of Country's
        //    var actual = repo.CountryGetAll(contactTitleSearchText, paging, out totalCount, ref message);

        //    //Assert - acquired correct amount of Country's
        //    Assert.True(actual.Count == 2
        //        && totalCount == 6);
        //}

        //[Test]
        //public void REPO_Admin_Country_F_GetAll_ReturnsCountEQ2TotalCountEQ2()
        //{
        //    _log.Info(THIS_CLASS + ": REPO_Admin_Country_F_GetAll_ReturnsCountEQ2TotalCountEQ2()");

        //    ICountryRepository repo = null;
        //    string contactTitleSearchText = "ad";
        //    int totalCount = 0;
        //    string message = string.Empty;

        //    //Arrange - get CountryRepository
        //    repo = CountryRepositoryGet();

        //    // Arrange - create search and paging criteria
        //    PaginationRequest paging = new PaginationRequest()
        //    {
        //        PageSize = 4,
        //        PageIndex = 0,
        //        Sort = new Sort()
        //        {
        //            SortBy = "CountryName",
        //            SortDirection = SortDirection.Ascending
        //        },
        //    };

        //    //Act - get list of Country's
        //    var actual = repo.CountryGetAll(contactTitleSearchText, paging, out totalCount, ref message);

        //    //Assert - acquired correct amount of Country's
        //    Assert.True(totalCount == 2
        //        && actual.Count == 2);
        //}

        //[Test]
        //public void REPO_Admin_Country_G_GetAll_ReturnsCountEQ0TotalCountEQ0()
        //{
        //    _log.Info(THIS_CLASS + ": REPO_Admin_Country_G_GetAll_ReturnsCountEQ0TotalCountEQ0()");

        //    ICountryRepository repo = null;
        //    string contactTitleSearchText = "ad";
        //    int totalCount = 0;
        //    string message = string.Empty;

        //    //Arrange - get CountryRepository
        //    repo = CountryRepositoryGet();

        //    // Arrange - create search and paging criteria
        //    PaginationRequest paging = new PaginationRequest()
        //    {
        //        PageSize = 4,
        //        PageIndex = 1,
        //        Sort = new Sort()
        //        {
        //            SortBy = "CountryName",
        //            SortDirection = SortDirection.Ascending
        //        },
        //    };

        //    //Act - get list of Country's
        //    var actual = repo.CountryGetAll(contactTitleSearchText, paging, out totalCount, ref message);

        //    //Assert - acquired correct amount of Country's
        //    Assert.True(totalCount == 0
        //        && actual.Count == 0);
        //}

        //[Test]
        //public void REPO_Admin_Country_H_Add_ReturnsNewID()
        //{
        //    _log.Info(THIS_CLASS + ": REPO_Admin_Country_F_Add_ReturnsNewID()");

        //    ICountryRepository repo = null;
        //    Country ct = null;
        //    string message = string.Empty;
        //    int contactTitleID = 0;

        //    //Arrange - get CountryRepository
        //    repo = CountryRepositoryGet();

        //    // Arrange - create new SystemRole
        //    ct = new Country
        //    {

        //        CountryName = "Test BLLCountryTests",
        //        AddedBy = "BLLCountryTests",
        //        ModifiedBy = "BLLCountryTests"
        //    };

        //    // Act - actually add the SystemRole
        //    contactTitleID = repo.CountryAdd(ct, ref message);

        //    // Assert - did add work
        //    Assert.True(contactTitleID > 0);
        //}

        //[Test]
        //public void REPO_Admin_Country_I_Add_ReturnsNotInserted()
        //{
        //    _log.Info(THIS_CLASS + ": REPO_Admin_Country_G_Add_ReturnsNotInserted()");

        //    ICountryRepository repo = null;
        //    Country ct = null;
        //    string message = string.Empty;
        //    int contactTitleID = 0;

        //    //Arrange - get CountryRepository
        //    repo = CountryRepositoryGet();

        //    // Arrange - create new SystemRole
        //    ct = new Country
        //    {
        //        CountryName = "Test BLLCountryTests",
        //        AddedBy = "BLLCountryTests",
        //        ModifiedBy = "BLLCountryTests"
        //    };

        //    // Act - actually add the SystemRole
        //    contactTitleID = repo.CountryAdd(ct, ref message);

        //    // Assert - did add work
        //    Assert.True(contactTitleID == -1);
        //}

        //[Test]
        //public void REPO_Admin_Country_J_Update()
        //{
        //    _log.Info(THIS_CLASS + ": REPO_Admin_Country_H_Update()");

        //    ICountryRepository repo = null;
        //    string contactTitleSearchText = "Test BLLCountryTests";
        //    int totalCount = 0;
        //    string message = string.Empty;
        //    int contactTitleID = 0;
        //    bool updateResult = false;
        //    Country ct = null;

        //    //Arrange - get CountryRepository
        //    repo = CountryRepositoryGet();

        //    // Arrange - create search and paging criteria
        //    PaginationRequest paging = new PaginationRequest()
        //    {
        //        PageSize = 4,
        //        PageIndex = 0,
        //        Sort = new Sort()
        //        {
        //            SortBy = "CountryName",
        //            SortDirection = SortDirection.Ascending
        //        },
        //    };

        //    //Act - get list of Country's
        //    var actual = repo.CountryGetAll(contactTitleSearchText, paging, out totalCount, ref message);

        //    foreach (var x in actual)
        //        if (x.CountryName == "Test BLLCountryTests")
        //            contactTitleID = x.CountryID;

        //    if (contactTitleID > 0)
        //    {
        //        ct = repo.CountryGetByID(contactTitleID, ref message);
        //        ct.CountryName = "Test BLLCountryTests2";

        //        updateResult = repo.CountryUpdate(ct, ref message);
        //        ct = repo.CountryGetByID(contactTitleID, ref message);

        //        // Assert - did add work
        //        Assert.True(ct.CountryName == "Test BLLCountryTests2");
        //    }
        //}

        //[Test]
        //public void REPO_Admin_Country_K_Delete()
        //{
        //    _log.Info(THIS_CLASS + ": REPO_Admin_Country_I_Delete()");

        //    ICountryRepository repo = null;
        //    string contactTitleSearchText = "Test BLLCountryTests2";
        //    int totalCount = 0;
        //    string message = string.Empty;
        //    int contactTitleID = 0;

        //    //Arrange - get CountryRepository
        //    repo = CountryRepositoryGet();

        //    // Arrange - create search and paging criteria
        //    PaginationRequest paging = new PaginationRequest()
        //    {
        //        PageSize = 4,
        //        PageIndex = 0,
        //        Sort = new Sort()
        //        {
        //            SortBy = "CountryName",
        //            SortDirection = SortDirection.Ascending
        //        },
        //    };

        //    //Act - get list of Country's
        //    var actual = repo.CountryGetAll(contactTitleSearchText, paging, out totalCount, ref message);

        //    foreach (var x in actual)
        //        if (x.CountryName == "Test BLLCountryTests2")
        //            contactTitleID = x.CountryID;

        //    if (contactTitleID > 0)
        //    {
        //        bool result = repo.CountryDelete(contactTitleID, ref message);

        //        // Assert - did delete work
        //        Assert.True(result == true);
        //    }
        //}
    }
}
