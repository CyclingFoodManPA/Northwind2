USE Northwind2
GO

PRINT '*****************'
PRINT 'Customers Inserts'
PRINT '*****************'
GO

PRINT '***************'
PRINT 'Insert Customer'
PRINT '***************'
GO
INSERT INTO [Customers].[Customer]
           ([CustomerName]
           ,[ContactName]
           ,[ContactTitleID]
           ,[Address1]
           ,[City]
           ,[Region]
           ,[PostalCode]
           ,[CountryID]
           ,[Phone]
           ,[Fax]
           ,[CustomerIDOld])          
SELECT [CompanyName]
      ,[ContactName]
      ,CT.[ContactTitleID]
      ,[Address]
      ,[City]
      ,[Region]
      ,[PostalCode]
      ,CO.[CountryID]
      ,[Phone]
      ,[Fax]
	  ,[CustomerID] AS CustomerIDOld
  FROM [Northwind].[dbo].[Customers] AS C
  JOIN Administration.ContactTitle AS CT
    ON ContactTitle = CT.ContactTitleName
  LEFT OUTER JOIN Administration.Country AS CO
               ON Country = CO.CountryName
GO
