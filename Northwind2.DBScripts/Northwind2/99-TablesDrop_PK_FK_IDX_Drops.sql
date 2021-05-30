/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v5.2.3                     */
/* Target DBMS:           MS SQL Server 2008                              */
/* Project file:          Northwind2.dez                                  */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database drop script                            */
/* Created on:            2016-06-30 10:58                                */
/* Model version:         Version 2016-06-30 1                            */
/* ---------------------------------------------------------------------- */


USE Northwind2
GO

/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Products].[Product] DROP CONSTRAINT [FK_Category_Product]
GO

ALTER TABLE [Products].[Product] DROP CONSTRAINT [FK_Supplier_Product]
GO

ALTER TABLE [Products].[Supplier] DROP CONSTRAINT [FK_ContactTitle_Supplier]
GO

ALTER TABLE [Products].[Supplier] DROP CONSTRAINT [FK_Country_Supplier]
GO

ALTER TABLE [HumanResources].[Employee] DROP CONSTRAINT [FK_Title_Employee]
GO

ALTER TABLE [HumanResources].[Employee] DROP CONSTRAINT [FK_TitleOfCourtesy_Employee]
GO

ALTER TABLE [HumanResources].[Employee] DROP CONSTRAINT [FK_Country_Employee]
GO

ALTER TABLE [HumanResources].[Territory] DROP CONSTRAINT [FK_Region_Territory]
GO

ALTER TABLE [HumanResources].[EmployeeToTerritory] DROP CONSTRAINT [FK_Employee_EmployeeToTerritory]
GO

ALTER TABLE [HumanResources].[EmployeeToTerritory] DROP CONSTRAINT [FK_Territory_EmployeeToTerritory]
GO

ALTER TABLE [Sales].[Invoice] DROP CONSTRAINT [FK_Employee_Invoice]
GO

ALTER TABLE [Sales].[Invoice] DROP CONSTRAINT [FK_Customer_Invoice]
GO

ALTER TABLE [Sales].[Invoice] DROP CONSTRAINT [FK_Shipper_Invoice]
GO

ALTER TABLE [Sales].[Invoice] DROP CONSTRAINT [FK_Country_Invoice]
GO

ALTER TABLE [Customers].[Customer] DROP CONSTRAINT [FK_ContactTitle_Customer]
GO

ALTER TABLE [Customers].[Customer] DROP CONSTRAINT [FK_Country_Customer]
GO

ALTER TABLE [Sales].[InvoiceItem] DROP CONSTRAINT [FK_Invoice_InvoiceItem]
GO

ALTER TABLE [Sales].[InvoiceItem] DROP CONSTRAINT [FK_Product_InvoiceItem]
GO

ALTER TABLE [Administration].[Holiday] DROP CONSTRAINT [FK_HolidayDescription_Holiday]
GO

ALTER TABLE [Security].[ApplicationUserToApplicationRole] DROP CONSTRAINT [FK_ApplicationRole_ApplicationUserToApplicationRole]
GO

ALTER TABLE [Security].[ApplicationUserToApplicationRole] DROP CONSTRAINT [FK_ApplicationUser_ApplicationUserToApplicationRole]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Category"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Products].[Category] DROP CONSTRAINT [DEF_Category_IsActive]
GO

ALTER TABLE [Products].[Category] DROP CONSTRAINT [DEF_Category_AddedBy]
GO

ALTER TABLE [Products].[Category] DROP CONSTRAINT [DEF_Category_AddedDate]
GO

ALTER TABLE [Products].[Category] DROP CONSTRAINT [DEF_Category_ModifiedBy]
GO

ALTER TABLE [Products].[Category] DROP CONSTRAINT [DEF_Category_ModifiedDate]
GO

ALTER TABLE [Products].[Category] DROP CONSTRAINT [PK_Category]
GO

/* Drop table */

DROP TABLE [Products].[Category]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Product"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Products].[Product] DROP CONSTRAINT [DEF_Product_UnitPrice]
GO

ALTER TABLE [Products].[Product] DROP CONSTRAINT [DEF_Product_UnitsInStock]
GO

ALTER TABLE [Products].[Product] DROP CONSTRAINT [DEF_Product_UnitsOnOrder]
GO

