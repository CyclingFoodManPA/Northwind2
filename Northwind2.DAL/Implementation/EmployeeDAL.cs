/*****************************************************************************
 *        Class Name: EmployeeDAL
 *  Class Decription: Contains data access functionality for Employee
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
    public sealed class EmployeeDAL : Northwind2DAL, IEmployeeDAL
    {
        #region Private Member Variables

        //Private Member Variables
        private const string THIS_CLASS = "EmployeeDAL";

        #endregion Private Member Variables

        #region Public Constructor

        // Public Constructor
        public EmployeeDAL()
            : base()
        {
            //Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }

        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int EmployeeAdd(EmployeeBDO employee, ref string message)
        {
            _log.Info(THIS_CLASS + ": EmployeeAdd; LastName= " + employee.LastName.Trim());
            string sql = Constants.EMPLOYEE_ADD;
            int newEmployeeID = 0;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        PopulateParameters(cmd, employee, true);
                        cnn.Open();

                        if (cmd.ExecuteNonQuery() == 1)
                        {
                            message = "Employee= " + employee.LastName.Trim() + " was inserted successfully!";
                            newEmployeeID = Convert.ToInt32(cmd.Parameters["@newEmployeeID"].Value.ToString());
                        }
                        else
                        {
                            message = "Employee= " + employee.LastName.Trim() + " was **NOT** inserted successfully!";
                            _log.Debug(THIS_CLASS + ": EmployeeAdd; LastName= " + employee.LastName.Trim() + " ErrorMessage: " + message.Trim());
                        }

                    } //using (SqlCommand cmd = new SqlCommand(sql, cnn))
                } //using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": EmployeeAdd; LastName= " + employee.LastName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return newEmployeeID;
        }

        // Read
        public IList<EmployeeBDO> EmployeeGetAll(EmployeeSearchFields searchFields, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": EmployeeGetAll");
            string sql = Constants.EMPLOYEE_GETALL;
            IList<EmployeeBDO> list = null;
            int totCount = 0;
            bool isFirst = true;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        if (searchFields != null)
                            PopulateSearchParameters(cmd, ref searchFields);
                        if (paging != null)
                            PopulatePagingParameters(cmd, ref paging);
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
                                        list = new List<EmployeeBDO>();
                                        isFirst = false;
                                    }

                                    list.Add(PopulateEmployeeBDO(reader));
                                    totCount++;
                                }//while (reader.Read())
                            }//if (reader.HasRows)
                            else
                            {
                                message = "No Employees in the database met the search criteria!";
                                _log.Debug(THIS_CLASS + ": EmployeeGetAll" + " ErrorMessage: " + message.Trim());
                            }
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                totalCount = 0;
                _log.Error(THIS_CLASS + ": EmployeeGetAll" + " ErrorMessage: " + message.Trim());
            }

            //Had to do this asignment as after I put the try {} catch(() block in, code was looking
            //for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItemBDO> EmployeeGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": EmployeeGetAllList");
            List<ListItemBDO> list = null;
            string sql = Constants.EMPLOYEE_GETALLLIST;
            bool isFirst = true;
            int totCount = 0;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cnn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    totCount++;
                                    if (isFirst == true)
                                    {
                                        list = new List<ListItemBDO>();
                                        isFirst = false;
                                    }
                                    list.Add(new ListItemBDO
                                    {
                                        ID = (int)reader["EmployeeID"],
                                        Name = (string)reader["LastName"]
                                    });
                                }
                            }
                            else
                            {
                                message = "There were no Employees in the database to read!";
                                _log.Error(THIS_CLASS + ": EmployeeGetAllList;" + " ErrorMessage: " + message.Trim());
                            }//if (reader.HasRows)
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": EmployeeGetAllList;" + " ErrorMessage: " + message.Trim());
            }

            totalCount = totCount;
            return list;
        }

        public EmployeeBDO EmployeeGetByID(int employeeID, ref string message)
        {
            _log.Info(THIS_CLASS + ": EmployeeGetByID; EmployeeID= " + employeeID.ToString());
            List<ListItemBDO> invoiceList = null;
            EmployeeBDO c = null;
            string sql = Constants.EMPLOYEE_GETBYID;
            bool isFirst = true;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@EmployeeID", employeeID));
                        cnn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                reader.Read();
                                c = PopulateEmployeeBDO(reader);
                                reader.NextResult();
                                if (reader.HasRows)
                                {
                                    while (reader.Read())
                                    {
                                        if (isFirst == true)
                                        {
                                            invoiceList = new List<ListItemBDO>();
                                            isFirst = false;
                                        }
                                        invoiceList.Add(new ListItemBDO
                                        {
                                            ID = (int)reader["ID"],
                                            Name = (string)reader["Name"],
                                            Date = (DateTime)reader["Date"],
                                            Amount = (decimal)reader["Amount"]
                                        });
                                    }

                                    c.Invoices = invoiceList;
                                }
                            }//if (reader.HasRows)
                            else
                            {
                                message = "There were no Employee in the database with EmployeeID= " +
                                    employeeID.ToString().Trim() + " to read!";
                                _log.Debug(THIS_CLASS + ": EmployeeGetByID; EmployeeID= " + employeeID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                            }
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": EmployeeGetByID; EmployeeID= " + employeeID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return c;
        }

        // Update
        public bool EmployeeUpdate(EmployeeBDO p, ref string message)
        {
            _log.Info(THIS_CLASS + ": EmployeeUpdate; EmployeeID= " + p.EmployeeID.ToString());
            string sql = Constants.EMPLOYEE_UPDATE;
            bool isUpdateSuccessful = false;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        PopulateParameters(cmd, p, false);
                        cnn.Open();
                        cmd.ExecuteNonQuery();

                        if (cmd.ExecuteNonQuery() == 1)
                        {
                            message = "Employee= " + p.LastName.Trim() + " was updated successfully!";
                            isUpdateSuccessful = true;
                        }
                        else
                        {
                            message = "Employee= " + p.LastName.Trim() + " was **NOT** updated successfully!";
                            _log.Debug(THIS_CLASS + ": EmployeeUpdate; EmployeeID= " + p.EmployeeID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                        }

                        _log.Debug(THIS_CLASS + ": " + message);

                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": EmployeeUpdate; EmployeeID= " + p.EmployeeID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool EmployeeDelete(int employeeID, ref string message)
        {
            _log.Info(THIS_CLASS + ": EmployeeDelete; EmployeeID= " + employeeID.ToString());
            bool isDeleteSuccessful = false;

            try
            {
                //this.Delete(employeeID);
                //this.CommitAllChanges();
                isDeleteSuccessful = true;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": UpdateEmployee; EmployeeID= " + employeeID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations

        #region Private Routines

        private void PopulateSearchParameters(SqlCommand cmd, ref EmployeeSearchFields searchFields)
        {
            if (!(String.IsNullOrEmpty(searchFields.LastName)))
                cmd.Parameters.Add(new SqlParameter("@LastName", searchFields.LastName));

            if (!(String.IsNullOrEmpty(searchFields.FirstName)))
                cmd.Parameters.Add(new SqlParameter("@FirstName", searchFields.FirstName));

            if (searchFields.TitleID != 0)
                cmd.Parameters.Add(new SqlParameter("@TitleID", searchFields.TitleID));

            if (!(String.IsNullOrEmpty(searchFields.TitleName)))
                cmd.Parameters.Add(new SqlParameter("@TitleName", searchFields.TitleName));

            if (searchFields.TitleOfCourtesyID != 0)
                cmd.Parameters.Add(new SqlParameter("@TitleOfCourtesyID", searchFields.TitleOfCourtesyID));

            if (!(String.IsNullOrEmpty(searchFields.TitleOfCourtesyName)))
                cmd.Parameters.Add(new SqlParameter("@TitleOfCourtesyName", searchFields.TitleOfCourtesyName));

            if (searchFields.BirthDate != null)
                cmd.Parameters.Add(new SqlParameter("@BirthDate", searchFields.BirthDate));

            if (searchFields.HireDate != null)
                cmd.Parameters.Add(new SqlParameter("@HireDate", searchFields.HireDate));

            if (!(String.IsNullOrEmpty(searchFields.Address1)))
                cmd.Parameters.Add(new SqlParameter("@Address1", searchFields.Address1));

            if (!(String.IsNullOrEmpty(searchFields.City)))
                cmd.Parameters.Add(new SqlParameter("@City", searchFields.City));

            if (!(String.IsNullOrEmpty(searchFields.Region)))
                cmd.Parameters.Add(new SqlParameter("@Region", searchFields.Region));

            if (!(String.IsNullOrEmpty(searchFields.PostalCode)))
                cmd.Parameters.Add(new SqlParameter("@PostalCode", searchFields.PostalCode));

            if (searchFields.CountryID != 0)
                cmd.Parameters.Add(new SqlParameter("@CountryID", searchFields.CountryID));

            if (!(String.IsNullOrEmpty(searchFields.CountryName)))
                cmd.Parameters.Add(new SqlParameter("@CountryName", searchFields.CountryName));

            if (!(String.IsNullOrEmpty(searchFields.HomePhone)))
                cmd.Parameters.Add(new SqlParameter("@HomePhone", searchFields.HomePhone));

            if (!(String.IsNullOrEmpty(searchFields.Extension)))
                cmd.Parameters.Add(new SqlParameter("@Extension", searchFields.Extension));

            if (searchFields.ReportsToID !=0 )
                cmd.Parameters.Add(new SqlParameter("@ReportsToID", searchFields.ReportsToID));

            cmd.Parameters.Add(new SqlParameter("@IsActive", searchFields.IsActive));
        }

        private void PopulatePagingParameters(SqlCommand cmd, ref PaginationRequest paging)
        {
            if (paging.PageIndex != 0 && paging.PageSize != 0)
            {
                cmd.Parameters.Add(new SqlParameter("@PageIndex", paging.PageIndex));
                cmd.Parameters.Add(new SqlParameter("@PageSize", paging.PageSize));
            }
            else
            {
                if (paging.PageIndex != 0)
                    cmd.Parameters.Add(new SqlParameter("@PageIndex", paging.PageIndex));
                else
                    cmd.Parameters.Add(new SqlParameter("@PageIndex", 0));

                if (paging.PageSize != 0)
                    cmd.Parameters.Add(new SqlParameter("@PageSize", paging.PageSize));
                else
                    cmd.Parameters.Add(new SqlParameter("@PageSize", 15));
            }
        }

        private EmployeeBDO PopulateEmployeeBDO(SqlDataReader reader)
        {
            EmployeeBDO e = new EmployeeBDO
            {
                EmployeeID = (int)reader["EmployeeID"],
                LastName = (string)reader["LastName"],
                FirstName = (string)reader["FirstName"],
                TitleID = (int)reader["TitleID"],
                TitleOfCourtesyID = (int)reader["TitleOfCourtesyID"],
                BirthDate = (DateTime)reader["BirthDate"],
                HireDate = (DateTime)reader["HireDate"],
                Address1 = reader["Address1"] == DBNull.Value ? "" : (string)reader["Address1"],
                Address2 = reader["Address2"] == DBNull.Value ? "" : (string)reader["Address2"],
                City = reader["City"] == DBNull.Value ? "" : (string)reader["City"],
                Region = reader["Region"] == DBNull.Value ? "" : (string)reader["Region"],
                PostalCode = reader["PostalCode"] == DBNull.Value ? "" : (string)reader["PostalCode"],
                //Default CountryID to UK if CountryID is null
                CountryID = reader["CountryID"] == DBNull.Value ? 23 : (int)reader["CountryID"],
                CountryName = reader["CountryName"] == DBNull.Value ? "" : (string)reader["CountryName"],
                HomePhone = reader["HomePhone"] == DBNull.Value ? "" : (string)reader["HomePhone"],
                Extension = reader["Extension"] == DBNull.Value ? "" : (string)reader["Extension"],
                //Picture = reader["Picture"] == DBNull.Value ? (byte[])0 : (byte)reader["Picture"],
                Notes = reader["Notes"] == DBNull.Value ? "" : (string)reader["Notes"],
                ReportsToID = reader["ReportsToID"] == DBNull.Value ? -1 : (int)reader["ReportsToID"],
                PicturePath = reader["PicturePath"] == DBNull.Value ? "" : (string)reader["PicturePath"],
                IsActive = (bool)reader["IsActive"],
                AddedBy = (string)reader["AddedBy"],
                AddedDate = (DateTime)reader["AddedDate"],
                ModifiedBy = (string)reader["ModifiedBy"],
                ModifiedDate = (DateTime)reader["ModifiedDate"],
                Modified = (byte[])reader["Modified"]
            };

            return e;
        }

        private void PopulateParameters(SqlCommand cmd, EmployeeBDO e, bool isInsert)
        {
            if (isInsert == false)
                cmd.Parameters.Add(new SqlParameter("@EmployeeID", e.EmployeeID));

            cmd.Parameters.Add(new SqlParameter("@LastName", e.LastName));
            cmd.Parameters.Add(new SqlParameter("@FirstName", e.FirstName));
            cmd.Parameters.Add(new SqlParameter("@TitleID", e.TitleID));
            cmd.Parameters.Add(new SqlParameter("@TitleOfCourtesyID", e.TitleOfCourtesyID));
            cmd.Parameters.Add(new SqlParameter("@BirthDate", e.BirthDate));
            cmd.Parameters.Add(new SqlParameter("@HireDate", e.HireDate));
            cmd.Parameters.Add(new SqlParameter("@Address1", e.Address1));
            cmd.Parameters.Add(new SqlParameter("@Address2", e.Address2));
            cmd.Parameters.Add(new SqlParameter("@City", e.City));
            cmd.Parameters.Add(new SqlParameter("@Region", e.Region));
            cmd.Parameters.Add(new SqlParameter("@PostalCode", e.PostalCode));
            cmd.Parameters.Add(new SqlParameter("@CountryID", e.CountryID));
            cmd.Parameters.Add(new SqlParameter("@HomePhone", e.HomePhone));
            cmd.Parameters.Add(new SqlParameter("@Extension", e.Extension));
            cmd.Parameters.Add(new SqlParameter("@Picture", e.Picture));
            cmd.Parameters.Add(new SqlParameter("@Notes", e.Notes));
            cmd.Parameters.Add(new SqlParameter("@ReportsToID", e.ReportsToID));
            cmd.Parameters.Add(new SqlParameter("@PicturePath", e.PicturePath));
            cmd.Parameters.Add(new SqlParameter("@IsActive", e.IsActive));

            if (isInsert == true)
                cmd.Parameters.Add(new SqlParameter("@AddedBy", e.AddedBy));

            cmd.Parameters.Add(new SqlParameter("@ModifiedBy", e.ModifiedBy));

            if (isInsert == true)
            {
                cmd.Parameters.Add(new SqlParameter("@newEmployeeID", e.EmployeeID));
                cmd.Parameters["@newEmployeeID"].Direction = ParameterDirection.Output;
            }

            SqlParameter parameter = new SqlParameter("@newModified", SqlDbType.Timestamp, 8);
            parameter.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parameter);

            cmd.Prepare();
        }

        #endregion Private Routines
    }
}
