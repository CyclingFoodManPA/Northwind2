USE Northwind2DW
GO

PRINT '******************'
PRINT 'Insert DimCustomer'
PRINT '******************'
GO
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT dbo.DimCustomer ON
GO
ALTER TABLE dbo.DimCustomer
  NOCHECK CONSTRAINT ALL
GO

INSERT INTO [dbo].[DimCustomer]
            ([CustomerKey],
             [CustomerName],
             [ContactName],
             [ContactTitleName],
             [CustomerAddress1],
             [CustomerAddress2],
             [CustomerCity],
             [CustomerRegion],
             [CustomerPostalCode],
             [CustomerCountryName],
             [CustomerPhone],
             [CustomerFax],
             [CustomerEMail],
             [CustomerIDOld])
SELECT
  C.[CustomerID],
  C.[CustomerName],
  C.[ContactName],
  CT.[ContactTitleName],
  C.[Address1],
  C.[Address2],
  C.[City],
  C.[Region],
  C.[PostalCode],
  CO.[CountryName],
  C.[Phone],
  C.[Fax],
  C.[EMail],
  C.[CustomerIDOld]
FROM
  [Northwind2].[Customers].[Customer] AS C
  JOIN [Northwind2].[Administration].[ContactTitle] AS CT
    ON C.[ContactTitleID] = CT.[ContactTitleID]
  JOIN [Northwind2].[Administration].[Country] AS CO
    ON C.[CountryID] = CO.[CountryID]
GO
SET IDENTITY_INSERT dbo.DimCustomer OFF
GO
ALTER TABLE dbo.DimCustomer
  CHECK CONSTRAINT ALL
GO

PRINT '******************'
PRINT 'Insert DimEmployee'
PRINT '******************'
GO
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT dbo.DimEmployee ON
GO
ALTER TABLE dbo.DimEmployee
  NOCHECK CONSTRAINT ALL
GO
INSERT INTO [dbo].[DimEmployee]
            ([EmployeeKey],
             [EmployeeLastName],
             [EmployeeFirstName],
             [TitleName],
             [TitleOfCourtesyName],
             [EmployeeBirthDate],
             [EmployeeHireDate],
             [EmployeeAddress1],
             [EmployeeAddress2],
             [EmployeeCity],
             [EmployeeRegion],
             [EmployeePostalCode],
             [EmployeeCountryName],
             [EmployeeHomePhone],
             [EmployeeExtension],
             [EmployeePicture],
             [EmployeeNotes],
             [EmployeeReportsToID],
             [EmployeePicturePath])
SELECT
  E.[EmployeeID],
  E.[LastName],
  E.[FirstName],
  T.[TitleName],
  TOC.[TitleOfCourtesyName],
  E.[BirthDate],
  E.[HireDate],
  E.[Address1],
  E.[Address2],
  E.[City],
  E.[Region],
  E.[PostalCode],
  CO.[CountryName],
  E.[HomePhone],
  E.[Extension],
  E.[Picture],
  E.[Notes],
  E.[ReportsToID],
  E.[PicturePath]
FROM
  [Northwind2].[HumanResources].[Employee] AS E
  JOIN [Northwind2].[HumanResources].[Title] AS T
    ON E.[TitleID] = T.[TitleID]
  JOIN [Northwind2].[HumanResources].[TitleOfCourtesy] AS TOC
    ON E.[TitleOfCourtesyID] = TOC.[TitleOfCourtesyID]
  JOIN [Northwind2].[Administration].[Country] AS CO
    ON E.[CountryID] = CO.[CountryID]
GO
SET IDENTITY_INSERT dbo.DimEmployee OFF
GO
ALTER TABLE dbo.DimEmployee
  CHECK CONSTRAINT ALL
GO

PRINT '***********************************'
PRINT 'Insert DimEmployeeToTerritoryRegion'
PRINT '***********************************'
GO
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT dbo.DimEmployeeToTerritoryRegion ON
GO
ALTER TABLE dbo.DimEmployeeToTerritoryRegion
  NOCHECK CONSTRAINT ALL
GO

INSERT INTO [dbo].[DimEmployeeToTerritoryRegion]
            ([EmployeeKey],
             [EmployeeToTerritoryRegionID],
             [TerritoryCode],
             [TerritoryName],
             [RegionName])
SELECT
  ET.[EmployeeID],
  ET.[EmployeeToTerritoryID],
  T.[TerritoryCode],
  T.[TerritoryName],
  R.[RegionName]
FROM
  [Northwind2].[HumanResources].[EmployeeToTerritory] AS ET
  JOIN [Northwind2].[HumanResources].[Territory] AS T
    ON ET.[TerritoryID] = T.[TerritoryID]
  JOIN [Northwind2].[HumanResources].[Region] AS R
    ON T.[RegionID] = R.[RegionID]
