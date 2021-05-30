/*****************************************************************************
 *        Class Name: Northwind2.mbershipProvider
 *  Class Decription: Inherits from System.Web.Security and adds functionality
 *					  to the membership provider.
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    Notes: Northwind2.leProvider was based on:
 *                    http://brianlegg.com/post/2011/05/09/Implementing-your-own-RoleProvider-and-MembershipProvider-in-MVC-3.aspx
 *                    http://www.miraclesalad.com/webtools/md5.php
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

    public class Northwind2MembershipProvider : MembershipProvider
    {
        #region Private Member Variables

        private Northwind2ServiceClient _proxy = null;

        #endregion Private Member Variables

        public override int MinRequiredPasswordLength
        {
            get { return 6; }
        }

        #region Public Constructor

        public Northwind2MembershipProvider()
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

        #region Validate User

        public override bool ValidateUser(string username, string password)
        {
            bool isValidUser = false;
            string message = string.Empty;

            if (!(string.IsNullOrEmpty(password.Trim())
            || string.IsNullOrEmpty(username.Trim())))
            {
                string hash = FormsAuthentication.HashPasswordForStoringInConfigFile(password.Trim(), "md5");            
                LoginRequest loginRequest = new LoginRequest { Username = username, Password = hash };
                LoginResponse loginResponse = _proxy.LoginAuthentication(loginRequest);
                isValidUser = loginResponse.IsValid;
            }

            return isValidUser;
        }

        #endregion Validate User

        //public void Create(string username, string fullName, string password, string email, string roleName) {

        //  string hash = FormsAuthentication.HashPasswordForStoringInConfigFile(password.Trim(), "md5");
        //  User user = new User
        //  {
        //    Name = fullName,
        //    Username = username,
        //    Password = hash,
        //    Email = email,
        //    DateAdded = DateTime.Now,
        //    DateLastChanged = DateTime.Now,
        //    AddedBy = HttpContext.Current.User.Identity.Name,
        //    LastChangedBy = HttpContext.Current.User.Identity.Name
        //  };

        //  this.userRepository.Create(username, fullName, password, email, roleName);
        //}

        //public void Create(string username, string name, string password, string email, string roleName) {
        //  Role role = GetRole(roleName);
        //  if (string.IsNullOrEmpty(username.Trim()))
        //    throw new ArgumentException("The user name provided is invalid. Please check the value and try again.");
        //  if (string.IsNullOrEmpty(name.Trim()))
        //    throw new ArgumentException("The name provided is invalid. Please check the value and try again.");
        //  if (string.IsNullOrEmpty(password.Trim()))
        //    throw new ArgumentException("The password provided is invalid. Please enter a valid password value.");
        //  if (string.IsNullOrEmpty(email.Trim()))
        //    throw new ArgumentException("The e-mail address provided is invalid. Please check the value and try again.");
        //  if (!RoleExists(role))
        //    throw new ArgumentException("The role selected for this user does not exist! Contact an administrator!");
        //  if (this.entities.Users.Any(user => user.Username == username))
        //    throw new ArgumentException("Username already exists. Please enter a different user name.");

        //  User newUser = new User() {
        //    Username = username,
        //    Name = name,
        //    Password = FormsAuthentication.HashPasswordForStoringInConfigFile(password.Trim(), "md5"),
        //    Email = email,
        //    RoleId = role.Id,
        //    DateAdded = DateTime.Now,
        //    DateLastChanged = DateTime.Now,
        //    AddedBy = HttpContext.Current.User.Identity.Name,
        //    LastChangedBy = HttpContext.Current.User.Identity.Name
        //  };

        //  try {
        //    AddUser(newUser);
        //  }
        //  catch (ArgumentException ae) {
        //    throw ae;
        //  }
        //  catch (Exception e) {
        //    throw new ArgumentException("The authentication provider returned an error. Please verify your entry and try again. " +
        //      "If the problem persists, please contact your system administrator.");
        //  }

        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            //  if (!ValidateUser(username, oldPassword) || string.IsNullOrEmpty(newPassword.Trim()))
            //    return false;

            //  User user = userRepository.GetUser(username);
            //  string hash = FormsAuthentication.HashPasswordForStoringInConfigFile(newPassword.Trim(), "md5");
            //  user.Password = hash;
            //  repository.Save();
            return true;
        }

        #region Not Implemented

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

        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            throw new NotImplementedException();
        }

        public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            throw new NotImplementedException();
        }

        public override bool EnablePasswordReset
        {
            get { throw new NotImplementedException(); }
        }

        public override bool EnablePasswordRetrieval
        {
            get { throw new NotImplementedException(); }
        }

        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override int GetNumberOfUsersOnline()
        {
            throw new NotImplementedException();
        }

        public override string GetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            throw new NotImplementedException();
        }

        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            throw new NotImplementedException();
        }

        public override string GetUserNameByEmail(string email)
        {
            throw new NotImplementedException();
        }

        public override int MaxInvalidPasswordAttempts
        {
            get { throw new NotImplementedException(); }
        }

        public override int MinRequiredNonAlphanumericCharacters
        {
            get { throw new NotImplementedException(); }
        }

        public override int PasswordAttemptWindow
        {
            get { throw new NotImplementedException(); }
        }

        public override MembershipPasswordFormat PasswordFormat
        {
            get { throw new NotImplementedException(); }
        }

        public override string PasswordStrengthRegularExpression
        {
            get { throw new NotImplementedException(); }
        }

        public override bool RequiresQuestionAndAnswer
        {
            get { throw new NotImplementedException(); }
        }

        public override bool RequiresUniqueEmail
        {
            get { throw new NotImplementedException(); }
        }

        public override string ResetPassword(string username, string answer)
        {
            throw new NotImplementedException();
        }

        public override bool UnlockUser(string userName)
        {
            throw new NotImplementedException();
        }

        public override void UpdateUser(MembershipUser user)
        {
            throw new NotImplementedException();
        }

        #endregion Not Implemented
    }
}