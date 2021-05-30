USE Northwind2
GO

PRINT '*************'
PRINT 'Sales Inserts'
PRINT '*************'
GO

PRINT '**************'
PRINT 'Insert Shipper'
PRINT '**************'
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT Sales.Shipper ON
GO
ALTER TABLE Sales.Shipper
  NOCHECK CONSTRAINT ALL
GO
INSERT INTO Sales.Shipper
            (ShipperID
             ,ShipperName
             ,Phone)
SELECT
  ShipperID
  ,CompanyName
  ,Phone
FROM
  Northwind.dbo.Shippers
GO
ALTER TABLE Sales.Shipper
  CHECK CONSTRAINT ALL
GO
SET IDENTITY_INSERT Sales.Shipper OFF
GO

PRINT '**************'
PRINT 'Insert Invoice'
PRINT '**************'
GO
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT Sales.Invoice ON
GO
ALTER TABLE Sales.Invoice
  NOCHECK CONSTRAINT ALL
GO
INSERT INTO Sales.Invoice
            (InvoiceID
             ,CustomerID
             ,EmployeeID
             ,InvoiceDate
             ,RequiredDate
             ,ShippedDate
             ,ShipperID
             ,Freight
             ,ShipName
             ,ShipAddress1
             ,ShipCity
             ,ShipRegion
             ,ShipPostalCode
             ,CountryID)
SELECT
  O.OrderID
  ,C.CustomerID
  ,O.EmployeeID
  ,O.OrderDate
  ,O.RequiredDate
  ,O.ShippedDate
  ,O.ShipVia
  ,O.Freight
  ,O.ShipName
  ,O.ShipAddress
  ,O.ShipCity
  ,ISNULL(O.ShipRegion,
          '')
  ,ISNULL(O.ShipPostalCode,
          '')
  ,CO.CountryID
FROM
  Northwind.dbo.Orders AS O
  JOIN Customers.Customer AS C
    ON O.CustomerID = c.CustomerIdOld
  JOIN Administration.Country AS CO
    ON O.ShipCountry = CO.CountryName
GO
ALTER TABLE Sales.Invoice
  CHECK CONSTRAINT ALL
GO
SET IDENTITY_INSERT Sales.Invoice OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
PRINT '******************'
PRINT 'Insert InvoiceItem'
PRINT '******************'
GO

INSERT INTO Sales.InvoiceItem
            (InvoiceID
             ,ProductID
             ,UnitPrice
             ,Quantity
             ,Discount)
SELECT
  OD.OrderID
  ,OD.ProductID
  ,OD.UnitPrice
  ,OD.Quantity
  ,OD.Discount
FROM
  Northwind.dbo.[Order Details] AS OD
GO 
