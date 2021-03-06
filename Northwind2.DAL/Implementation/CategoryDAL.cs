/*****************************************************************************
 *        Class Name: CategoryDAL
 *  Class Decription: Contains data access functionality for Category
 *     Inherits From: Northwind2DAL
 *              Date: Tuesday, October 31, 2017
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
    public sealed class CategoryDAL : Northwind2DAL, ICategoryDAL
    {
        #region Private Member Variables

        //Private Member Variables
        private const string THIS_CLASS = "CategoryDAL";

        #endregion Private Member Variables

        #region Public Constructor

        // Public Constructor
        public CategoryDAL()
            : base()
        {
            //Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }

        #endregion Public Constructor

        #region CRUD Operations

        public IList<ListItemBDO> CategoryGetAllList(out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": CategoryGetAllList");
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
                                        ID = (int)reader["CategoryID"],
                                        Name = (string)reader["CategoryName"]
                                    });
                                }
                            }
                            else
                            {
                                message = "There were no Categorys in the database to read!";
                                _log.Error(THIS_CLASS + ": CategoryGetAllList;" + " ErrorMessage: " + message.Trim());
                            }//if (reader.HasRows)
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                _log.Error(THIS_CLASS + ": CategoryGetAllList;" + " ErrorMessage: " + message.Trim());
            }

            totalCount = totCount;
            return list;
        }

        #endregion CRUD Operations
    }
}