ALTER TABLE [Products].[Product] DROP CONSTRAINT [DEF_Product_ReorderLevel]
GO

ALTER TABLE [Products].[Product] DROP CONSTRAINT [DEF_Product_IsActive]
GO

ALTER TABLE [Products].[Product] DROP CONSTRAINT [DEF_Product_AddedBy]
GO

ALTER TABLE [Products].[Product] DROP CONSTRAINT [DEF_Product_AddedDate]
GO

ALTER TABLE [Products].[Product] DROP CONSTRAINT [DEF_Product_ModifiedBy]
GO

ALTER TABLE [Products].[Product] DROP CONSTRAINT [DEF_Product_ModifiedDate]
GO

ALTER TABLE [Products].[Product] DROP CONSTRAINT [PK_Product]
GO

/* Drop table */

DROP TABLE [Products].[Product]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Supplier"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Products].[Supplier] DROP CONSTRAINT [DEF_Supplier_IsActive]
GO

ALTER TABLE [Products].[Supplier] DROP CONSTRAINT [DEF_Supplier_AddedBy]
GO

ALTER TABLE [Products].[Supplier] DROP CONSTRAINT [DEF_Supplier_AddedDate]
GO

ALTER TABLE [Products].[Supplier] DROP CONSTRAINT [DEF_Supplier_ModifiedBy]
GO

ALTER TABLE [Products].[Supplier] DROP CONSTRAINT [DEF_Supplier_ModifiedDate]
GO

ALTER TABLE [Products].[Supplier] DROP CONSTRAINT [PK_Supplier]
GO

/* Drop table */

DROP TABLE [Products].[Supplier]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Employee"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [HumanResources].[Employee] DROP CONSTRAINT [DEF_Employee_IsActive]
GO

ALTER TABLE [HumanResources].[Employee] DROP CONSTRAINT [DEF_Employee_AddedBy]
GO

ALTER TABLE [HumanResources].[Employee] DROP CONSTRAINT [DEF_Employee_AddedDate]
GO

ALTER TABLE [HumanResources].[Employee] DROP CONSTRAINT [DEF_Employee_ModifiedBy]
GO

ALTER TABLE [HumanResources].[Employee] DROP CONSTRAINT [DEF_Employee_ModifiedDate]
GO

ALTER TABLE [HumanResources].[Employee] DROP CONSTRAINT [PK_Employee]
GO

/* Drop table */

DROP TABLE [HumanResources].[Employee]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Country"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Administration].[Country] DROP CONSTRAINT [DEF_Country_IsActive]
GO

ALTER TABLE [Administration].[Country] DROP CONSTRAINT [DEF_Country_AddedBy]
GO

ALTER TABLE [Administration].[Country] DROP CONSTRAINT [DEF_Country_AddedDate]
GO

ALTER TABLE [Administration].[Country] DROP CONSTRAINT [DEF_Country_ModifiedBy]
GO

ALTER TABLE [Administration].[Country] DROP CONSTRAINT [DEF_Country_ModifiedDate]
GO

ALTER TABLE [Administration].[Country] DROP CONSTRAINT [PK_Country]
GO

/* Drop table */

DROP TABLE [Administration].[Country]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Region"                                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [HumanResources].[Region] DROP CONSTRAINT [DEF_Region_IsActive]
GO

ALTER TABLE [HumanResources].[Region] DROP CONSTRAINT [DEF_Region_AddedBy]
GO

ALTER TABLE [HumanResources].[Region] DROP CONSTRAINT [DEF_Region_AddedDate]
GO

ALTER TABLE [HumanResources].[Region] DROP CONSTRAINT [DEF_Region_ModifiedBy]
GO

ALTER TABLE [HumanResources].[Region] DROP CONSTRAINT [DEF_Region_ModifiedDate]
GO

ALTER TABLE [HumanResources].[Region] DROP CONSTRAINT [PK_Region]
GO

/* Drop table */

DROP TABLE [HumanResources].[Region]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Territory"                                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [HumanResources].[Territory] DROP CONSTRAINT [DEF_Territory_IsActive]
GO

