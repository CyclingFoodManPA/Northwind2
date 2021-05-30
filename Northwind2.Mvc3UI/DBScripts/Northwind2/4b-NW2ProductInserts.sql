USE Northwind2
GO

PRINT '****************'
PRINT 'Products Inserts'
PRINT '****************'
GO

PRINT '***************'
PRINT 'Insert Supplier'
PRINT '***************'
GO
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT Products.Supplier ON
GO
ALTER TABLE Products.Supplier
  NOCHECK CONSTRAINT ALL
GO
INSERT INTO [Products].[Supplier]
            ([SupplierID]
             ,[SupplierName]
             ,[ContactName]
             ,[ContactTitleID]
             ,[Address1]
             ,[City]
             ,[Region]
             ,[PostalCode]
             ,[CountryID]
             ,[Phone]
             ,[Fax]
             ,[HomePage])
SELECT
  S.[SupplierID]
  ,S.[CompanyName]
  ,S.[ContactName]
  ,CT.[ContactTitleID]
  ,S.[Address]
  ,S.[City]
  ,S.[Region]
  ,S.[PostalCode]
  ,C.[CountryID]
  ,S.[Phone]
  ,S.[Fax]
  ,S.[HomePage]
FROM
  [Northwind].[dbo].[Suppliers] AS S
  JOIN Northwind2.Administration.ContactTitle AS CT
    ON S.ContactTitle = CT.ContactTitleName
  LEFT OUTER JOIN Northwind2.Administration.Country AS C
               ON S.Country = C.CountryName
GO
SET IDENTITY_INSERT Products.Supplier OFF
GO
ALTER TABLE Products.Supplier
  CHECK CONSTRAINT ALL
GO



PRINT '***************'
PRINT 'Insert Category'
PRINT '***************'
GO
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT Products.Category ON
GO
ALTER TABLE Products.Category
  NOCHECK CONSTRAINT ALL
GO
INSERT Products.Category
       (CategoryID
        ,CategoryName
        ,CategoryDescription
        ,Picture)
SELECT
  CategoryID
  ,CategoryName
  ,Description
  ,Picture
FROM
  Northwind.dbo.Categories
ORDER  BY CategoryID
GO
SET IDENTITY_INSERT Products.Category OFF
GO
ALTER TABLE Products.Category
  CHECK CONSTRAINT ALL
GO
SET QUOTED_IDENTIFIER ON
GO

PRINT '**************'
PRINT 'Insert Product'
PRINT '**************'
GO
USE [Northwind2]
GO

SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT Products.Product ON
GO
ALTER TABLE Products.Product
  NOCHECK CONSTRAINT ALL
GO
INSERT Products.Product
       (ProductID
        ,ProductName
        ,SupplierID
        ,CategoryID
        ,QuantityPerUnit
        ,UnitPrice
        ,UnitsInStock
        ,UnitsOnOrder
        ,ReorderLevel
        ,IsActive)
SELECT
  ProductID
  ,ProductName
  ,SupplierID
  ,CategoryID
  ,QuantityPerUnit
  ,UnitPrice
  ,UnitsInStock
  ,ISNULL(UnitsOnOrder,
          0)
  ,ISNULL(ReorderLevel,
          0)
  ,CASE Discontinued
     WHEN 1 THEN 0
     WHEN 0 THEN 1
     ELSE 0
   END AS IsActive
FROM
  Northwind.dbo.Products
WHERE
  ProductName NOT LIKE '%Test%'
ORDER  BY ProductID
GO
SET IDENTITY_INSERT Products.Product OFF
GO
ALTER TABLE Products.Product
  CHECK CONSTRAINT ALL
GO
SET QUOTED_IDENTIFIER ON
GO 
