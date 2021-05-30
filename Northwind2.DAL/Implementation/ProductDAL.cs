/*****************************************************************************
 *        Class Name: ProductDAL
 *  Class Decription: Contains data access functionality for Product
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
    public sealed class ProductDAL :  Northwind2DAL, IProductDAL
    {
        #region Private Member Variables

        //Private Member Variables
        private const string THIS_CLASS = "ProductDAL";

        #endregion Private Member Variables

        #region Public Constructor

        // Public Constructor
        public ProductDAL()
            : base()
        {
            //Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }

        #endregion Public Constructor

        #region CRUD Operations

        // Create
        //public int ProductAdd(ProductBDO product, ref string message)
        //{
        //    _log.Info(THIS_CLASS + ": ProductAdd; ProductName= " + product.ProductName.Trim());
        //    string sql = Constants.PRODUCTADD;
        //    int newProductID = 0;

        //    try
        //    {
        //        using (SqlConnection cnn = new SqlConnection(_connectionString))
        //        {
        //            using (SqlCommand cmd = new SqlCommand(sql, cnn))
        //            {
        //                cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //                PopulateParameters(cmd, product, true);
        //                cnn.Open();

        //                if (cmd.ExecuteNonQuery() == 1)
        //                {
        //                    message = "Product= " + product.ProductName.Trim() + " was inserted successfully!";
        //                    newProductID = Convert.ToInt32(cmd.Parameters["@newProductID"].Value.ToString());
        //                }
        //                else
        //                {
        //                    message = "Product= " + product.ProductName.Trim() + " was **NOT** inserted successfully!";
        //                    _log.Debug(THIS_CLASS + ": ProductAdd; ProductName= " + product.ProductName.Trim() + " ErrorMessage: " + message.Trim());
        //                }

        //            } //using (SqlCommand cmd = new SqlCommand(sql, cnn))
        //        } //using (SqlConnection cnn = new SqlConnection(_connectionString))
        //    }
        //    catch (Exception ex)
        //    {
        //        message = ExceptionHelpers.GetAllMessages(ex);
        //        _log.Error(THIS_CLASS + ": ProductAdd; ProductName= " + product.ProductName.Trim() + " ErrorMessage: " + message.Trim());
        //    }

        //    return newProductID;
        //}

        // Read
        public IList<ProductBDO> ProductGetAll(ProductSearchFields searchFields, PaginationRequest paging, out int totalCount, ref string message)
        {
            _log.Info(THIS_CLASS + ": ProductGetAll");
            string sql = Constants.PRODUCT_GETALL;
            IList<ProductBDO> list = null;
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
                                        list = new List<ProductBDO>();
                                        isFirst = false;
                                    }

                                    list.Add(PopulateProductBDO(reader));
                                    totCount++;
                                }//while (reader.Read())
                            }//if (reader.HasRows)
                            else
                            {
                                message = "No Products in the database met the search criteria!";
                                _log.Debug(THIS_CLASS + ": ProductGetAll" + " ErrorMessage: " + message.Trim());
                            }
                        }//using (SqlDataReader reader = cmd.ExecuteReader())
                    }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
                }//using (SqlConnection cnn = new SqlConnection(_connectionString))
            }
            catch (Exception ex)
            {
                message = ExceptionHelpers.GetAllMessages(ex);
                totalCount = 0;
                _log.Error(THIS_CLASS + ": ProductGetAll" + " ErrorMessage: " + message.Trim());
            }

            //Had to do this asignment as after I put the try {} catch(() block in, code was looking
            //for totalCount to be assigned before exiting routine
            totalCount = totCount;
            return list;
        }

        //public IList<ListItemBDO> ProductGetAllList(out int totalCount, ref string message)
        //{
        //    _log.Info(THIS_CLASS + ": ProductGetAllList");
        //    List<ListItemBDO> list = null;
        //    string sql = Constants.PRODUCTGETALLLIST;
        //    bool isFirst = true;
        //    int totCount = 0;

        //    try
        //    {
        //        using (SqlConnection cnn = new SqlConnection(_connectionString))
        //        {
        //            using (SqlCommand cmd = new SqlCommand(sql, cnn))
        //            {
        //                cnn.Open();

        //                using (SqlDataReader reader = cmd.ExecuteReader())
        //                {
        //                    if (reader.HasRows)
        //                    {
        //                        while (reader.Read())
        //                        {
        //                            totCount++;
        //                            if (isFirst == true)
        //                            {
        //                                list = new List<ListItemBDO>();
        //                                isFirst = false;
        //                            }
        //                            list.Add(new ListItemBDO
        //                            {
        //                                ID = (int)reader["ProductID"],
        //                                Name = (string)reader["ProductName"]
        //                            });
        //                        }
        //                    }
        //                    else
        //                    {
        //                        message = "There were no Products in the database to read!";
        //                        _log.Error(THIS_CLASS + ": ProductGetAllList;" + " ErrorMessage: " + message.Trim());
        //                    }//if (reader.HasRows)
        //                }//using (SqlDataReader reader = cmd.ExecuteReader())
        //            }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
        //        }//using (SqlConnection cnn = new SqlConnection(_connectionString))
        //    }
        //    catch (Exception ex)
        //    {
        //        message = ExceptionHelpers.GetAllMessages(ex);
        //        _log.Error(THIS_CLASS + ": ProductGetAllList;" + " ErrorMessage: " + message.Trim());
        //    }

        //    totalCount = totCount;
        //    return list;
        //}

        //public ProductBDO ProductGetByID(int productID, ref string message)
        //{
        //    _log.Info(THIS_CLASS + ": ProductGetByID; ProductID= " + productID.ToString());
        //    List<ListItemBDO> invoiceList = null;
        //    ProductBDO c = null;
        //    string sql = Constants.PRODUCTGETBYID;
        //    bool isFirst = true;

        //    try
        //    {
        //        using (SqlConnection cnn = new SqlConnection(_connectionString))
        //        {
        //            using (SqlCommand cmd = new SqlCommand(sql, cnn))
        //            {
        //                cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //                cmd.Parameters.Add(new SqlParameter("@ProductID", productID));
        //                cnn.Open();

        //                using (SqlDataReader reader = cmd.ExecuteReader())
        //                {
        //                    if (reader.HasRows)
        //                    {
        //                        reader.Read();
        //                        c = PopulateProductBDO(reader);
        //                        reader.NextResult();
        //                        if (reader.HasRows)
        //                        {
        //                            while (reader.Read())
        //                            {
        //                                if (isFirst == true)
        //                                {
        //                                    invoiceList = new List<ListItemBDO>();
        //                                    isFirst = false;
        //                                }
        //                                invoiceList.Add(new ListItemBDO
        //                                {
        //                                    ID = (int)reader["ID"],
        //                                    Name = (string)reader["Name"],
        //                                    Date = (DateTime)reader["Date"],
        //                                    Amount = (decimal)reader["Amount"]
        //                                });
        //                            }

        //                            c.Invoices = invoiceList;
        //                        }
        //                    }//if (reader.HasRows)
        //                    else
        //                    {
        //                        message = "There were no Product in the database with ProductID= " +
        //                            productID.ToString().Trim() + " to read!";
        //                        _log.Debug(THIS_CLASS + ": ProductGetByID; ProductID= " + productID.ToString().Trim() + " ErrorMessage: " + message.Trim());
        //                    }
        //                }//using (SqlDataReader reader = cmd.ExecuteReader())
        //            }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
        //        }//using (SqlConnection cnn = new SqlConnection(_connectionString))
        //    }
        //    catch (Exception ex)
        //    {
        //        message = ExceptionHelpers.GetAllMessages(ex);
        //        _log.Error(THIS_CLASS + ": ProductGetByID; ProductID= " + productID.ToString().Trim() + " ErrorMessage: " + message.Trim());
        //    }

        //    return c;
        //}

        //// Update
        //public bool ProductUpdate(ProductBDO p, ref string message)
        //{
        //    _log.Info(THIS_CLASS + ": ProductUpdate; ProductID= " + p.ProductID.ToString());
        //    string sql = Constants.PRODUCTUPDATE;
        //    bool isUpdateSuccessful = false;

        //    try
        //    {
        //        using (SqlConnection cnn = new SqlConnection(_connectionString))
        //        {
        //            using (SqlCommand cmd = new SqlCommand(sql, cnn))
        //            {
        //                cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //                PopulateParameters(cmd, p, false);
        //                cnn.Open();
        //                cmd.ExecuteNonQuery();

        //                if (cmd.ExecuteNonQuery() == 1)
        //                {
        //                    message = "Product= " + p.ProductName.Trim() + " was updated successfully!";
        //                    isUpdateSuccessful = true;
        //                }
        //                else
        //                {
        //                    message = "Product= " + p.ProductName.Trim() + " was **NOT** updated successfully!";
        //                    _log.Debug(THIS_CLASS + ": ProductUpdate; ProductID= " + p.ProductID.ToString().Trim() + " ErrorMessage: " + message.Trim());
        //                }

        //                _log.Debug(THIS_CLASS + ": " + message);

        //            }//using (SqlCommand cmd = new SqlCommand(sql, cnn))
        //        }//using (SqlConnection cnn = new SqlConnection(_connectionString))
        //    }
        //    catch (Exception ex)
        //    {
        //        message = ExceptionHelpers.GetAllMessages(ex);
        //        _log.Error(THIS_CLASS + ": ProductUpdate; ProductID= " + p.ProductID.ToString().Trim() + " ErrorMessage: " + message.Trim());
        //    }

        //    return isUpdateSuccessful;
        //}

        //// Delete
        //public bool ProductDelete(int productID, ref string message)
        //{
        //    _log.Info(THIS_CLASS + ": ProductDelete; ProductID= " + productID.ToString());
        //    bool isDeleteSuccessful = false;

        //    try
        //    {
        //        //this.Delete(productID);
        //        //this.CommitAllChanges();
        //        isDeleteSuccessful = true;
        //    }
        //    catch (Exception ex)
        //    {
        //        message = ExceptionHelpers.GetAllMessages(ex);
        //        _log.Error(THIS_CLASS + ": UpdateProduct; ProductID= " + productID.ToString().Trim() + " ErrorMessage: " + message.Trim());
        //    }

        //    return isDeleteSuccessful;
        //}

        #endregion CRUD Operations

        #region Private Routines

        private void PopulateSearchParameters(SqlCommand cmd, ref ProductSearchFields searchFields)
        {
            if (!(String.IsNullOrEmpty(searchFields.ProductName)))
                cmd.Parameters.Add(new SqlParameter("@ProductName", searchFields.ProductName));

            if (!(String.IsNullOrEmpty(searchFields.ProductName)))
                cmd.Parameters.Add(new SqlParameter("@ProductName", searchFields.ProductName));


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

        private ProductBDO PopulateProductBDO(SqlDataReader reader)
        {
            ProductBDO p = new ProductBDO
            {
                ProductID = (int)reader["ProductID"],
                ProductName = (string)reader["ProductName"],
                SupplierID = (int)reader["SupplierID"],
                SupplierName = (string)reader["SupplierName"],
                CategoryID = (int)reader["CategoryID"],
                CategoryName = (string)reader["CategoryName"],
                QuantityPerUnit = (string)reader["QuantityPerUnit"],
                UnitPrice = (decimal)reader["UnitPrice"],
                UnitsInStock = (int)reader["UnitsInStock"],
                UnitsOnOrder = (int)reader["UnitsOnOrder"],
                ReorderLevel = (int)reader["ReorderLevel"],
                IsActive = (bool)reader["IsActive"],
                AddedBy = (string)reader["AddedBy"],
                AddedDate = (DateTime)reader["AddedDate"],
                ModifiedBy = (string)reader["ModifiedBy"],
                ModifiedDate = (DateTime)reader["ModifiedDate"],
                Modified = (byte[])reader["Modified"]
            };

            return p;
        }

        private void PopulateParameters(SqlCommand cmd, ProductBDO e, bool isInsert)
        {
            if (isInsert == false)
                cmd.Parameters.Add(new SqlParameter("@ProductID", e.ProductID));

            cmd.Parameters.Add(new SqlParameter("@ProductName", e.ProductName));
            cmd.Parameters.Add(new SqlParameter("@IsActive", e.IsActive));

            if (isInsert == true)
                cmd.Parameters.Add(new SqlParameter("@AddedBy", e.AddedBy));

            cmd.Parameters.Add(new SqlParameter("@ModifiedBy", e.ModifiedBy));

            if (isInsert == true)
            {
                cmd.Parameters.Add(new SqlParameter("@newProductID", e.ProductID));
                cmd.Parameters["@newProductID"].Direction = ParameterDirection.Output;
            }

            SqlParameter parameter = new SqlParameter("@newModified", SqlDbType.Timestamp, 8);
            parameter.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(parameter);

            cmd.Prepare();
        }

        #endregion Private Routines
    }
}
