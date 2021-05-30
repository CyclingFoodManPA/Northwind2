/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v5.2.3                     */
/* Target DBMS:           MS SQL Server 2008                              */
/* Project file:          Northwind2DW.dez                                */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database drop script                            */
/* Created on:            2016-06-24 10:25                                */
/* Model version:         Version 2016-06-24                              */
/* ---------------------------------------------------------------------- */


USE Northwind2DW
GO

/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [FK_DimEmployee_FactInvoice]
GO

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [FK_DimCustomer_FactInvoice]
GO

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [FK_DimProduct_FactInvoice]
GO

ALTER TABLE [dbo].[SystemUserToSystemRole] DROP CONSTRAINT [FK_SystemUser_SystemUserToSystemRole]
GO

ALTER TABLE [dbo].[SystemUserToSystemRole] DROP CONSTRAINT [FK_SystemRole_SystemUserToSystemRole]
GO

ALTER TABLE [DimEmployeeToTerritoryRegion] DROP CONSTRAINT [FK_DimEmployee_DimEmployeeToTerritoryRegion]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "DimProduct"                                                */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [DEF_DimProduct_ProductUnitPrice]
GO

ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [DEF_DimProduct_ProductUnitsInStock]
GO

ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [DEF_DimProduct_ProductUnitsOnOrder]
GO

ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [DEF_DimProduct_ProductReorderLevel]
GO

ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [DEF_DimProduct_ProductIsDiscontinued]
GO

ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [DEF_DimProduct_AddedBy]
GO

ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [DEF_DimProduct_AddedDate]
GO

ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [DEF_DimProduct_ModifiedBy]
GO

ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [DEF_DimProduct_ModifiedDate]
GO

ALTER TABLE [dbo].[DimProduct] DROP CONSTRAINT [PK_DimProduct]
GO

/* Drop table */

DROP TABLE [dbo].[DimProduct]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "DimEmployee"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[DimEmployee] DROP CONSTRAINT [DEF_DimEmployee_AddedBy]
GO

ALTER TABLE [dbo].[DimEmployee] DROP CONSTRAINT [DEF_DimEmployee_AddedDate]
GO

ALTER TABLE [dbo].[DimEmployee] DROP CONSTRAINT [DEF_DimEmployee_ModifiedBy]
GO

ALTER TABLE [dbo].[DimEmployee] DROP CONSTRAINT [DEF_DimEmployee_ModifiedDate]
GO

ALTER TABLE [dbo].[DimEmployee] DROP CONSTRAINT [PK_DimEmployee]
GO

/* Drop table */

DROP TABLE [dbo].[DimEmployee]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "FactInvoice"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [DEF_FactInvoice_InvoiceItemUnitPrice]
GO

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [DEF_FactInvoice_InvoiceItemQuantity]
GO

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [DEF_FactInvoice_InvoiceItemDiscount]
GO

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [DEF_FactInvoice_AddedBy]
GO

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [DEF_FactInvoice_AddedDate]
GO

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [DEF_FactInvoice_ModifiedBy]
GO

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [DEF_FactInvoice_ModifiedDate]
GO

ALTER TABLE [dbo].[FactInvoice] DROP CONSTRAINT [PK_FactInvoice]
GO

/* Drop table */

DROP TABLE [dbo].[FactInvoice]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "DimCustomer"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[DimCustomer] DROP CONSTRAINT [DEF_DimCustomer_AddedBy]
GO

ALTER TABLE [dbo].[DimCustomer] DROP CONSTRAINT [DEF_DimCustomer_AddedDate]
GO

ALTER TABLE [dbo].[DimCustomer] DROP CONSTRAINT [DEF_DimCustomer_ModifiedBy]
GO

ALTER TABLE [dbo].[DimCustomer] DROP CONSTRAINT [DEF_DimCustomer_ModifiedDate]
GO

ALTER TABLE [dbo].[DimCustomer] DROP CONSTRAINT [PK_DimCustomer]
GO

/* Drop table */