ALTER TABLE [HumanResources].[Territory] DROP CONSTRAINT [DEF_Territory_AddedBy]
GO

ALTER TABLE [HumanResources].[Territory] DROP CONSTRAINT [DEF_Territory_AddedDate]
GO

ALTER TABLE [HumanResources].[Territory] DROP CONSTRAINT [DEF_Territory_ModifiedBy]
GO

ALTER TABLE [HumanResources].[Territory] DROP CONSTRAINT [DEF_Territory_ModifiedDate]
GO

ALTER TABLE [HumanResources].[Territory] DROP CONSTRAINT [PK_Territory]
GO

/* Drop table */

DROP TABLE [HumanResources].[Territory]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "EmployeeToTerritory"                                       */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [HumanResources].[EmployeeToTerritory] DROP CONSTRAINT [DEF_EmployeeToTerritory_IsActive]
GO

ALTER TABLE [HumanResources].[EmployeeToTerritory] DROP CONSTRAINT [DEF_EmployeeToTerritory_AddedBy]
GO

ALTER TABLE [HumanResources].[EmployeeToTerritory] DROP CONSTRAINT [DEF_EmployeeToTerritory_AddedDate]
GO

ALTER TABLE [HumanResources].[EmployeeToTerritory] DROP CONSTRAINT [DEF_EmployeeToTerritory_ModifiedBy]
GO

ALTER TABLE [HumanResources].[EmployeeToTerritory] DROP CONSTRAINT [DEF_EmployeeToTerritory_ModifiedDate]
GO

ALTER TABLE [HumanResources].[EmployeeToTerritory] DROP CONSTRAINT [PK_EmployeeToTerritory]
GO

/* Drop table */

DROP TABLE [HumanResources].[EmployeeToTerritory]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Invoice"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Sales].[Invoice] DROP CONSTRAINT [DEF_Invoice_AddedBy]
GO

ALTER TABLE [Sales].[Invoice] DROP CONSTRAINT [DEF_Invoice_AddedDate]
GO

ALTER TABLE [Sales].[Invoice] DROP CONSTRAINT [DEF_Invoice_ModifiedBy]
GO

ALTER TABLE [Sales].[Invoice] DROP CONSTRAINT [DEF_Invoice_ModifiedDate]
GO

ALTER TABLE [Sales].[Invoice] DROP CONSTRAINT [PK_Invoice]
GO

/* Drop table */

DROP TABLE [Sales].[Invoice]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Customer"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Customers].[Customer] DROP CONSTRAINT [DEF_Customer_IsActive]
GO

ALTER TABLE [Customers].[Customer] DROP CONSTRAINT [DEF_Customer_AddedBy]
GO

ALTER TABLE [Customers].[Customer] DROP CONSTRAINT [DEF_Customer_AddedDate]
GO

ALTER TABLE [Customers].[Customer] DROP CONSTRAINT [DEF_Customer_ModifiedBy]
GO

ALTER TABLE [Customers].[Customer] DROP CONSTRAINT [DEF_Customer_ModifiedDate]
GO

ALTER TABLE [Customers].[Customer] DROP CONSTRAINT [PK_Customer]
GO

/* Drop table */

DROP TABLE [Customers].[Customer]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "InvoiceItem"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Sales].[InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_UnitPrice]
GO

ALTER TABLE [Sales].[InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_Quantity]
GO

ALTER TABLE [Sales].[InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_Discount]
GO

ALTER TABLE [Sales].[InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_AddedBy]
GO

ALTER TABLE [Sales].[InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_AddedDate]
GO

ALTER TABLE [Sales].[InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_ModifiedBy]
GO

ALTER TABLE [Sales].[InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_ModifiedDate]
GO

ALTER TABLE [Sales].[InvoiceItem] DROP CONSTRAINT [PK_InvoiceItem]
GO

/* Drop table */

DROP TABLE [Sales].[InvoiceItem]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Shipper"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Sales].[Shipper] DROP CONSTRAINT [DEF_Shipper_IsActive]
GO

ALTER TABLE [Sales].[Shipper] DROP CONSTRAINT [DEF_Shipper_AddedBy]
GO

ALTER TABLE [Sales].[Shipper] DROP CONSTRAINT [DEF_Shipper_AddedDate]
GO

