USE Northwind;
GO


UPDATE Orders
SET OrderDate = DATEADD(YEAR, 19, OrderDate)
, RequiredDate = DATEADD(YEAR, 19, RequiredDate)
, ShippedDate =  
(
  CASE 
	WHEN (ShippedDate IS NULL) THEN NULL
	ELSE DATEADD(YEAR, 19, ShippedDate)
 END )
FROM dbo.Orders

SELECT * FROM dbo.Orders