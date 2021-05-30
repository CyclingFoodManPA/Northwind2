/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v5.2.3                     */
/* Target DBMS:           MS SQL Server 2008                              */
/* Project file:          Northwind2.dez                                  */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database creation script                        */
/* Created on:            2016-06-30 10:58                                */
/* Model version:         Version 2016-06-30 1                            */
/* ---------------------------------------------------------------------- */


USE Northwind2
GO

/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Category"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Products].[Category] (
    [CategoryID] INTEGER IDENTITY(1,1) NOT NULL,
    [CategoryName] VARCHAR(20) NOT NULL,
    [CategoryDescription] VARCHAR(100),
    [Picture] IMAGE,
    [PicturePath] VARCHAR(255),
    [IsActive] BIT CONSTRAINT [DEF_Category_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Category_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Category_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Category_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Category_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY ([CategoryID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Category_1] ON [Products].[Category] ([CategoryName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Product"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Products].[Product] (
    [ProductID] INTEGER IDENTITY(1,1) NOT NULL,
    [ProductName] VARCHAR(40) NOT NULL,
    [SupplierID] INTEGER NOT NULL,
    [CategoryID] INTEGER NOT NULL,
    [QuantityPerUnit] VARCHAR(20),
    [UnitPrice] MONEY CONSTRAINT [DEF_Product_UnitPrice] DEFAULT 0 NOT NULL,
    [UnitsInStock] INTEGER CONSTRAINT [DEF_Product_UnitsInStock] DEFAULT 0 NOT NULL,
    [UnitsOnOrder] INTEGER CONSTRAINT [DEF_Product_UnitsOnOrder] DEFAULT 0 NOT NULL,
    [ReorderLevel] INTEGER CONSTRAINT [DEF_Product_ReorderLevel] DEFAULT 0 NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_Product_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Product_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Product_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Product_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Product_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY ([ProductID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Product_1] ON [Products].[Product] ([ProductName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Product_2] ON [Products].[Product] ([CategoryID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Product_3] ON [Products].[Product] ([SupplierID] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Supplier"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Products].[Supplier] (
    [SupplierID] INTEGER IDENTITY(1,1) NOT NULL,
    [SupplierName] VARCHAR(40) NOT NULL,
    [ContactName] VARCHAR(40) NOT NULL,
    [ContactTitleID] INTEGER NOT NULL,
    [Address1] VARCHAR(60) NOT NULL,
    [Address2] VARCHAR(60),
    [City] VARCHAR(40) NOT NULL,
    [Region] VARCHAR(15),
    [PostalCode] VARCHAR(10),
    [CountryID] INTEGER NOT NULL,
    [Phone] VARCHAR(40) NOT NULL,
    [Fax] VARCHAR(40),
    [HomePage] VARCHAR(255),
    [IsActive] BIT CONSTRAINT [DEF_Supplier_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Supplier_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Supplier_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Supplier_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Supplier_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Supplier] PRIMARY KEY ([SupplierID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Supplier_1] ON [Products].[Supplier] ([SupplierName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Supplier_2] ON [Products].[Supplier] ([ContactTitleID] ASC)
GO

CREATE  INDEX [IDX_Supplier_3] ON [Products].[Supplier] ([CountryID])
GO

/* ---------------------------------------------------------------------- */
/* Add table "Employee"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [HumanResources].[Employee] (
    [EmployeeID] INTEGER IDENTITY(1,1) NOT NULL,
    [LastName] VARCHAR(20) NOT NULL,
    [FirstName] VARCHAR(20) NOT NULL,
    [TitleID] INTEGER NOT NULL,
    [TitleOfCourtesyID] INTEGER NOT NULL,
    [BirthDate] DATETIME2 NOT NULL,
    [HireDate] DATETIME2 NOT NULL,
    [Address1] VARCHAR(60) NOT NULL,
    [Address2] VARCHAR(60),
    [City] VARCHAR(40) NOT NULL,
    [Region] VARCHAR(15),
    [PostalCode] VARCHAR(10),
    [CountryID] INTEGER NOT NULL,
    [HomePhone] VARCHAR(40) NOT NULL,
    [Extension] VARCHAR(4) NOT NULL,
    [Picture] IMAGE,
    [Notes] NTEXT,
    [ReportsToID] INTEGER,
    [PicturePath] VARCHAR(255),
    [IsActive] BIT CONSTRAINT [DEF_Employee_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Employee_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Employee_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Employee_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Employee_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Employee] PRIMARY KEY ([EmployeeID])
)
GO

CREATE NONCLUSTERED INDEX [IDX_Employee_1] ON [HumanResources].[Employee] ([LastName] ASC,[FirstName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Employee_2] ON [HumanResources].[Employee] ([TitleID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Employee_3] ON [HumanResources].[Employee] ([TitleOfCourtesyID] ASC)
GO

CREATE  INDEX [IDX_Employee_4] ON [HumanResources].[Employee] ([CountryID])
GO

/* ---------------------------------------------------------------------- */
/* Add table "Country"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Administration].[Country] (
    [CountryID] INTEGER IDENTITY(1,1) NOT NULL,
    [CountryName] VARCHAR(40) NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_Country_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Country_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Country_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Country_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Country_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Country] PRIMARY KEY ([CountryID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Country_1] ON [Administration].[Country] ([CountryName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Region"                                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE [HumanResources].[Region] (
    [RegionID] INTEGER IDENTITY(1,1) NOT NULL,
    [RegionName] VARCHAR(40) NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_Region_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Region_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Region_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Region_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Region_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Region] PRIMARY KEY ([RegionID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Region_1] ON [HumanResources].[Region] ([RegionName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Territory"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [HumanResources].[Territory] (
    [TerritoryID] INTEGER IDENTITY(1,1) NOT NULL,
    [TerritoryCode] CHAR(5) NOT NULL,
    [TerritoryName] VARCHAR(40) NOT NULL,
    [RegionID] INTEGER NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_Territory_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Territory_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Territory_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Territory_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Territory_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Territory] PRIMARY KEY ([TerritoryID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Territory_1] ON [HumanResources].[Territory] ([TerritoryCode] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Territory_2] ON [HumanResources].[Territory] ([TerritoryName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Territory_3] ON [HumanResources].[Territory] ([RegionID] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "EmployeeToTerritory"                                        */
/* ---------------------------------------------------------------------- */

CREATE TABLE [HumanResources].[EmployeeToTerritory] (
    [EmployeeToTerritoryID] INTEGER IDENTITY(1,1) NOT NULL,
    [EmployeeID] INTEGER NOT NULL,
    [TerritoryID] INTEGER NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_EmployeeToTerritory_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_EmployeeToTerritory_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_EmployeeToTerritory_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_EmployeeToTerritory_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_EmployeeToTerritory_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_EmployeeToTerritory] PRIMARY KEY ([EmployeeToTerritoryID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_EmployeeToTerritory_1] ON [HumanResources].[EmployeeToTerritory] ([EmployeeID] ASC,[TerritoryID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_EmployeeToTerritory_2] ON [HumanResources].[EmployeeToTerritory] ([EmployeeID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_EmployeeToTerritory_3] ON [HumanResources].[EmployeeToTerritory] ([TerritoryID] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Invoice"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Sales].[Invoice] (
    [InvoiceID] INTEGER IDENTITY(1,1) NOT NULL,
    [CustomerID] INTEGER NOT NULL,
    [EmployeeID] INTEGER NOT NULL,
    [InvoiceDate] DATETIME2 NOT NULL,
    [RequiredDate] DATETIME2,
    [ShippedDate] DATETIME2,
    [ShipperID] INTEGER NOT NULL,
    [Freight] MONEY NOT NULL,
    [ShipName] VARCHAR(40) NOT NULL,
    [ShipAddress1] VARCHAR(60) NOT NULL,
    [ShipAddress2] VARCHAR(60),
    [ShipCity] VARCHAR(40) NOT NULL,
    [ShipRegion] VARCHAR(15),
    [ShipPostalCode] VARCHAR(10) NOT NULL,
    [CountryID] INTEGER NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Invoice_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Invoice_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Invoice_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Invoice_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Invoice] PRIMARY KEY ([InvoiceID])
)
GO

CREATE NONCLUSTERED INDEX [IDX_Invoice_1] ON [Sales].[Invoice] ([InvoiceDate] DESC,[CustomerID] ASC,[EmployeeID] ASC,[ShipperID] ASC,[CountryID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Invoice_2] ON [Sales].[Invoice] ([InvoiceDate] DESC)
GO

CREATE NONCLUSTERED INDEX [IDX_Invoice_3] ON [Sales].[Invoice] ([ShippedDate] DESC)
GO

CREATE NONCLUSTERED INDEX [IDX_Invoice_4] ON [Sales].[Invoice] ([ShipperID] DESC)
GO

CREATE NONCLUSTERED INDEX [IDX_Invoice_5] ON [Sales].[Invoice] ([ShipPostalCode] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Invoice_6] ON [Sales].[Invoice] ([EmployeeID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Invoice_7] ON [Sales].[Invoice] ([CustomerID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Invoice_8] ON [Sales].[Invoice] ([CountryID] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Customer"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Customers].[Customer] (
    [CustomerID] INTEGER IDENTITY(1,1) NOT NULL,
    [CustomerName] VARCHAR(40) NOT NULL,
    [ContactName] VARCHAR(40) NOT NULL,
    [ContactTitleID] INTEGER NOT NULL,
    [Address1] VARCHAR(60) NOT NULL,
    [Address2] VARCHAR(60),
    [City] VARCHAR(40) NOT NULL,
    [Region] VARCHAR(15),
    [PostalCode] VARCHAR(10),
    [CountryID] INTEGER NOT NULL,
    [Phone] VARCHAR(40) NOT NULL,
    [Fax] VARCHAR(40),
    [Email] VARCHAR(100),
    [CustomerIDOld] NCHAR(5) NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_Customer_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Customer_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Customer_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Customer_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Customer_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY ([CustomerID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Customer_1] ON [Customers].[Customer] ([CustomerName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Customer_2] ON [Customers].[Customer] ([ContactTitleID] ASC)
GO

CREATE  INDEX [IDX_Customer_3] ON [Customers].[Customer] ([CountryID])
GO

/* ---------------------------------------------------------------------- */
/* Add table "InvoiceItem"                                                */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Sales].[InvoiceItem] (
    [InvoiceItemID] INTEGER IDENTITY(1,1) NOT NULL,
    [InvoiceID] INTEGER NOT NULL,
    [ProductID] INTEGER NOT NULL,
    [UnitPrice] MONEY CONSTRAINT [DEF_InvoiceItem_UnitPrice] DEFAULT 0 NOT NULL,
    [Quantity] INTEGER CONSTRAINT [DEF_InvoiceItem_Quantity] DEFAULT 0 NOT NULL,
    [Discount] DECIMAL(18,2) CONSTRAINT [DEF_InvoiceItem_Discount] DEFAULT 0 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_InvoiceItem_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_InvoiceItem_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_InvoiceItem_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_InvoiceItem_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_InvoiceItem] PRIMARY KEY ([InvoiceItemID])
)
GO

CREATE NONCLUSTERED INDEX [IDX_InvoiceItem_1] ON [Sales].[InvoiceItem] ([InvoiceID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_InvoiceItem_2] ON [Sales].[InvoiceItem] ([ProductID] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Shipper"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Sales].[Shipper] (
    [ShipperID] INTEGER IDENTITY(1,1) NOT NULL,
    [ShipperName] VARCHAR(40) NOT NULL,
    [Phone] VARCHAR(40),
    [IsActive] BIT CONSTRAINT [DEF_Shipper_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Shipper_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Shipper_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Shipper_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Shipper_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Shipper] PRIMARY KEY ([ShipperID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Shipper_1] ON [Sales].[Shipper] ([ShipperName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "ContactTitle"                                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Administration].[ContactTitle] (
    [ContactTitleID] INTEGER IDENTITY(1,1) NOT NULL,
    [ContactTitleName] VARCHAR(40) NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_ContactTitle_IsActive] DEFAULT 14 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_ContactTitle_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_ContactTitle_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_ContactTitle_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_ContactTitle_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_ContactTitle] PRIMARY KEY ([ContactTitleID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_ContactTitle_1] ON [Administration].[ContactTitle] ([ContactTitleName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Title"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE [HumanResources].[Title] (
    [TitleID] INTEGER IDENTITY(1,1) NOT NULL,
    [TitleName] VARCHAR(40) NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_Title_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Title_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Title_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Title_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Title_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Title] PRIMARY KEY ([TitleID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Title_1] ON [HumanResources].[Title] ([TitleName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "TitleOfCourtesy"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [HumanResources].[TitleOfCourtesy] (
    [TitleOfCourtesyID] INTEGER IDENTITY(1,1) NOT NULL,
    [TitleOfCourtesyName] VARCHAR(40) NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_TitleOfCourtesy_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_TitleOfCourtesy_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_TitleOfCourtesy_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_TitleOfCourtesy_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_TitleOfCourtesy_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_TitleOfCourtesy] PRIMARY KEY ([TitleOfCourtesyID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_TitleOfCourtesy_1] ON [HumanResources].[TitleOfCourtesy] ([TitleOfCourtesyName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "HolidayDescription"                                         */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Administration].[HolidayDescription] (
    [HolidayDescriptionID] INTEGER IDENTITY(1,1) NOT NULL,
    [HolidayDescriptionName] VARCHAR(40) NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_HolidayDescription_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_HolidayDescription_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_HolidayDescription_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_HolidayDescription_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_HolidayDescription_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_HolidayDescription] PRIMARY KEY ([HolidayDescriptionID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_HolidayDescription_1] ON [Administration].[HolidayDescription] ([HolidayDescriptionName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "Holiday"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Administration].[Holiday] (
    [HolidayID] INTEGER IDENTITY(1,1) NOT NULL,
    [HolidayDate] DATETIME2 NOT NULL,
    [HolidayDescriptionID] INTEGER NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_Holiday_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_Holiday_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_Holiday_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_Holiday_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_Holiday_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_Holiday] PRIMARY KEY ([HolidayID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_Holiday_1] ON [Administration].[Holiday] ([HolidayDate] DESC,[HolidayDescriptionID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_Holiday_2] ON [Administration].[Holiday] ([HolidayDescriptionID] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "ErrorLog"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[ErrorLog] (
    [ErrorLogID] INTEGER IDENTITY(1,1) NOT NULL,
    [ErrorTime] DATETIME2 CONSTRAINT [DEF_ErrorLog_ErrorTime] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [UserName] SYSNAME NOT NULL,
    [ErrorNumber] INTEGER NOT NULL,
    [ErrorSeverity] INTEGER,
    [ErrorState] INTEGER,
    [ErrorProcedure] NVARCHAR(500),
    [ErrorLine] INTEGER,
    [ErrorMessage] NVARCHAR(4000) NOT NULL,
    CONSTRAINT [PK_ErrorLog] PRIMARY KEY ([ErrorLogID])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "BuildVersion"                                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[BuildVersion] (
    [BuildVersionID] INTEGER IDENTITY(1,1) NOT NULL,
    [DatabaseVersion] VARCHAR(25) NOT NULL,
    [VersionDate] DATETIME2 CONSTRAINT [DEF_BuildVersion_VersionDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_BuildVersion_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT [PK_BuildVersion] PRIMARY KEY ([BuildVersionID])
)
GO

/* ---------------------------------------------------------------------- */
/* Add table "ApplicationRole"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Security].[ApplicationRole] (
    [ApplicationRoleID] INTEGER IDENTITY(1,1) NOT NULL,
    [ApplicationRoleName] VARCHAR(40) NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_ApplicationRole_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_ApplicationRole_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_ApplicationRole_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_ApplicationRole_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_ApplicationRole_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_ApplicationRole] PRIMARY KEY ([ApplicationRoleID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_ApplicationRole_1] ON [Security].[ApplicationRole] ([ApplicationRoleName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "ApplicationUser"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Security].[ApplicationUser] (
    [ApplicationUserID] INTEGER IDENTITY(1,1) NOT NULL,
    [ApplicationUserLastName] VARCHAR(20) NOT NULL,
    [ApplicationUserFirstName] VARCHAR(20) NOT NULL,
    [Username] VARCHAR(20) NOT NULL,
    [Password] VARCHAR(100) NOT NULL,
    [Email] VARCHAR(100),
    [LastLoginDate] DATETIME2,
    [LastActivityDate] DATETIME2,
    [LastPasswordChangeDate] DATETIME2 NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_ApplicationUser_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_ApplicationUser_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_ApplicationUser_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_ApplicationUser_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_ApplicationUser_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_ApplicationUser] PRIMARY KEY ([ApplicationUserID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_ApplicationUser_1] ON [Security].[ApplicationUser] ([Username] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_ApplicationUser_2] ON [Security].[ApplicationUser] ([ApplicationUserLastName] ASC,[ApplicationUserFirstName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "ApplicationUserToApplicationRole"                           */
/* ---------------------------------------------------------------------- */

CREATE TABLE [Security].[ApplicationUserToApplicationRole] (
    [ApplicationUserToApplicationRoleID] INTEGER IDENTITY(1,1) NOT NULL,
    [ApplicationRoleID] INTEGER NOT NULL,
    [ApplicationUserID] INTEGER NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_ApplicationUserToApplicationRole_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_ApplicationUserToApplicationRole_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_ApplicationUserToApplicationRole_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_ApplicationUserToApplicationRole_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_ApplicationUserToApplicationRole_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_ApplicationUserToApplicationRole] PRIMARY KEY ([ApplicationUserToApplicationRoleID])
)
GO

CREATE  INDEX [IDX_ApplicationUserToApplicationRole_1] ON [Security].[ApplicationUserToApplicationRole] ([ApplicationRoleID])
GO

CREATE  INDEX [IDX_ApplicationUserToApplicationRole_2] ON [Security].[ApplicationUserToApplicationRole] ([ApplicationUserID])
GO

/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Products].[Product] ADD CONSTRAINT [FK_Category_Product] 
    FOREIGN KEY ([CategoryID]) REFERENCES [Products].[Category] ([CategoryID])
GO

ALTER TABLE [Products].[Product] ADD CONSTRAINT [FK_Supplier_Product] 
    FOREIGN KEY ([SupplierID]) REFERENCES [Products].[Supplier] ([SupplierID])
GO

ALTER TABLE [Products].[Supplier] ADD CONSTRAINT [FK_ContactTitle_Supplier] 
    FOREIGN KEY ([ContactTitleID]) REFERENCES [Administration].[ContactTitle] ([ContactTitleID])
GO

ALTER TABLE [Products].[Supplier] ADD CONSTRAINT [FK_Country_Supplier] 
    FOREIGN KEY ([CountryID]) REFERENCES [Administration].[Country] ([CountryID])
GO

ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [FK_Title_Employee] 
    FOREIGN KEY ([TitleID]) REFERENCES [HumanResources].[Title] ([TitleID])
GO

ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [FK_TitleOfCourtesy_Employee] 
    FOREIGN KEY ([TitleOfCourtesyID]) REFERENCES [HumanResources].[TitleOfCourtesy] ([TitleOfCourtesyID])
GO

ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [FK_Country_Employee] 
    FOREIGN KEY ([CountryID]) REFERENCES [Administration].[Country] ([CountryID])
GO

ALTER TABLE [HumanResources].[Territory] ADD CONSTRAINT [FK_Region_Territory] 
    FOREIGN KEY ([RegionID]) REFERENCES [HumanResources].[Region] ([RegionID])
GO

ALTER TABLE [HumanResources].[EmployeeToTerritory] ADD CONSTRAINT [FK_Employee_EmployeeToTerritory] 
    FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee] ([EmployeeID])
GO

ALTER TABLE [HumanResources].[EmployeeToTerritory] ADD CONSTRAINT [FK_Territory_EmployeeToTerritory] 
    FOREIGN KEY ([TerritoryID]) REFERENCES [HumanResources].[Territory] ([TerritoryID])
GO

ALTER TABLE [Sales].[Invoice] ADD CONSTRAINT [FK_Employee_Invoice] 
    FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee] ([EmployeeID])
GO

ALTER TABLE [Sales].[Invoice] ADD CONSTRAINT [FK_Customer_Invoice] 
    FOREIGN KEY ([CustomerID]) REFERENCES [Customers].[Customer] ([CustomerID])
GO

ALTER TABLE [Sales].[Invoice] ADD CONSTRAINT [FK_Shipper_Invoice] 
    FOREIGN KEY ([ShipperID]) REFERENCES [Sales].[Shipper] ([ShipperID])
GO

ALTER TABLE [Sales].[Invoice] ADD CONSTRAINT [FK_Country_Invoice] 
    FOREIGN KEY ([CountryID]) REFERENCES [Administration].[Country] ([CountryID])
GO

ALTER TABLE [Customers].[Customer] ADD CONSTRAINT [FK_ContactTitle_Customer] 
    FOREIGN KEY ([ContactTitleID]) REFERENCES [Administration].[ContactTitle] ([ContactTitleID])
GO

ALTER TABLE [Customers].[Customer] ADD CONSTRAINT [FK_Country_Customer] 
    FOREIGN KEY ([CountryID]) REFERENCES [Administration].[Country] ([CountryID])
GO

ALTER TABLE [Sales].[InvoiceItem] ADD CONSTRAINT [FK_Invoice_InvoiceItem] 
    FOREIGN KEY ([InvoiceID]) REFERENCES [Sales].[Invoice] ([InvoiceID])
GO

ALTER TABLE [Sales].[InvoiceItem] ADD CONSTRAINT [FK_Product_InvoiceItem] 
    FOREIGN KEY ([ProductID]) REFERENCES [Products].[Product] ([ProductID])
GO

ALTER TABLE [Administration].[Holiday] ADD CONSTRAINT [FK_HolidayDescription_Holiday] 
    FOREIGN KEY ([HolidayDescriptionID]) REFERENCES [Administration].[HolidayDescription] ([HolidayDescriptionID])
GO

ALTER TABLE [Security].[ApplicationUserToApplicationRole] ADD CONSTRAINT [FK_ApplicationRole_ApplicationUserToApplicationRole] 
    FOREIGN KEY ([ApplicationRoleID]) REFERENCES [Security].[ApplicationRole] ([ApplicationRoleID])
GO

ALTER TABLE [Security].[ApplicationUserToApplicationRole] ADD CONSTRAINT [FK_ApplicationUser_ApplicationUserToApplicationRole] 
    FOREIGN KEY ([ApplicationUserID]) REFERENCES [Security].[ApplicationUser] ([ApplicationUserID])
GO
