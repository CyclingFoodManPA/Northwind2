USE [Northwind2]
GO

PRINT '************'
PRINT 'Insert Title'
PRINT '************'
GO
INSERT INTO HumanResources.Title
            (TitleName)
SELECT DISTINCT
  Title
FROM
  Northwind.dbo.Employees
ORDER  BY Title
GO

PRINT '**********************'
PRINT 'Insert TitleOfCourtesy'
PRINT '**********************'
GO
INSERT INTO HumanResources.TitleOfCourtesy
            (TitleOfCourtesyName)
SELECT DISTINCT
  TitleOfCourtesy
FROM
  Northwind.dbo.Employees
ORDER  BY TitleOfCourtesy
GO

PRINT '***************'
PRINT 'Insert Employee'
PRINT '***************'
GO
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT HumanResources.Employee ON
GO
ALTER TABLE HumanResources.Employee
  NOCHECK CONSTRAINT ALL
GO
INSERT INTO [HumanResources].[Employee]
            ([EmployeeID]
             ,[LastName]
             ,[FirstName]
             ,[TitleID]
             ,[TitleOfCourtesyID]
             ,[BirthDate]
             ,[HireDate]
             ,[Address1]
             ,[City]
             ,[Region]
             ,[PostalCode]
             ,[CountryID]
             ,[HomePhone]
             ,[Extension]
             ,[Picture]
             ,[Notes]
             ,[ReportsToID]
             ,[PicturePath])
SELECT
  E.[EmployeeID]
  ,E.[LastName]
  ,E.[FirstName]
  ,T.[TitleID]
  ,TOC.[TitleOfCourtesyID]
  ,E.[BirthDate]
  ,E.[HireDate]
  ,E.[Address]
  ,E.[City]
  ,E.[Region]
  ,E.[PostalCode]
  ,C.[CountryID]
  ,E.[HomePhone]
  ,E.[Extension]
  ,E.[Photo]
  ,E.[Notes]
  ,E.[ReportsTo]
  ,E.[PhotoPath]
FROM
  [Northwind].[dbo].[Employees] AS E
  LEFT OUTER JOIN HumanResources.Title AS T
               ON E.Title = T.TitleName
  LEFT OUTER JOIN HumanResources.TitleOfCourtesy AS TOC
               ON E.TitleOfCourtesy = TOC.TitleOfCourtesyName
  LEFT OUTER JOIN Administration.Country AS C
               ON E.Country = C.CountryName
GO
ALTER TABLE HumanResources.Employee
  CHECK CONSTRAINT ALL
GO
SET IDENTITY_INSERT HumanResources.Employee OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


PRINT '*************'
PRINT 'Insert Region'
PRINT '*************'
GO
INSERT INTO HumanResources.Region
            (RegionName)
SELECT
  RegionDescription
FROM
  Northwind.dbo.Region
ORDER  BY RegionID
GO

PRINT '****************'
PRINT 'Insert Territory'
PRINT '****************'
GO
INSERT INTO HumanResources.Territory
            (TerritoryCode
             ,TerritoryName
             ,RegionID)
SELECT
  T.TerritoryID
  ,T.TerritoryDescription
  ,T.RegionId
FROM
  Northwind.dbo.Territories AS T
ORDER  BY TerritoryID
GO

PRINT '**************************'
PRINT 'Insert EmployeeToTerritory'
PRINT '**************************'
GO
INSERT INTO HumanResources.EmployeeToTerritory
            (EmployeeID
             ,TerritoryID)
SELECT
  ET.EmployeeID
  ,T.TerritoryId
FROM
  Northwind.dbo.EmployeeTerritories AS ET
  JOIN HumanResources.Territory AS T
    ON ET.TerritoryID = T.TerritoryCode
ORDER  BY ET.EmployeeID
          ,T.TerritoryID
GO 