DROP TABLE [dbo].[DimCustomer]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "SystemRole"                                                */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[SystemRole] DROP CONSTRAINT [DEF_SystemRole_IsActive]
GO

ALTER TABLE [dbo].[SystemRole] DROP CONSTRAINT [DEF_SystemRole_AddedBy]
GO

ALTER TABLE [dbo].[SystemRole] DROP CONSTRAINT [DEF_SystemRole_AddedDate]
GO

ALTER TABLE [dbo].[SystemRole] DROP CONSTRAINT [DEF_SystemRole_ModifiedBy]
GO

ALTER TABLE [dbo].[SystemRole] DROP CONSTRAINT [DEF_SystemRole_ModifiedDate]
GO

ALTER TABLE [dbo].[SystemRole] DROP CONSTRAINT [PK_SystemRole]
GO

/* Drop table */

DROP TABLE [dbo].[SystemRole]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "SystemUser"                                                */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[SystemUser] DROP CONSTRAINT [DEF_SystemUser_IsActive]
GO

ALTER TABLE [dbo].[SystemUser] DROP CONSTRAINT [DEF_SystemUser_AddedBy]
GO

ALTER TABLE [dbo].[SystemUser] DROP CONSTRAINT [DEF_SystemUser_AddedDate]
GO

ALTER TABLE [dbo].[SystemUser] DROP CONSTRAINT [DEF_SystemUser_ModifiedBy]
GO

ALTER TABLE [dbo].[SystemUser] DROP CONSTRAINT [DEF_SystemUser_ModifiedDate]
GO

ALTER TABLE [dbo].[SystemUser] DROP CONSTRAINT [PK_SystemUser]
GO

/* Drop table */

DROP TABLE [dbo].[SystemUser]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "SystemUserToSystemRole"                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[SystemUserToSystemRole] DROP CONSTRAINT [DEF_SystemUserToSystemRole_AddedBy]
GO

ALTER TABLE [dbo].[SystemUserToSystemRole] DROP CONSTRAINT [DEF_SystemUserToSystemRole_AddedDate]
GO

ALTER TABLE [dbo].[SystemUserToSystemRole] DROP CONSTRAINT [DEF_SystemUserToSystemRole_ModifiedBy]
GO

ALTER TABLE [dbo].[SystemUserToSystemRole] DROP CONSTRAINT [DEF_SystemUserToSystemRole_ModifiedDate]
GO

ALTER TABLE [dbo].[SystemUserToSystemRole] DROP CONSTRAINT [PK_SystemUserToSystemRole]
GO

/* Drop table */

DROP TABLE [dbo].[SystemUserToSystemRole]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "ErrorLog"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[ErrorLog] DROP CONSTRAINT [DEF_ErrorLog_ErrorTime]
GO

ALTER TABLE [dbo].[ErrorLog] DROP CONSTRAINT [PK_ErrorLog]
GO

/* Drop table */

DROP TABLE [dbo].[ErrorLog]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "DimDate"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[DimDate] DROP CONSTRAINT [PK_DimDate]
GO

/* Drop table */

DROP TABLE [dbo].[DimDate]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "DimEmployeeToTerritoryRegion"                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [DimEmployeeToTerritoryRegion] DROP CONSTRAINT [DEF_DimEmployeeToTerritoryRegion_AddedBy]
GO

ALTER TABLE [DimEmployeeToTerritoryRegion] DROP CONSTRAINT [DEF_DimEmployeeToTerritoryRegion_AddedDate]
GO

ALTER TABLE [DimEmployeeToTerritoryRegion] DROP CONSTRAINT [DEF_DimEmployeeToTerritoryRegion_ModifiedBy]
GO

ALTER TABLE [DimEmployeeToTerritoryRegion] DROP CONSTRAINT [DEF_DimEmployeeToTerritoryRegion_ModifiedDate]
GO

ALTER TABLE [DimEmployeeToTerritoryRegion] DROP CONSTRAINT [PK_DimEmployeeToTerritoryRegion]
GO

/* Drop table */

DROP TABLE [DimEmployeeToTerritoryRegion]
GO
