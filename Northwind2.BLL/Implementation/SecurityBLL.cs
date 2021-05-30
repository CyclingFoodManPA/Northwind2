/*****************************************************************************
 *        Class Name: SecurityBLL
 *  Class Decription: Contains functionality for the business logic layer for 
 *                    Security
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.BLL.Implementation
{
    using System.Collections.Generic;
    using Northwind2.BDO;
    using Northwind2.BLL;
    using Northwind2.BLL.Contracts;
    using Northwind2.Common.Classes;
    using Northwind2.DAL.Contracts;

    public sealed class SecurityBLL : Northwind2BLL, ISecurityBLL
    {
        private const string THIS_CLASS = "SecurityBLL";
        private ISecurityDAL _securityDAL;

        public SecurityBLL(ISecurityDAL securityDAL)
        {
            // Get _logger for SecurityBLL
            _log.Info(THIS_CLASS + ": Public Constructor");
            _securityDAL = securityDAL;
        }

        public bool LoginAuthentication(SecurityRequestFields input, ref string message)
        {
            _log.Info(THIS_CLASS + ": LoginAuthentication" + " " + input.Username.Trim() );
            return this._securityDAL.LoginAuthentication(input, ref message);
        }

        public bool ApplicationUserToApplicationRole_IsIn(SecurityRequestFields request, ref string message)
        {
            _log.Info(THIS_CLASS + ": ApplicationUserToApplicationRole_IsIn" + " Username= " + 
                request.Username.Trim() + " RoleName= " + request.RoleName.Trim());
            return this._securityDAL.ApplicationUserToApplicationRole_IsIn(request, ref message);
        }

        public IList<UserFullNameToRoleNameBDO> UsernameApplicationRoles(SecurityRequestFields request, 
            out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": UsernameApplicationRoles" + " " + request.Username.Trim());
            return this._securityDAL.UsernameApplicationRoles(request, out totalCount, ref message);
        }
    }
}
