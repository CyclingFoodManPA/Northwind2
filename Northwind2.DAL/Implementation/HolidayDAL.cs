/*****************************************************************************
 *        Class Name: HolidayDAL
 *  Class Decription: Contains data access functionality for Holiday
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
    public sealed class HolidayDAL : Northwind2DAL, IHolidayDAL
    {
        #region Private Member Variables

        //Private Member Variables
        private const string THIS_CLASS = "HolidayDAL";

        #endregion Private Member Variables

        #region Public Constructor

        // Public Constructor
        public HolidayDAL()
            : base()
        {
            //Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }

        #endregion Public Constructor

        #region CRUD Operations

        // Create
        public int HolidayAdd(HolidayBDO holiday, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayAdd; HolidayDate= " + holiday.HolidayDate.ToShortDateString().Trim());
            string sql = Constants.HOLIDAY_ADD;
            int newHolidayID = 0;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        PopulateParameters(cmd, holiday, true);
                        cnn.Open();

                        if (cmd.ExecuteNonQuery() == 1)
                        {
                            message = "Holiday= " + holiday.HolidayDate.ToShortDateString().Trim() + " was inserted successfully!";
                            newHolidayID = Convert.ToInt32(cmd.Parameters["@newHolidayID"].Value.ToString());
                        }
                        else
                        {
                            message = "Holiday= " + holiday.HolidayDate.ToShortDateString().Trim() + " was **NOT** inserted successfully!";
                            _log.Debug(THIS_CLASS + ": HolidayAdd; HolidayName= " + holiday.HolidayDate.ToShortDateString().Trim() + " ErrorMessage: " + message.Trim());
                        }

                    } //using (SqlCommand cmd = new SqlCommand(sql, cnn))
                } //using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": HolidayAdd; HolidayName= " + holiday.HolidayDate.ToShortDateString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return newHolidayID;
        }

        // Read
        public IList<HolidayBDO> HolidayGetAll(HolidaySearchFields searchFields, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayGetAll");
            string sql = Constants.HOLIDAY_GETALL;
            IList<HolidayBDO> list = null;
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
                                        list = new List<HolidayBDO>();
                                        isFirst = false;
                                    }

                                    list.Add(PopulateHolidayBDO(reader));
                                    totCount++;
                                }//while (reader.Read())
                            }//if (reader.HasRows)
                            else
                            {
                                message = "No Holidays in the database met the search criteria!";
                                _log.Debug(THIS_CLASS + ": HolidayGetAll" + " ErrorMessage: " + message.Trim());
                            }
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                totalCount = 0;
                _log.Error(THIS_CLASS + ": HolidayGetAll" + " ErrorMessage: " + message.Trim());
            }

            //Had to do this asignment as after I put the try {} catch(() block in, code was looking
            //for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        public IList<ListItemBDO> HolidayGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayGetAllList");
            List<ListItemBDO> list = null;
            string sql = Constants.HOLIDAY_GETALLLIST;
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
                                        ID = (int)reader["HolidayID"],
                                        Name = (string)reader["HolidayDescriptionName"],
                                        Date = (DateTime)reader["HolidayDate"]
                                    });
                                }
                            }
                            else
                            {
                                message = "There were no Holidays in the database to read!";
                                _log.Error(THIS_CLASS + ": HolidayGetAllList;" + " ErrorMessage: " + message.Trim());
                            }//if (reader.HasRows)
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": HolidayGetAllList;" + " ErrorMessage: " + message.Trim());
            }

            totalCount = totCount;
            return list;
        }

        public HolidayBDO HolidayGetByID(int holidayID, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayGetByID; HolidayID= " + holidayID.ToString());
            List<ListItemBDO> invoiceList = null;
            HolidayBDO c = null;
            string sql = Constants.HOLIDAY_GETBYID;
            bool isFirst = true;

            try
            {
                using (SqlConnection cnn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, cnn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@HolidayID", holidayID));
                        cnn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                reader.Read();
                                c = PopulateHolidayBDO(reader);
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


                                }
                            }//if (reader.HasRows)
                            else
                            {
                                message = "There were no Holiday in the database with HolidayID= " +
                                    holidayID.ToString().Trim() + " to read!";
                                _log.Debug(THIS_CLASS + ": HolidayGetByID; HolidayID= " + holidayID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                            }
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": HolidayGetByID; HolidayID= " + holidayID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return c;
        }

        // Update
        public bool HolidayUpdate(HolidayBDO p, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayUpdate; HolidayID= " + p.HolidayID.ToString());
            string sql = Constants.HOLIDAY_UPDATE;
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
                            message = "Holiday= " + p.HolidayDate.ToShortDateString().Trim() + " was updated successfully!";
                            isUpdateSuccessful = true;
                        }
                        else
                        {
                            message = "Holiday= " + p.HolidayDate.ToShortDateString().Trim() + " was **NOT** updated successfully!";
                            _log.Debug(THIS_CLASS + ": HolidayUpdate; HolidayID= " + p.HolidayID.ToString().Trim() + " ErrorMessage: " + message.Trim());
                        }

                        _log.Debug(THIS_CLASS + ": " + message);

                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": HolidayUpdate; HolidayID= " + p.HolidayID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isUpdateSuccessful;
        }

        // Delete
        public bool HolidayDelete(int holidayID, ref string message)
        {
            _log.Info(THIS_CLASS + ": HolidayDelete; HolidayID= " + holidayID.ToString());
            bool isDeleteSuccessful = false;

            try
            {
                //this.Delete(holidayID);
                //this.CommitAllChanges();
                isDeleteSuccessful = true;
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": UpdateHoliday; HolidayID= " + holidayID.ToString().Trim() + " ErrorMessage: " + message.Trim());
            }

            return isDeleteSuccessful;
        }

        #endregion CRUD Operations

        #region Private Routines

        private void PopulateSearchParameters(SqlCommand cmd, ref HolidaySearchFields searchFields)
        {
            if (!(String.IsNullOrEmpty(searchFields.HolidayDescriptionName)))
                cmd.Parameters.Add(new SqlParameter("@HolidayDescriptionName", searchFields.HolidayDescriptionName));

            if (searchFields.HolidayDate != DateTime.MinValue)
                cmd.Parameters.Add(new SqlParameter("@HolidayDate", searchFields.HolidayDate));

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

        private HolidayBDO PopulateHolidayBDO(SqlDataReader reader)
        {
            HolidayBDO cust = new HolidayBDO
            {
                HolidayID = (int)reader["HolidayID"],
                HolidayDate = (DateTime)reader["HolidayDate"],
                HolidayDescriptionID = (int)reader["HolidayDescriptionID"],               
                IsActive = (bool)reader["IsActive"],
                AddedBy = (string)reader["AddedBy"],
                AddedDate = (DateTime)reader["AddedDate"],
                ModifiedBy = (string)reader["ModifiedBy"],
                ModifiedDate = (DateTime)reader["ModifiedDate"],
                Modified = (byte[])reader["Modified"]
            };

            return cust;
        }

        private void PopulateParameters(SqlCommand cmd, HolidayBDO c, bool isInsert)
        {
            if (isInsert == false)
                cmd.Parameters.Add(new SqlParameter("@HolidayID", c.HolidayID));

            cmd.Parameters.Add(new SqlParameter("@HolidayDate", c.HolidayDate));
            cmd.Parameters.Add(new SqlParameter("@HolidayDescriptionID", c.HolidayDescriptionID));
            cmd.Parameters.Add(new SqlParameter("@IsActive", c.IsActive));

            if (isInsert == true)
                cmd.Parameters.Add(new SqlParameter("@AddedBy", c.AddedBy));

            cmd.Parameters.Add(new SqlParameter("@ModifiedBy", c.ModifiedBy));

            if (isInsert == true)
            {
                cmd.Parameters.Add(new SqlParameter("@newHolidayID", c.HolidayID));
                cmd.Parameters["@newHolidayID"].Direction = ParameterDirection.Output;
            }

            SqlParameter parameter = new SqlParameter("@newModified", SqlDbType.Timestamp, 8);
            parameter.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parameter);

            cmd.Prepare();
        }

        #endregion Private Routines
    }
}
