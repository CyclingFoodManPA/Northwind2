/*****************************************************************************
 *        Class Name: Northwind2.leProvider
 *  Class Decription: Inherits from System.Web.Security and adds functionality
 *					  to the role provider.
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    Notes: Northwind2.leProvider was based on:
 *                    http://brianlegg.com/post/2011/05/09/Implementing-your-own-RoleProvider-and-MembershipProvider-in-MVC-3.aspx
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.Mvc3UI.Security
{
    using System;
    using System.Web.Security;
    using Northwind2.Common.Infrastructure;
    using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;

    public class Northwind2RoleProvider : RoleProvider
    {
        #region Private Member Variables

        private Northwind2ServiceClient _proxy = null;

        #endregion Private Member Variables

        #region Public Constructor

        public Northwind2RoleProvider()
        {
            try
            {
                _proxy = new Northwind2ServiceClient();
            }
            catch (Exception ex)
            {
                string errMsg = ExceptionHelpers.GetAllMessages(ex);
            }
        }

        #endregion Public Constructor

        #region IsUserInRole

        public override bool IsUserInRole(string username, string roleName)
        {
            UserInRoleRequest uirreq = new UserInRoleRequest { Username = username, RoleName = roleName };
            UserInRoleResponse uirresp = _proxy.ApplicationUserToApplicationRoleIsIn(uirreq);

            return uirresp.IsInRole;
        }

        #endregion IsUserInRole

        #region GetRolesForUser

        public override string[] GetRolesForUser(string username)
        {
            string[] roleNames = null;

            UserInRoleRequest uirreq = new UserInRoleRequest { Username = username };
            UserInRolesResponse uirresp = _proxy.UsernameInApplicationRoles(uirreq);

            if (uirresp.TotalCount > 0)
            {
                roleNames = new string[uirresp.TotalCount];
                for (int x = 0; x < uirresp.TotalCount; x++)
                {
                    roleNames[x] = uirresp.UserToRoleNames[x].ApplicationRoleName;
                }

                return roleNames;
            }
            else
                return new string[] { string.Empty };
        }

        #endregion GetRolesForUser

        #region Not Implemented

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }

        #endregion Not Implemented
    }
}

