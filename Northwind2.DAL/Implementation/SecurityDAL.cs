/*****************************************************************************
 *        Class Name: SecurityDAL
 *  Class Decription: Contains data access functionality for Security
 *     Inherits From: Northwind2DAL
 *              Date: Friday, July 8, 2016
 *            Author: ksafford
 *             
 *  http:// articles.runtings.co.uk/2010/04/solved-located-assemblys-manifest.html
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Northwind2.BDO;
using Northwind2.Common.Classes;
using Northwind2.Common.Constants;
using Northwind2.Common.Infrastructure;
using Northwind2.DAL.Contracts;

namespace Northwind2.DAL.Implementation
{
    public class SecurityDAL : Northwind2DAL, ISecurityDAL
    {
        #region Private Member Variables

        // Private Member Variables
        private const string THIS_CLASS = "SecurityDAL";

        #endregion Private Member Variables

        #region Public Constructor

        // Public Constructor
        public SecurityDAL()
            : base()
        {
            // Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }

        #endregion Public Constructor
        
        public bool LoginAuthentication(SecurityRequestFields request, ref string message)
        {
            _log.Info(THIS_CLASS + ": LoginAuthentication; UserName " + request.Username.Trim());
            string sql = Constants.SECURITY_APPLICATIONUSER_ISVALID;
            bool isValid = false;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@Username", request.Username));
                        cmd.Parameters.Add(new SqlParameter("@Password", request.Password));

                        SqlParameter parameter = new SqlParameter("@IsValid", SqlDbType.Bit);
                        parameter.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(parameter);
                        cmd.Prepare();

                        cnn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            isValid = (bool)cmd.Parameters["@IsValid"].Value;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": IsValidUser; UserName= " +
                    request.Username.Trim() + " ErrorMessage: " +
                    message.Trim());
            }

            return isValid;
        }

        public bool ApplicationUserToApplicationRole_IsIn(SecurityRequestFields request, ref string message)
        {
            _log.Info(THIS_CLASS + ": ApplicationUserToApplicationRole_IsIn" + " Username= " + request.Username.Trim() + " RoleName= " + request.RoleName.Trim());
            string sql = Constants.SECURITY_APPLICATIONUSERINAPPLICATIONROLE;
            bool isIn = false;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@Username", request.Username.Trim()));
                        cmd.Parameters.Add(new SqlParameter("@RoleName", request.RoleName.Trim()));

                        SqlParameter parameter = new SqlParameter("@IsIn", SqlDbType.Bit);
                        parameter.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(parameter);
                        cmd.Prepare();

                        cnn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            isIn = (bool)cmd.Parameters["@IsIn"].Value;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": IsValidUser; UserName= " +
                    request.Username.Trim() + " ErrorMessage: " +
                    message.Trim());
            }

            return isIn;
        }

        public IList<UserFullNameToRoleNameBDO> UsernameApplicationRoles(SecurityRequestFields request, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": UsernameApplicationRoles" + " Username= " + request.Username.Trim());
            string sql = Constants.SECURITY_APPLICATIONUSERTOAPPLICATIONROLES;
            IList<UserFullNameToRoleNameBDO> list = null;
            int totCount = 0;
            bool isFirst = true;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@Username", request.Username.Trim()));
                        cmd.Prepare();

                        cnn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    if (isFirst == true)
                                    {
                                        list = new List<UserFullNameToRoleNameBDO>();
                                        isFirst = false;
                                    }

                                    list.Add(PopulateUserToRoleNameBDO(reader));
                                    totCount++;
                                }//while (reader.Read())
                            }//if (reader.HasRows)
                            else
                            {
                                message = "No Usernames in the with the Username of " + request.Username.Trim() + " exist!" ;
                                _log.Debug(THIS_CLASS + ": UsernameApplicationRoles" + " ErrorMessage: " + message.Trim());
                            }
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": IsValidUser; UserName= " +
                    request.Username.Trim() + " ErrorMessage: " +
                    message.Trim());
            }

            //Had to do this asignment as after I put the try {} catch(() block in, code was looking
            //for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        private UserFullNameToRoleNameBDO PopulateUserToRoleNameBDO(SqlDataReader reader)
        {
            UserFullNameToRoleNameBDO auar = new UserFullNameToRoleNameBDO
            {
                ApplicationUserID = (int)reader["ApplicationUserID"],
                ApplicationUserLastName = (string)reader["ApplicationUserLastName"],
                ApplicationUserFirstName = (string)reader["ApplicationUserFirstName"],
                Username = (string)reader["Username"],
                ApplicationRoleID = (int)reader["ApplicationRoleID"],
                ApplicationRoleName = (string)reader["ApplicationRoleName"]
            };

            return auar;
        }

        public ApplicationUserBDO ApplicationUserGetByUsername(string username, ref string message)
        {
            _log.Info(THIS_CLASS + ": ApplicationUserGetByUsername; Username " + username.Trim());
            string sql = Constants.SECURITY_APPLICATIONUSER_GETBYUSERNAME;
            ApplicationUserBDO user = null;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("Username", username));
                        cmd.Prepare();

                        cnn.Open();

                       using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                reader.Read();
                                user = PopulateApplicationUserBDO(reader);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": IsValidUser; UserName= " +
                    username.Trim() + " ErrorMessage: " +
                    message.Trim());
            }

            return user;
        }

        private ApplicationUserBDO PopulateApplicationUserBDO(SqlDataReader reader)
        {
            ApplicationUserBDO user = new ApplicationUserBDO
            {
                ApplicationUserID = (int)reader["ApplicationUserID"],
                ApplicationUserLastName = (string)reader["ApplicationUserLastName"],
                ApplicationUserFirstName = (string)reader["ApplicationUserFirstName"],     
                UserName = (string)reader["Username"],
                Password = (string)reader["Password"],
                Email = (string)reader["Email"],
                LastLoginDate = (DateTime)reader["LastLoginDate"],
                LastActivityDate = (DateTime)reader ["LastActivityDate"],
                LastPasswordChangeDate = (DateTime)reader["LastPasswordChangeDate"],
                IsActive = (bool)reader["IsActive"],
                AddedBy = (string)reader["AddedBy"],
                AddedDate = (DateTime)reader["AddedDate"],
                ModifiedBy = (string)reader["ModifiedBy"],
                ModifiedDate = (DateTime)reader["ModifiedDate"],
                Modified = (byte[])reader["Modified"]
            };

            return user;
        } 
    }
}