ALTER TABLE [Sales].[Shipper] DROP CONSTRAINT [DEF_Shipper_ModifiedBy]
GO

ALTER TABLE [Sales].[Shipper] DROP CONSTRAINT [DEF_Shipper_ModifiedDate]
GO

ALTER TABLE [Sales].[Shipper] DROP CONSTRAINT [PK_Shipper]
GO

/* Drop table */

DROP TABLE [Sales].[Shipper]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "ContactTitle"                                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Administration].[ContactTitle] DROP CONSTRAINT [DEF_ContactTitle_IsActive]
GO

ALTER TABLE [Administration].[ContactTitle] DROP CONSTRAINT [DEF_ContactTitle_AddedBy]
GO

ALTER TABLE [Administration].[ContactTitle] DROP CONSTRAINT [DEF_ContactTitle_AddedDate]
GO

ALTER TABLE [Administration].[ContactTitle] DROP CONSTRAINT [DEF_ContactTitle_ModifiedBy]
GO

ALTER TABLE [Administration].[ContactTitle] DROP CONSTRAINT [DEF_ContactTitle_ModifiedDate]
GO

ALTER TABLE [Administration].[ContactTitle] DROP CONSTRAINT [PK_ContactTitle]
GO

/* Drop table */

DROP TABLE [Administration].[ContactTitle]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Title"                                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [HumanResources].[Title] DROP CONSTRAINT [DEF_Title_IsActive]
GO

ALTER TABLE [HumanResources].[Title] DROP CONSTRAINT [DEF_Title_AddedBy]
GO

ALTER TABLE [HumanResources].[Title] DROP CONSTRAINT [DEF_Title_AddedDate]
GO

ALTER TABLE [HumanResources].[Title] DROP CONSTRAINT [DEF_Title_ModifiedBy]
GO

ALTER TABLE [HumanResources].[Title] DROP CONSTRAINT [DEF_Title_ModifiedDate]
GO

ALTER TABLE [HumanResources].[Title] DROP CONSTRAINT [PK_Title]
GO

/* Drop table */

DROP TABLE [HumanResources].[Title]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "TitleOfCourtesy"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [HumanResources].[TitleOfCourtesy] DROP CONSTRAINT [DEF_TitleOfCourtesy_IsActive]
GO

ALTER TABLE [HumanResources].[TitleOfCourtesy] DROP CONSTRAINT [DEF_TitleOfCourtesy_AddedBy]
GO

ALTER TABLE [HumanResources].[TitleOfCourtesy] DROP CONSTRAINT [DEF_TitleOfCourtesy_AddedDate]
GO

ALTER TABLE [HumanResources].[TitleOfCourtesy] DROP CONSTRAINT [DEF_TitleOfCourtesy_ModifiedBy]
GO

ALTER TABLE [HumanResources].[TitleOfCourtesy] DROP CONSTRAINT [DEF_TitleOfCourtesy_ModifiedDate]
GO

ALTER TABLE [HumanResources].[TitleOfCourtesy] DROP CONSTRAINT [PK_TitleOfCourtesy]
GO

/* Drop table */

DROP TABLE [HumanResources].[TitleOfCourtesy]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "HolidayDescription"                                        */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Administration].[HolidayDescription] DROP CONSTRAINT [DEF_HolidayDescription_IsActive]
GO

ALTER TABLE [Administration].[HolidayDescription] DROP CONSTRAINT [DEF_HolidayDescription_AddedBy]
GO

ALTER TABLE [Administration].[HolidayDescription] DROP CONSTRAINT [DEF_HolidayDescription_AddedDate]
GO

ALTER TABLE [Administration].[HolidayDescription] DROP CONSTRAINT [DEF_HolidayDescription_ModifiedBy]
GO

ALTER TABLE [Administration].[HolidayDescription] DROP CONSTRAINT [DEF_HolidayDescription_ModifiedDate]
GO

ALTER TABLE [Administration].[HolidayDescription] DROP CONSTRAINT [PK_HolidayDescription]
GO

/* Drop table */

DROP TABLE [Administration].[HolidayDescription]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Holiday"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Administration].[Holiday] DROP CONSTRAINT [DEF_Holiday_IsActive]
GO

