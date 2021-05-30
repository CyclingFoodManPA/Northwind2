/*****************************************************************************
 *        Class Name: CustomerDAL
 *  Class Decription: Contains data access functionality for Customer
 *     Inherits From: Northwind2DAL
 *              Date: Friday, July 1, 2016
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
    public sealed class CustomerDAL : Northwind2DAL, ICustomerDAL
    {
        #region Private Member Variables

        //Private Member Variables
        private const string THIS_CLASS = "CustomerDAL";

        #endregion Private Member Variables

        #region Public Constructor

        // Public Constructor
        public CustomerDAL()
            : base()
        {
            //Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }

        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int CustomerAdd(CustomerBDO customer, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerAdd; CustomerName= " + customer.CustomerName.Trim());
            string sql = Constants.CUSTOMER_ADD;
            int newCustomerID = 0;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        PopulateParameters(cmd, customer, true);
                        cnn.Open();

                        if (cmd.ExecuteNonQuery() == 1)
                        {
                            message = "Customer= " + customer.CustomerName.Trim() + " was inserted successfully!";
                            newCustomerID = Convert.ToInt32(cmd.Parameters["@newCustomerID"].Value.ToString());
                        }
                        else
                        {
                            message = "Customer= " + customer.CustomerName.Trim() + " was **NOT** inserted successfully!";
                            _log.Debug(THIS_CLASS + ": CustomerAdd; CustomerName= " + customer.CustomerName.Trim() + " ErrorMessage: " + message.Trim());
                        }

                    } //using (SqlCommand cmd = new SqlCommand(sql, cnn))
                } //using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CustomerAdd; CustomerName= " + customer.CustomerName.Trim() + " ErrorMessage: " + message.Trim());
            }

            return newCustomerID;
        }

        // Read
        public IList<CustomerBDO> CustomerGetAll(CustomerSearchFields searchFields, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerGetAll");
            string sql = Constants.CUSTOMER_GETALL;
            IList<CustomerBDO> list = null;
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
                                        list = new List<CustomerBDO>();
                                        isFirst = false;
                                    }

                                    list.Add(PopulateCustomerBDO(reader));
                                    totCount++;
                                }//while (reader.Read())
                            }//if (reader.HasRows)
                            else
                            {
                                message = "No Customers in the database met the search criteria!";
                                _log.Debug(THIS_CLASS + ": CustomerGetAll" + " ErrorMessage: " + message.Trim());
                            }
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                totalCount = 0;
                _log.Error(THIS_CLASS + ": CustomerGetAll" + " ErrorMessage: " + message.Trim());
            }

            //Had to do this asignment as after I put the try {} catch(() block in, code was looking
            //for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItemBDO> CustomerGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerGetAllList");
            List<ListItemBDO> list = null;
            string sql = Constants.CUSTOMER_GETALLLIST;
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
                                        ID = (int)reader["CustomerID"],
                                        Name = (string)reader["CustomerName"]
                                    });
                                }
                            }
                            else
                            {
                                message = "There were no Customers in the database to read!";
                                _log.Error(THIS_CLASS + ": CustomerGetAllList;" + " ErrorMessage: " + message.Trim());
                            }//if (reader.HasRows)
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CustomerGetAllList;" + " ErrorMessage: " + message.Trim());
            }

            totalCount = totCount;
            return list;
        }

        public CustomerBDO CustomerGetByID(int customerID, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerGetByID; CustomerID= " + customerID.ToString());
            List<ListItemBDO> invoiceList = null;
            CustomerBDO c = null;
            string sql = Constants.CUSTOMER_GETBYID;
            bool isFirst = true;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@CustomerID", customerID));
                        cnn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                reader.Read();
                                c = PopulateCustomerBDO(reader);
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
                                message = "There were no Customer in the database with CustomerID= " +
                                    customerID.ToString().Trim() + " to read!";
                                _log.Debug(THIS_CLASS + ": CustomerGetByID; CustomerID= " + customerID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                            }
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CustomerGetByID; CustomerID= " + customerID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return c;
        }

        // Update
        public bool CustomerUpdate(CustomerBDO p, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerUpdate; CustomerID= " + p.CustomerID.ToString());
            string sql = Constants.CUSTOMER_UPDATE;
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
                            message = "Customer= " + p.CustomerName.Trim() + " was updated successfully!";
                            isUpdateSuccessful = true;
                        }
                        else
                        {
                            message = "Customer= " + p.CustomerName.Trim() + " was **NOT** updated successfully!";
                            _log.Debug(THIS_CLASS + ": CustomerUpdate; CustomerID= " + p.CustomerID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                        }

                        _log.Debug(THIS_CLASS + ": " + message);

                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CustomerUpdate; CustomerID= " + p.CustomerID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

         // Delete
        public bool CustomerDelete(int customerID, ref string message)
        {
            _log.Info(THIS_CLASS + ": CustomerDelete; CustomerID= " + customerID.ToString());
            bool isDeleteSuccessful = false;

            try
            {
                //this.Delete(customerID);
                //this.CommitAllChanges();
                isDeleteSuccessful = true;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": UpdateCustomer; CustomerID= " + customerID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations

        #region Private Routines

        private void PopulateSearchParameters(SqlCommand cmd, ref CustomerSearchFields searchFields)
        {
            if (!(String.IsNullOrEmpty(searchFields.CustomerName)))
                cmd.Parameters.Add(new SqlParameter("@CustomerName", searchFields.CustomerName));

            if (!(String.IsNullOrEmpty(searchFields.ContactName)))
                cmd.Parameters.Add(new SqlParameter("@ContactName", searchFields.ContactName));

            if (searchFields.ContactTitleID != 0)
                cmd.Parameters.Add(new SqlParameter("@ContactTitleID", searchFields.ContactTitleID));

            if (!(String.IsNullOrEmpty(searchFields.ContactTitleName)))
                cmd.Parameters.Add(new SqlParameter("@ContactTitleName", searchFields.ContactTitleName));

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

            if (!(String.IsNullOrEmpty(searchFields.Phone)))
                cmd.Parameters.Add(new SqlParameter("@Phone", searchFields.Phone));

            if (!(String.IsNullOrEmpty(searchFields.Fax)))
                cmd.Parameters.Add(new SqlParameter("@Fax", searchFields.Fax));

            if (!(String.IsNullOrEmpty(searchFields.Email)))
                cmd.Parameters.Add(new SqlParameter("@EMail", searchFields.Email));

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

        private CustomerBDO PopulateCustomerBDO(SqlDataReader reader)
        {
            CustomerBDO cust = new CustomerBDO
            {
                CustomerID = (int)reader["CustomerID"],
                CustomerName = (string)reader["CustomerName"],
                ContactName = (string)reader["ContactName"],
                ContactTitleID = (int)reader["ContactTitleID"],
                ContactTitleName = (string)reader["ContactTitleName"],
                Address1 = reader["Address1"] == DBNull.Value ? "" : (string)reader["Address1"],
                Address2 = reader["Address2"] == DBNull.Value ? "" : (string)reader["Address2"],
                City = reader["City"] == DBNull.Value ? "" : (string)reader["City"],
                Region = reader["Region"] == DBNull.Value ? "" : (string)reader["Region"],
                PostalCode = reader["PostalCode"] == DBNull.Value ? "" : (string)reader["PostalCode"],
                //Default CountryID to UK if CountryID is null
                CountryID = reader["CountryID"] == DBNull.Value ? 23 : (int)reader["CountryID"],
                CountryName = reader["CountryName"] == DBNull.Value ? "" : (string)reader["CountryName"],
                Phone = reader["Phone"] == DBNull.Value ? "" : (string)reader["Phone"],
                Fax = reader["Fax"] == DBNull.Value ? "" : (string)reader["Fax"],
                Email = reader["Email"] == DBNull.Value ? "" : (string)reader["Email"],
                IsActive = (bool)reader["IsActive"],
                AddedBy = (string)reader["AddedBy"],
                AddedDate = (DateTime)reader["AddedDate"],
                ModifiedBy = (string)reader["ModifiedBy"],
                ModifiedDate = (DateTime)reader["ModifiedDate"],
                Modified = (byte[])reader["Modified"]
            };

            return cust;
        }

        private void PopulateParameters(SqlCommand cmd, CustomerBDO c, bool isInsert)
        {
            if (isInsert == false)
                cmd.Parameters.Add(new SqlParameter("@CustomerID", c.CustomerID));

            cmd.Parameters.Add(new SqlParameter("@CustomerName", c.CustomerName));
            cmd.Parameters.Add(new SqlParameter("@ContactName", c.ContactName));
            cmd.Parameters.Add(new SqlParameter("@ContactTitleID", c.ContactTitleID));
            cmd.Parameters.Add(new SqlParameter("@Address1", c.Address1));
            cmd.Parameters.Add(new SqlParameter("@Address2", c.Address2));
            cmd.Parameters.Add(new SqlParameter("@City", c.City));
            cmd.Parameters.Add(new SqlParameter("@Region", c.Region));
            cmd.Parameters.Add(new SqlParameter("@PostalCode", c.PostalCode));
            cmd.Parameters.Add(new SqlParameter("@CountryID", c.CountryID));
            cmd.Parameters.Add(new SqlParameter("@Phone", c.Phone));
            cmd.Parameters.Add(new SqlParameter("@Fax", c.Fax));
            cmd.Parameters.Add(new SqlParameter("@Email", c.Email));
            cmd.Parameters.Add(new SqlParameter("@CustomerIDOld", c.CustomerIDOld));
            cmd.Parameters.Add(new SqlParameter("@IsActive", c.IsActive));

            if (isInsert == true)
                cmd.Parameters.Add(new SqlParameter("@AddedBy", c.AddedBy));

            cmd.Parameters.Add(new SqlParameter("@ModifiedBy", c.ModifiedBy));

            if (isInsert == true)
            {
                cmd.Parameters.Add(new SqlParameter("@newCustomerID", c.CustomerID));
                cmd.Parameters["@newCustomerID"].Direction = ParameterDirection.Output;
            }

            SqlParameter parameter = new SqlParameter("@newModified", SqlDbType.Timestamp, 8);
            parameter.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parameter);

            cmd.Prepare();
        }

        #endregion Private Routines
    }
}
