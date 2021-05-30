/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v5.2.3                     */
/* Target DBMS:           MS SQL Server 2008                              */
/* Project file:          Northwind2DW.dez                                */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database creation script                        */
/* Created on:            2016-06-24 10:25                                */
/* Model version:         Version 2016-06-24                              */
/* ---------------------------------------------------------------------- */


USE Northwind2DW
GO

/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "DimProduct"                                                 */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[DimProduct] (
    [ProductKey] INTEGER IDENTITY(1,1) NOT NULL,
    [ProductName] VARCHAR(40) NOT NULL,
    [SupplierName] VARCHAR(40) NOT NULL,
    [SupplierContactName] VARCHAR(40) NOT NULL,
    [SupplierContactTitleName] VARCHAR(40),
    [SupplierAddress1] VARCHAR(60),
    [SupplierAddress2] VARCHAR(60),
    [SupplierCity] VARCHAR(40),
    [SupplierRegion] VARCHAR(15),
    [SupplierPostalCode] VARCHAR(10),
    [SupplierCountry] VARCHAR(40),
    [SupplierPhone] VARCHAR(40),
    [SupplierFax] VARCHAR(40),
    [SupplierHomePage] VARCHAR(255),
    [CategoryName] VARCHAR(20) NOT NULL,
    [CategoryDescription] VARCHAR(100),
    [CategoryPicture] IMAGE,
    [CategoryPicturePath] VARCHAR(255),
    [ProductQuantityPerUnit] VARCHAR(20),
    [ProductUnitPrice] MONEY CONSTRAINT [DEF_DimProduct_ProductUnitPrice] DEFAULT 0 NOT NULL,
    [ProductUnitsInStock] INTEGER CONSTRAINT [DEF_DimProduct_ProductUnitsInStock] DEFAULT 0 NOT NULL,
    [ProductUnitsOnOrder] INTEGER CONSTRAINT [DEF_DimProduct_ProductUnitsOnOrder] DEFAULT 0 NOT NULL,
    [ProductReorderLevel] INTEGER CONSTRAINT [DEF_DimProduct_ProductReorderLevel] DEFAULT 0 NOT NULL,
    [ProductIsDiscontinued] BIT CONSTRAINT [DEF_DimProduct_ProductIsDiscontinued] DEFAULT -1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_DimProduct_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_DimProduct_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_DimProduct_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_DimProduct_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_DimProduct] PRIMARY KEY ([ProductKey])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_DimProduct_1] ON [dbo].[DimProduct] ([ProductName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimProduct_2] ON [dbo].[DimProduct] ([SupplierName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimProduct_3] ON [dbo].[DimProduct] ([SupplierContactName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimProduct_4] ON [dbo].[DimProduct] ([SupplierContactTitleName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimProduct_5] ON [dbo].[DimProduct] ([SupplierCountry] ASC,[SupplierRegion] ASC,[SupplierCity] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimProduct_6] ON [dbo].[DimProduct] ([CategoryName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimProduct_7] ON [dbo].[DimProduct] ([ProductUnitsInStock] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimProduct_8] ON [dbo].[DimProduct] ([ProductUnitsOnOrder] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimProduct_9] ON [dbo].[DimProduct] ([ProductReorderLevel] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimProduct_10] ON [dbo].[DimProduct] ([ProductIsDiscontinued] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "DimEmployee"                                                */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[DimEmployee] (
    [EmployeeKey] INTEGER IDENTITY(1,1) NOT NULL,
    [EmployeeLastName] VARCHAR(40) NOT NULL,
    [EmployeeFirstName] VARCHAR(40) NOT NULL,
    [TitleName] VARCHAR(40),
    [TitleOfCourtesyName] VARCHAR(40),
    [EmployeeBirthDate] DATETIME2 NOT NULL,
    [EmployeeHireDate] DATETIME2 NOT NULL,
    [EmployeeAddress1] VARCHAR(60),
    [EmployeeAddress2] VARCHAR(60),
    [EmployeeCity] VARCHAR(40),
    [EmployeeRegion] VARCHAR(15),
    [EmployeePostalCode] VARCHAR(10),
    [EmployeeCountryName] VARCHAR(40),
    [EmployeeHomePhone] VARCHAR(40),
    [EmployeeExtension] VARCHAR(4),
    [EmployeePicture] IMAGE,
    [EmployeeNotes] NTEXT,
    [EmployeeReportsToID] INTEGER,
    [EmployeePicturePath] VARCHAR(255),
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_DimEmployee_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_DimEmployee_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_DimEmployee_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_DimEmployee_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_DimEmployee] PRIMARY KEY ([EmployeeKey])
)
GO

CREATE NONCLUSTERED INDEX [IDX_DimEmployee_1] ON [dbo].[DimEmployee] ([EmployeeLastName] ASC,[EmployeeFirstName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimEmployee_2] ON [dbo].[DimEmployee] ([TitleName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimEmployee_3] ON [dbo].[DimEmployee] ([TitleOfCourtesyName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimEmployee_4] ON [dbo].[DimEmployee] ([EmployeeBirthDate] DESC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimEmployee_5] ON [dbo].[DimEmployee] ([EmployeeHireDate] DESC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimEmployee_6] ON [dbo].[DimEmployee] ([EmployeeCountryName] ASC,[EmployeeRegion] ASC,[EmployeeCity] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimEmployee_7] ON [dbo].[DimEmployee] ([EmployeeReportsToID] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "FactInvoice"                                                */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[FactInvoice] (
    [CustomerKey] INTEGER NOT NULL,
    [EmployeeKey] INTEGER NOT NULL,
    [InvoiceItemProductKey] INTEGER NOT NULL,
    [InvoiceID] INTEGER IDENTITY(1,1) NOT NULL,
    [InvoiceItemID] INTEGER NOT NULL,
    [InvoiceDate] DATETIME2 NOT NULL,
    [InvoiceRequiredDate] DATETIME2,
    [InvoiceShippedDate] DATETIME2,
    [ShipperName] VARCHAR(40) NOT NULL,
    [ShipperPhone] VARCHAR(40),
    [InvoiceFreight] MONEY NOT NULL,
    [InvoiceShipName] VARCHAR(50) NOT NULL,
    [InvoiceShipAddress1] VARCHAR(50) NOT NULL,
    [InvoiceShipAddress2] VARCHAR(50),
    [InvoiceShipCity] VARCHAR(50) NOT NULL,
    [InvoiceShipRegion] VARCHAR(50),
    [InvoiceShipPostalCode] VARCHAR(20) NOT NULL,
    [InvoiceShipCountryName] VARCHAR(40) NOT NULL,
    [InvoiceItemUnitPrice] MONEY CONSTRAINT [DEF_FactInvoice_InvoiceItemUnitPrice] DEFAULT 0 NOT NULL,
    [InvoiceItemQuantity] INTEGER CONSTRAINT [DEF_FactInvoice_InvoiceItemQuantity] DEFAULT 0 NOT NULL,
    [InvoiceItemDiscount] DECIMAL(18,6) CONSTRAINT [DEF_FactInvoice_InvoiceItemDiscount] DEFAULT 0 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_FactInvoice_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_FactInvoice_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_FactInvoice_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_FactInvoice_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_FactInvoice] PRIMARY KEY ([InvoiceID], [InvoiceItemID])
)
GO

CREATE NONCLUSTERED INDEX [IDX_FactInvoice_1] ON [dbo].[FactInvoice] ([InvoiceDate] DESC,[CustomerKey] ASC,[EmployeeKey] ASC,[InvoiceItemProductKey] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_FactInvoice_2] ON [dbo].[FactInvoice] ([InvoiceDate] DESC)
GO

CREATE NONCLUSTERED INDEX [IDX_FactInvoice_3] ON [dbo].[FactInvoice] ([InvoiceShippedDate] DESC)
GO

CREATE NONCLUSTERED INDEX [IDX_FactInvoice_4] ON [dbo].[FactInvoice] ([InvoiceShipPostalCode] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_FactInvoice_5] ON [dbo].[FactInvoice] ([CustomerKey] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_FactInvoice_6] ON [dbo].[FactInvoice] ([EmployeeKey] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_FactInvoice_7] ON [dbo].[FactInvoice] ([InvoiceItemProductKey] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "DimCustomer"                                                */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[DimCustomer] (
    [CustomerKey] INTEGER IDENTITY(1,1) NOT NULL,
    [CustomerName] VARCHAR(40) NOT NULL,
    [ContactName] VARCHAR(40) NOT NULL,
    [ContactTitleName] VARCHAR(40) NOT NULL,
    [CustomerAddress1] VARCHAR(60),
    [CustomerAddress2] VARCHAR(60),
    [CustomerCity] VARCHAR(40),
    [CustomerRegion] VARCHAR(15),
    [CustomerPostalCode] VARCHAR(10),
    [CustomerCountryName] VARCHAR(40),
    [CustomerPhone] VARCHAR(40),
    [CustomerFax] VARCHAR(40),
    [CustomerEMail] VARCHAR(100),
    [CustomerIDOld] NCHAR(5) NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_DimCustomer_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_DimCustomer_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_DimCustomer_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_DimCustomer_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_DimCustomer] PRIMARY KEY ([CustomerKey])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_DimCustomer_1] ON [dbo].[DimCustomer] ([CustomerName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimCustomer_2] ON [dbo].[DimCustomer] ([ContactName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimCustomer_3] ON [dbo].[DimCustomer] ([ContactTitleName])
GO

CREATE NONCLUSTERED INDEX [IDX_DimCustomer_4] ON [dbo].[DimCustomer] ([CustomerCountryName] ASC,[CustomerRegion] ASC,[CustomerCity] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "SystemRole"                                                 */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[SystemRole] (
    [SystemRoleID] INTEGER IDENTITY(1,1) NOT NULL,
    [SystemRoleName] VARCHAR(40) NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_SystemRole_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_SystemRole_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_SystemRole_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_SystemRole_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_SystemRole_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_SystemRole] PRIMARY KEY ([SystemRoleID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_SystemRole_1] ON [dbo].[SystemRole] ([SystemRoleName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "SystemUser"                                                 */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[SystemUser] (
    [SystemUserID] INTEGER IDENTITY(1,1) NOT NULL,
    [SystemUserLastName] VARCHAR(20) NOT NULL,
    [SystemUserFirstName] VARCHAR(20) NOT NULL,
    [UserName] VARCHAR(20) NOT NULL,
    [Password] VARCHAR(100) NOT NULL,
    [Email] VARCHAR(100),
    [LastLoginDate] DATETIME2,
    [LastActivityDate] DATETIME2,
    [LastPasswordChangeDate] DATETIME2 NOT NULL,
    [IsActive] BIT CONSTRAINT [DEF_SystemUser_IsActive] DEFAULT 1 NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_SystemUser_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_SystemUser_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_SystemUser_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_SystemUser_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_SystemUser] PRIMARY KEY ([SystemUserID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_SystemUser_1] ON [dbo].[SystemUser] ([SystemUserLastName] ASC,[SystemUserFirstName] ASC)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_SystemUser_2] ON [dbo].[SystemUser] ([UserName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "SystemUserToSystemRole"                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[SystemUserToSystemRole] (
    [SystemUserToSystemRoleID] INTEGER IDENTITY(1,1) NOT NULL,
    [SystemUserID] INTEGER NOT NULL,
    [SystemRoleID] INTEGER NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_SystemUserToSystemRole_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_SystemUserToSystemRole_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_SystemUserToSystemRole_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_SystemUserToSystemRole_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_SystemUserToSystemRole] PRIMARY KEY ([SystemUserToSystemRoleID])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_SystemUserToSystemRole_1] ON [dbo].[SystemUserToSystemRole] ([SystemUserID] ASC,[SystemRoleID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_SystemUserToSystemRole_2] ON [dbo].[SystemUserToSystemRole] ([SystemUserID] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_SystemUserToSystemRole_3] ON [dbo].[SystemUserToSystemRole] ([SystemRoleID] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "ErrorLog"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[ErrorLog] (
    [ErrorLogID] INTEGER IDENTITY(1,1) NOT NULL,
    [ErrorTime] DATETIME2 CONSTRAINT [DEF_ErrorLog_ErrorTime] DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
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
/* Add table "DimDate"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[DimDate] (
    [DateKey] INTEGER NOT NULL,
    [Date] DATETIME2 NOT NULL,
    [Day] TINYINT NOT NULL,
    [DaySuffix] VARCHAR(4) NOT NULL,
    [DayOfWeek] VARCHAR(9) NOT NULL,
    [DayOfWeekInMonth] TINYINT NOT NULL,
    [DayOfYear] INTEGER NOT NULL,
    [WeekOfYear] TINYINT NOT NULL,
    [WeekOfMonth] TINYINT NOT NULL,
    [Month] TINYINT NOT NULL,
    [MonthName] VARCHAR(9) NOT NULL,
    [Quarter] TINYINT NOT NULL,
    [QuarterName] VARCHAR(6) NOT NULL,
    [Year] CHAR(4) NOT NULL,
    [StandardDate] VARCHAR(10),
    [HolidayText] VARCHAR(50),
    CONSTRAINT [PK_DimDate] PRIMARY KEY ([DateKey])
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_DimDate_1] ON [dbo].[DimDate] ([Date] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_2] ON [dbo].[DimDate] ([Day] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_3] ON [dbo].[DimDate] ([DayOfWeek] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_4] ON [dbo].[DimDate] ([DayOfWeekInMonth] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_5] ON [dbo].[DimDate] ([DayOfYear] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_6] ON [dbo].[DimDate] ([WeekOfYear] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_7] ON [dbo].[DimDate] ([WeekOfMonth] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_8] ON [dbo].[DimDate] ([Month] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_9] ON [dbo].[DimDate] ([MonthName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_10] ON [dbo].[DimDate] ([Quarter] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_11] ON [dbo].[DimDate] ([QuarterName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_12] ON [dbo].[DimDate] ([Year] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DimDate_13] ON [dbo].[DimDate] ([HolidayText] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "DimEmployeeToTerritoryRegion"                               */
/* ---------------------------------------------------------------------- */

CREATE TABLE [DimEmployeeToTerritoryRegion] (
    [EmployeeKey] INTEGER NOT NULL,
    [EmployeeToTerritoryRegionID] INTEGER IDENTITY(1,1) NOT NULL,
    [TerritoryCode] CHAR(5) NOT NULL,
    [TerritoryName] VARCHAR(40) NOT NULL,
    [RegionName] VARCHAR(40) NOT NULL,
    [AddedBy] VARCHAR(100) CONSTRAINT [DEF_DimEmployeeToTerritoryRegion_AddedBy] DEFAULT 'dba' NOT NULL,
    [AddedDate] DATETIME2 CONSTRAINT [DEF_DimEmployeeToTerritoryRegion_AddedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [ModifiedBy] VARCHAR(100) CONSTRAINT [DEF_DimEmployeeToTerritoryRegion_ModifiedBy] DEFAULT 'dba' NOT NULL,
    [ModifiedDate] DATETIME2 CONSTRAINT [DEF_DimEmployeeToTerritoryRegion_ModifiedDate] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_DimEmployeeToTerritoryRegion] PRIMARY KEY ([EmployeeToTerritoryRegionID])
)
GO

CREATE  INDEX [IDX_DimEmployeeToTerritoryRegion_1] ON [DimEmployeeToTerritoryRegion] ([EmployeeKey])
GO

/* ---------------------------------------------------------------------- */
/* Foreign key constraints                                                */
/* ---------------------------------------------------------------------- */

ALTER TABLE [dbo].[FactInvoice] ADD CONSTRAINT [FK_DimEmployee_FactInvoice] 
    FOREIGN KEY ([EmployeeKey]) REFERENCES [dbo].[DimEmployee] ([EmployeeKey])
GO

ALTER TABLE [dbo].[FactInvoice] ADD CONSTRAINT [FK_DimCustomer_FactInvoice] 
    FOREIGN KEY ([CustomerKey]) REFERENCES [dbo].[DimCustomer] ([CustomerKey])
GO

ALTER TABLE [dbo].[FactInvoice] ADD CONSTRAINT [FK_DimProduct_FactInvoice] 
    FOREIGN KEY ([InvoiceItemProductKey]) REFERENCES [dbo].[DimProduct] ([ProductKey])
GO

ALTER TABLE [dbo].[SystemUserToSystemRole] ADD CONSTRAINT [FK_SystemUser_SystemUserToSystemRole] 
    FOREIGN KEY ([SystemUserID]) REFERENCES [dbo].[SystemUser] ([SystemUserID])
GO

ALTER TABLE [dbo].[SystemUserToSystemRole] ADD CONSTRAINT [FK_SystemRole_SystemUserToSystemRole] 
    FOREIGN KEY ([SystemRoleID]) REFERENCES [dbo].[SystemRole] ([SystemRoleID])
GO

ALTER TABLE [DimEmployeeToTerritoryRegion] ADD CONSTRAINT [FK_DimEmployee_DimEmployeeToTerritoryRegion] 
    FOREIGN KEY ([EmployeeKey]) REFERENCES [dbo].[DimEmployee] ([EmployeeKey])
GO