ALTER TABLE [Administration].[Holiday] DROP CONSTRAINT [DEF_Holiday_AddedBy]
GO

ALTER TABLE [Administration].[Holiday] DROP CONSTRAINT [DEF_Holiday_AddedDate]
GO

ALTER TABLE [Administration].[Holiday] DROP CONSTRAINT [DEF_Holiday_ModifiedBy]
GO

ALTER TABLE [Administration].[Holiday] DROP CONSTRAINT [DEF_Holiday_ModifiedDate]
GO

ALTER TABLE [Administration].[Holiday] DROP CONSTRAINT [PK_Holiday]
GO

/* Drop table */

DROP TABLE [Administration].[Holiday]
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
/* Drop table "BuildVersion"                                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[BuildVersion] DROP CONSTRAINT [DEF_BuildVersion_VersionDate]
GO

ALTER TABLE [dbo].[BuildVersion] DROP CONSTRAINT [DEF_BuildVersion_ModifiedDate]
GO

ALTER TABLE [dbo].[BuildVersion] DROP CONSTRAINT [PK_BuildVersion]
GO

/* Drop table */

DROP TABLE [dbo].[BuildVersion]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "ApplicationRole"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Security].[ApplicationRole] DROP CONSTRAINT [DEF_ApplicationRole_IsActive]
GO

ALTER TABLE [Security].[ApplicationRole] DROP CONSTRAINT [DEF_ApplicationRole_AddedBy]
GO

ALTER TABLE [Security].[ApplicationRole] DROP CONSTRAINT [DEF_ApplicationRole_AddedDate]
GO

ALTER TABLE [Security].[ApplicationRole] DROP CONSTRAINT [DEF_ApplicationRole_ModifiedBy]
GO

ALTER TABLE [Security].[ApplicationRole] DROP CONSTRAINT [DEF_ApplicationRole_ModifiedDate]
GO

ALTER TABLE [Security].[ApplicationRole] DROP CONSTRAINT [PK_ApplicationRole]
GO

/* Drop table */

DROP TABLE [Security].[ApplicationRole]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "ApplicationUser"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Security].[ApplicationUser] DROP CONSTRAINT [DEF_ApplicationUser_IsActive]
GO

ALTER TABLE [Security].[ApplicationUser] DROP CONSTRAINT [DEF_ApplicationUser_AddedBy]
GO

ALTER TABLE [Security].[ApplicationUser] DROP CONSTRAINT [DEF_ApplicationUser_AddedDate]
GO

ALTER TABLE [Security].[ApplicationUser] DROP CONSTRAINT [DEF_ApplicationUser_ModifiedBy]
GO

ALTER TABLE [Security].[ApplicationUser] DROP CONSTRAINT [DEF_ApplicationUser_ModifiedDate]
GO

ALTER TABLE [Security].[ApplicationUser] DROP CONSTRAINT [PK_ApplicationUser]
GO

/* Drop table */

DROP TABLE [Security].[ApplicationUser]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "ApplicationUserToApplicationRole"                          */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Security].[ApplicationUserToApplicationRole] DROP CONSTRAINT [DEF_ApplicationUserToApplicationRole_IsActive]
GO

ALTER TABLE [Security].[ApplicationUserToApplicationRole] DROP CONSTRAINT [DEF_ApplicationUserToApplicationRole_AddedBy]
GO

ALTER TABLE [Security].[ApplicationUserToApplicationRole] DROP CONSTRAINT [DEF_ApplicationUserToApplicationRole_AddedDate]
GO

ALTER TABLE [Security].[ApplicationUserToApplicationRole] DROP CONSTRAINT [DEF_ApplicationUserToApplicationRole_ModifiedBy]
GO

ALTER TABLE [Security].[ApplicationUserToApplicationRole] DROP CONSTRAINT [DEF_ApplicationUserToApplicationRole_ModifiedDate]
GO

ALTER TABLE [Security].[ApplicationUserToApplicationRole] DROP CONSTRAINT [PK_ApplicationUserToApplicationRole]
GO

/* Drop table */

DROP TABLE [Security].[ApplicationUserToApplicationRole]
GO