GO
SET IDENTITY_INSERT dbo.DimEmployeeToTerritoryRegion OFF
GO
ALTER TABLE dbo.DimEmployeeToTerritoryRegion
  CHECK CONSTRAINT ALL
GO

PRINT '*****************'
PRINT 'Insert DimProduct'
PRINT '*****************'
GO
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT dbo.DimProduct ON
GO
ALTER TABLE dbo.DimProduct
  NOCHECK CONSTRAINT ALL
GO

INSERT INTO [dbo].[DimProduct]
            ([ProductKey],
             [ProductName],
             [SupplierName],
             [SupplierContactName],
             [SupplierContactTitleName],
             [SupplierAddress1],
             [SupplierAddress2],
             [SupplierCity],
             [SupplierRegion],
             [SupplierPostalCode],
             [SupplierCountry],
             [SupplierPhone],
             [SupplierFax],
             [SupplierHomePage],
             [CategoryName],
             [CategoryDescription],
             [CategoryPicture],
             [CategoryPicturePath],
             [ProductQuantityPerUnit],
             [ProductUnitPrice],
             [ProductUnitsInStock],
             [ProductUnitsOnOrder],
             [ProductReorderLevel],
             [ProductIsDiscontinued])
SELECT
  P.[ProductID],
  P.[ProductName],
  S.[SupplierName],
  S.[ContactName],
  S.[ContactTitleID],
  S.[Address1],
  S.[Address2],
  S.[City],
  S.[Region],
  S.[PostalCode],
  S.[CountryID],
  S.[Phone],
  S.[Fax],
  S.[HomePage],
  C.[CategoryName],
  C.[CategoryDescription],
  C.[Picture],
  C.[PicturePath],
  P.[QuantityPerUnit],
  P.[UnitPrice],
  P.[UnitsInStock],
  P.[UnitsOnOrder],
  P.[ReorderLevel],
  P.[IsActive]
FROM
  [Northwind2].[Products].[Product] AS P
  JOIN [Northwind2].[Products].[Supplier] AS S
    ON P.[SupplierID] = S.[SupplierID]
  JOIN [Northwind2].[Products].[Category] AS C
    ON P.[CategoryID] = C.[CategoryID]
GO
SET IDENTITY_INSERT dbo.DimProduct OFF
GO
ALTER TABLE dbo.DimProduct
  CHECK CONSTRAINT ALL
GO

PRINT '******************'
PRINT 'Insert FactInvoice'
PRINT '******************'
GO
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT dbo.FactInvoice ON
GO
ALTER TABLE dbo.FactInvoice
  NOCHECK CONSTRAINT ALL
GO

INSERT INTO [dbo].[FactInvoice]
            ([CustomerKey],
             [EmployeeKey],
             [InvoiceItemProductKey],
             [InvoiceID],
             [InvoiceItemID],
             [InvoiceDate],
             [InvoiceRequiredDate],
             [InvoiceShippedDate],
             [ShipperName],
             [ShipperPhone],
             [InvoiceFreight],
             [InvoiceShipName],
             [InvoiceShipAddress1],
             [InvoiceShipAddress2],
             [InvoiceShipCity],
             [InvoiceShipRegion],
             [InvoiceShipPostalCode],
             [InvoiceShipCountryName],
             [InvoiceItemUnitPrice],
             [InvoiceItemQuantity],
             [InvoiceItemDiscount])
SELECT
  I.[CustomerID],
  I.[EmployeeID],
  II.[ProductID],
  I.[InvoiceID],
  II.[InvoiceItemID],
  I.[InvoiceDate],
  I.[RequiredDate],
  I.[ShippedDate],
  S.[ShipperName],
  S.[Phone],
  I.[Freight],
  I.[ShipName],
  I.[ShipAddress1],
  I.[ShipAddress2],
  I.[ShipCity],
  I.[ShipRegion],
  I.[ShipPostalCode],
  C.[CountryName],
  II.[UnitPrice],
  II.[Quantity],
  II.[Discount]
FROM
  [Northwind2].[Sales].[Invoice] AS I
  JOIN [Northwind2].[Sales].[Shipper] AS S
    ON I.[ShipperID] = S.[ShipperID]
  JOIN [Northwind2].[Administration].[Country] AS C
    ON I.CountryID = C.CountryID
  JOIN [Northwind2].[Sales].[InvoiceItem] AS II
    ON I.InvoiceID = II.InvoiceID
GO
SET IDENTITY_INSERT dbo.FactInvoice OFF
GO
ALTER TABLE dbo.FactInvoice
  CHECK CONSTRAINT ALL
GO 
