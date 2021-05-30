USE [Northwind2]
GO
/* ------------------------------------------------------------------------------- */
/*  Add all Operations Items to Operations SCHEMA                                  */
/*  CREATE SCHEMA http://msdn.microsoft.com/en-us/library/ms189462.aspx            */
/*  ALTER SCHEMA http://msdn.microsoft.com/en-us/library/ms173423.aspx             */
/*  CREATE SYNONYM http://msdn.microsoft.com/en-us/library/dd283095(SQL.100).aspx  */
/* ------------------------------------------------------------------------------- */
PRINT '***********************'
PRINT ' CREATE Security SCHEMA'
PRINT '***********************'
GO
CREATE SCHEMA Security AUTHORIZATION dbo
GO
PRINT '*****************************'
PRINT ' CREATE Administration SCHEMA'
PRINT '*****************************'
GO
CREATE SCHEMA Administration AUTHORIZATION dbo
GO
PRINT '***********************'
PRINT ' CREATE Products SCHEMA'
PRINT '***********************'
GO
CREATE SCHEMA Products AUTHORIZATION dbo
GO
PRINT '************************'
PRINT ' CREATE Customers SCHEMA'
PRINT '************************'
GO
CREATE SCHEMA Customers AUTHORIZATION dbo
GO
PRINT '*****************************'
PRINT ' CREATE HumanResources SCHEMA'
PRINT '*****************************'
GO
CREATE SCHEMA HumanResources AUTHORIZATION dbo
GO
PRINT '********************'
PRINT ' CREATE Sales SCHEMA'
PRINT '********************'
GO
CREATE SCHEMA Sales AUTHORIZATION dbo
GO
PRINT '************************'
PRINT ' CREATE Addresses SCHEMA'
PRINT '************************'
GO
CREATE SCHEMA Addresses AUTHORIZATION dbo
GO
PRINT '*****************************'
PRINT ' CREATE Communications SCHEMA'
PRINT '*****************************'
GO
CREATE SCHEMA Communications AUTHORIZATION dbo
GO 
