/*****************************************************************************
 *        Class Name: BLLSecurityTests
 *  Class Decription: Contains all unit tests for BLLSecurity 
 *              Date: Thursday, May 12, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;
using Northwind2.BDO;
using Northwind2.BLL.Implementation;
using Northwind2.Common.Classes;
using Northwind2.DAL.Implementation;
using NUnit.Framework;

namespace Northwind2.BLL.Tests.Security
{
    [TestFixture]
    public class BLLContactTitleTests : BLLNorthwind2Tests
    {
        // Setup Routines DAL
        private const string THIS_CLASS = "SecurityBLLTests";

        private SecurityDAL SecurityDALGet()
        {
            _log.Info(THIS_CLASS + ": CustomerDALGet");

            return new SecurityDAL();
        }

        private SecurityBLL SecurityBLLGet()
        {
            _log.Info(THIS_CLASS + ": CustomerDALBLLGet");

            return new SecurityBLL(SecurityDALGet());
        }

        [Test]
        public void BLL_Security_LoginAuthentication_A_IsValid()
        {
            _log.Info(THIS_CLASS + ":BLL_Security_LoginAuthentication_A_IsValid()");

            SecurityBLL bll = null;
            string message = string.Empty;

            // Arrange - get Customer bll
            bll = SecurityBLLGet();

            SecurityRequestFields input = new SecurityRequestFields
            {
                Username = "ksafford",
                Password = "c33a803c91c3afd19e6f4a9c5e120c8a"
            };

            // Act - read Customer and save child entity counts   
            bool isValid = bll.LoginAuthentication(input, ref message);

            // Assert - see if action worked or failed
            Assert.True(isValid == true);
        }

        [Test]
        public void BLL_Security_LoginAuthentication_B_IsValid()
        {
            _log.Info(THIS_CLASS + ": BLL_Security_LoginAuthentication_B_IsValid()");

            SecurityBLL bll = null;
            string message = string.Empty;

            // Arrange - get Customer bll
            bll = SecurityBLLGet();

            SecurityRequestFields input = new SecurityRequestFields
            {
                Username = "ksafford",
                Password = "c33a803c91c3afd19e6f4a9c5e120c9b"
            };

            // Act - read Customer and save child entity counts   
            bool isValid = bll.LoginAuthentication(input, ref message);

            // Assert - see if action worked or failed
            Assert.True(isValid == false);
        }

        [Test]
        public void BLL_Security_LoginAuthentication_C_IsValid()
        {
            _log.Info(THIS_CLASS + ": BLL_Security_LoginAuthentication_C_IsValid()");

            SecurityBLL bll = null;
            string message = string.Empty;

            // Arrange - get Customer bll
            bll = SecurityBLLGet();

            SecurityRequestFields input = new SecurityRequestFields
            {
                Username = "ksafford1",
                Password = "c33a803c91c3afd19e6f4a9c5e120c8a"
            };

            // Act - read Customer and save child entity counts   
            bool isValid = bll.LoginAuthentication(input, ref message);

            // Assert - see if action worked or failed
            Assert.True(isValid == false);
        }

        [Test]
        public void BLL_Security_UsernameIsInRoleName_D_IsInAdministratorRoleName()
        {
            _log.Info(THIS_CLASS + ": BLL_Security_UsernameIsInRoleName_D_IsInAdministratorRoleName()");

            SecurityBLL bll = null;
            string message = string.Empty;

            // Arrange - get Customer bll
            bll = SecurityBLLGet();

            SecurityRequestFields input = new SecurityRequestFields
            {
                Username = "ksafford",
                RoleName = "Administrator"
            };

            // Act - read Customer and save child entity counts   
            bool isIn = bll.ApplicationUserToApplicationRole_IsIn(input, ref message);

            // Assert - see if action worked or failed
            Assert.True(isIn == true);
        }

        [Test]
        public void BLL_Security_UsernameIsInRoleName_E_IsInSalesRoleName()
        {
            _log.Info(THIS_CLASS + ": BLL_Security_UsernameIsInRoleName_E_IsInSalesRoleName()");

            SecurityBLL bll = null;
            string message = string.Empty;

            // Arrange - get Customer bll
            bll = SecurityBLLGet();

            SecurityRequestFields input = new SecurityRequestFields
            {
                Username = "ksafford",
                RoleName = "Sales"
            };

            // Act - read Customer and save child entity counts   
            bool isIn = bll.ApplicationUserToApplicationRole_IsIn(input, ref message);

            // Assert - see if action worked or failed
            Assert.True(isIn == true);
        }

        [Test]
        public void BLL_Security_UsernameIsInRoleName_F_IsInProductsRoleName()
        {
            _log.Info(THIS_CLASS + ": BLL_Security_UsernameIsInRoleName_F_IsInProductsRoleName()");

            SecurityBLL bll = null;
            string message = string.Empty;

            // Arrange - get Customer bll
            bll = SecurityBLLGet();

            SecurityRequestFields input = new SecurityRequestFields
            {
                Username = "ksafford",
                RoleName = "Products"
            };

            // Act - read Customer and save child entity counts   
            bool isIn = bll.ApplicationUserToApplicationRole_IsIn(input, ref message);

            // Assert - see if action worked or failed
            Assert.True(isIn == false);
        }

        [Test]
        public void BLL_Security_UsernameApplicationRoles_G_TotalCount2()
        {
            _log.Info(THIS_CLASS + ": BLL_Security_UsernameIsInRoleName_F_IsInProductsRoleName()");

            SecurityBLL bll = null;
            string message = string.Empty;
            int totalCount = 0;
            IList<UserFullNameToRoleNameBDO> list;

            // Arrange - get Customer bll
            bll = SecurityBLLGet();

            SecurityRequestFields input = new SecurityRequestFields
            {
                Username = "ksafford"
            };
    
            // Act - read Customer and save child entity counts   
            list = bll.UsernameApplicationRoles(input, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(list.Count == 2);
        }

        [Test]
        public void BLL_Security_UsernameApplicationRoles_H_TotalCount2()
        {
            _log.Info(THIS_CLASS + ": BLL_Security_UsernameIsInRoleName_H_IsInProductsRoleName()");

            SecurityBLL bll = null;
            string message = string.Empty;
            int totalCount = 0;
            IList<UserFullNameToRoleNameBDO> list;

            // Arrange - get Customer bll
            bll = SecurityBLLGet();

            SecurityRequestFields input = new SecurityRequestFields
            {
                Username = "jjones"
            };

            // Act - read Customer and save child entity counts   
            list = bll.UsernameApplicationRoles(input, out totalCount, ref message);

            // Assert - see if action worked or failed
            Assert.True(list ==  null);
        }

    }
}
