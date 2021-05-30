USE Northwind2
GO
/* ---------------------------------------------------------------------- */
/*                                                                        */
/*  Populate the Administration Lookup Tables                             */
/*    ContactTitle                                                        */
/*    Country                                                             */
/*    HolidayDescription                                                  */
/*    Holiday                                                             */
/*                                                                        */
/* ---------------------------------------------------------------------- */
PRINT '**********************'
PRINT 'Administration Inserts'
PRINT '**********************'
GO


PRINT '*********************'
PRINT 'ContractTitle Inserts'
PRINT '*********************'
GO
INSERT INTO Administration.ContactTitle
            (ContactTitleName)
SELECT DISTINCT
  ContactTitle
FROM
  Northwind.dbo.Customers
UNION
SELECT DISTINCT
  ContactTitle
FROM
  Northwind.dbo.Suppliers
GO
PRINT '***************'
PRINT 'Country Inserts'
PRINT '***************'
GO
IF EXISTS
   (SELECT
      *
    FROM
      tempdb.dbo.sysobjects
    WHERE
     ID = OBJECT_ID(N'tempdb..#Country'))
  BEGIN
    DROP TABLE #Country
  END
GO
SELECT DISTINCT
  Country
INTO
  #Country
FROM
  Northwind.dbo.Employees
UNION
SELECT DISTINCT
  ShipCountry
FROM
  Northwind.dbo.Orders
UNION
SELECT DISTINCT
  Country
FROM
  Northwind.dbo.Suppliers
GO
INSERT INTO Administration.Country
            (CountryName)
SELECT
  Country
FROM
  #Country
GO


PRINT '**************************'
PRINT 'HolidayDescription Inserts'
PRINT '**************************'
GO
SET IDENTITY_INSERT Administration.HolidayDescription ON
GO
ALTER TABLE Administration.HolidayDescription
  NOCHECK CONSTRAINT ALL
GO
INSERT INTO Administration.HolidayDescription
            (HolidayDescriptionID
             ,HolidayDescriptionName)
SELECT
  1
  ,'Christmas Day'
UNION
SELECT
  2
  ,'Columbus Day'
UNION
SELECT
  3
  ,'Good Friday'
UNION
SELECT
  4
  ,'Independence Day'
UNION
SELECT
  5
  ,'Labor Day'
UNION
SELECT
  6
  ,'Martin Luther King Day'
UNION
SELECT
  7
  ,'Memorial Day'
UNION
SELECT
  8
  ,'New Year''s Day'
UNION
SELECT
  9
  ,'Presidents'' Day'
UNION
SELECT
  10
  ,'Reagan Funeral'
UNION
SELECT
  11
  ,'Thanksgiving Day'
UNION
SELECT
  12
  ,'Veterans'' Day'
GO

SET IDENTITY_INSERT Administration.HolidayDescription OFF
GO
ALTER TABLE Administration.HolidayDescription
  CHECK CONSTRAINT ALL
GO
PRINT '****************'
PRINT 'Holidays Inserts'
PRINT '****************'
GO
SET IDENTITY_INSERT Administration.Holiday ON
GO
ALTER TABLE Administration.Holiday
  NOCHECK CONSTRAINT ALL
GO
INSERT INTO Administration.Holiday
            (HolidayID
             ,HolidayDate
             ,HolidayDescriptionID)
SELECT
  158
  ,'	2014-01-01	'
  ,8
UNION
SELECT
  159
  ,'	2014-01-20	'
  ,6
UNION
SELECT
  160
  ,'	2014-02-17	'
  ,9
UNION
SELECT
  161
  ,'	2014-04-18	'
  ,3
UNION
SELECT
  162
  ,'	2014-05-26	'
  ,7
UNION
SELECT
  163
  ,'	2014-07-04	'
  ,4
UNION
SELECT
  164
  ,'	2014-09-01	'
  ,5
UNION
SELECT
  165
  ,'	2014-10-13	'
  ,2
UNION
SELECT
  166
  ,'	2014-11-27	'
  ,11
UNION
SELECT
  167
  ,'	2014-11-28	'
  ,11
UNION
SELECT
  168
  ,'	2014-12-25	'
  ,1
UNION
SELECT
  169
  ,'	2015-01-01	'
  ,8
GO