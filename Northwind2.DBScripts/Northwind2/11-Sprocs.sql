USE Northwind2
GO
--
-- http://www.exacthelp.com/2011/12/if-statement-or-condition-in-where.html
-- http://www.4guysfromrolla.com/webtech/080305-1.shtml
--
PRINT '***********************'
PRINT 'Create Customers SPROCS'
PRINT '***********************'
GO
PRINT '**********************'
PRINT 'Create Customer SPROCS'
PRINT '**********************'
GO
IF OBJECT_ID('Customers.usp_Customer_Insert',
             'P') IS NOT NULL
  DROP PROC Customers.usp_Customer_Insert
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Customers.usp_Customer_Insert @CustomerName    VARCHAR(50)
                                               ,@ContactName    VARCHAR(50)
                                               ,@ContactTitleID INT
                                               ,@CustomerIDOld  NCHAR(5)
                                               ,@AddedBy        VARCHAR(20)
                                               ,@ModifiedBy     VARCHAR(20)
                                               ,@newCustomerID  INT OUTPUT
                                               ,@newModified    TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO Customers.Customer
                (CustomerName
                 ,ContactName
                 ,ContactTitleID
                 ,CustomerIDOld
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @CustomerName
                  ,@ContactName
                  ,@ContactTitleID
                  ,@CustomerIDOld
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newCustomerID = CustomerID
      ,@newModified = Modified
    FROM
      Customers.Customer
    WHERE  CustomerID = IDENT_CURRENT('Customers.Customer')
  END
GO
IF OBJECT_ID('Customers.usp_Customer_ReadAll',
             'P') IS NOT NULL
  DROP PROC Customers.usp_Customer_ReadAll
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	09/04/2014 - modified to just bring everything back - filtering done
--                           in DAL side of application.
--              10/15/2014 - modified to utilize Common Table Expressions in the 
--                           queries 
--       Notes: http://www.codeproject.com/Articles/12338/Using-ROW-NUMBER-to-paginate-your-data-with-SQL-Se
-- =============================================
--ALTER PROCEDURE [Customers].[usp_Customer_ReadAll] @CustomerName    NVARCHAR(50) = NULL
--                                                    ,@ContactName    NVARCHAR(50) = NULL
--                                                    ,@ContactTitleID INT = 0
--                                                    ,@AddressTypeID  INT = 0
--                                                    ,@CountryID      INT = 0
--                                                    ,@SortBy         NVARCHAR(100) = 'CustomerName'
--                                                    ,@PageSize       INT = 999999
--                                                    ,@StartRecord    INT = 0
--AS
--  BEGIN
--    -- SET NOCOUNT ON added to prevent extra result sets from
--    -- interfering with SELECT statements.
--    SET NOCOUNT ON

--    IF OBJECT_ID('tempdb..##CustomerReadAll') IS NOT NULL
--      BEGIN
--        DROP TABLE ##CustomerReadAll
--      END

--    DECLARE @sql NVARCHAR(4000)
--    DECLARE @where NVARCHAR(4000)
--    SET @sql = ''
--    SET @where = ''
--    --
--    -- Build Select with FROM clause and INNER JOINS
--    --
--    SET @sql = @sql + 'SELECT TOP '
--               + LTRIM(RTRIM(CONVERT(CHAR(10), @PageSize)))
--               + ' '
--    SET @sql = @sql + ' * '
--    SET @sql = @sql + 'INTO ##CustomerReadAll '
--    SET @sql = @sql + 'FROM (SELECT '
--    SET @sql = @sql + '  ROW_NUMBER() '
--    SET @sql = @sql + '  OVER ( '
--    SET @sql = @sql + '   ORDER BY ' + @SortBy
--               + ') AS RecordNumber '
--    SET @sql = @sql + ' ,c.CustomerID '
--    SET @sql = @sql + ' ,c.CustomerName '
--    SET @sql = @sql + ' ,c.ContactName '
--    SET @sql = @sql + ' ,c.ContactTitleID '
--    SET @sql = @sql + ' ,ct.ContactTitleName '
--    SET @sql = @sql + ' ,ca.CustomerAddressID '
--    SET @sql = @sql + ' ,ca.AddressTypeID '
--    SET @sql = @sql + ' ,at.AddressTypeName '
--    SET @sql = @sql + ' ,ca.CountryID '
--    SET @sql = @sql + ' ,co.CountryName '
--    SET @sql = @sql + 'FROM Customers.Customer c '
--    SET @sql = @sql
--               + 'INNER JOIN Administration.ContactTitle ct ON c.ContactTitleID = ct.ContactTitleID '
--    SET @sql = @sql
--               + 'INNER JOIN Addresses.CustomerAddress ca   ON c.CustomerID = ca.CustomerID '
--    SET @sql = @sql
--               + 'INNER JOIN Addresses.AddressType at       ON ca.AddressTypeID = at.AddressTypeID '
--    SET @sql = @sql
--               + 'INNER JOIN Administration.Country co      ON ca.CountryID = co.CountryID '

--    --
--    -- Build WHERE Clause depending on parameters passed in
--    --

--    -- WHERE Clause for CustomerName
--    IF @CustomerName IS NOT NULL
--      BEGIN
--        SET @where = 'WHERE '
--        SET @where = @where + ' ( c.CustomerName LIKE ' + '''%'
--                     + @CustomerName + '%''' + ' ) '
--      END

--    -- WHERE Clause for ContactName.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF @ContactName IS NOT NULL
--          BEGIN
--            SET @where = @where + '  AND ( c.ContactName LIKE ' + '''%'
--                         + @ContactName + '%''' + ' ) '
--          END
--      END
--    ELSE
--      BEGIN
--        SET @where = 'WHERE '
--        SET @where = @where + ' ( c.ContactName LIKE ' + '''%'
--                     + @ContactName + '%''' + ' ) '
--      END

--    -- WHERE Clause for ContactTitleID.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @ContactTitleID > 0 )
--          BEGIN
--            SET @where = @where + '  AND ( c.ContactTitleID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @ContactTitleID)))
--                         + ') '
--          END
--      END
--    ELSE
--      BEGIN
--        IF ( @ContactTitleID > 0 )
--          BEGIN
--            SET @where = 'WHERE '
--            SET @where = @where + ' ( c.ContactTitleID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @ContactTitleID)))
--                         + ') '
--          END
--      END

--    -- WHERE Clause for AddressTypeID.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @AddressTypeID > 0 )
--          BEGIN
--            SET @where = @where + '  AND ( at.AddressTypeID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @AddressTypeID)))
--                         + ') '
--          END
--      END
--    ELSE
--      BEGIN
--        IF ( @AddressTypeID > 0 )
--          BEGIN
--            SET @where = 'WHERE '
--            SET @where = @where + ' ( at.AddressTypeID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @AddressTypeID)))
--                         + ') '
--          END
--      END

--    -- WHERE Clause for CountryID.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @CountryID > 0 )
--          BEGIN
--            SET @where = @where + '  AND ( co.CountryID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @CountryID)))
--                         + ') '
--          END
--      END
--    ELSE
--      BEGIN
--        IF ( @CountryID > 0 )
--          BEGIN
--            SET @where = 'WHERE '
--            SET @where = @where + ' ( co.CountryID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @CountryID)))
--                         + ') '
--          END
--      END

--    -- If length of @where > 0, concatenate @where and @sql
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        SET @sql = @sql + @where
--      END

--    SET @sql = @sql + ') AS CustomerRecords '
--    SET @sql = @sql + 'WHERE '
--    SET @sql = @sql + 'RecordNumber > '
--               + LTRIM(RTRIM(CONVERT(CHAR(10), @StartRecord)))
--               + ' '
--    PRINT @sql

--    EXEC sp_executesql
--      @sql

--    SELECT
--      *
--    FROM
--      ##CustomerReadAll

--    SELECT
--      COUNT(*) AS TotalCustomerCount
--    FROM
--      ##CustomerReadAll

--    IF OBJECT_ID('tempdb..##Customers') IS NOT NULL
--      BEGIN
--        DROP TABLE ##Customers
--      END
--  END
--
--
--  BEGIN
--    -- SET NOCOUNT ON added to prevent extra result sets from
--    -- interfering with SELECT statements.
--    SET NOCOUNT ON
--SELECT
--  c.CustomerID
--  ,c.CustomerName
--  ,c.ContactTitleID
--  ,ct.ContactTitleName
--  ,ca.CustomerAddressID
--  ,ca.AddressTypeID
--  ,at.AddressTypeName
--  ,ca.CountryID
--  ,co.CountryName
--  ,cc.CustomerCommunicationID
--  ,cc.CommunicationTypeID
--  ,comt.CommunicationTypeName
--  ,cc.CommunicationOrderID
--  ,como.CommunicationOrderName
--  ,cc.Communication
--FROM
--  Customers.Customer c
--  INNER JOIN Administration.ContactTitle ct
--          ON c.ContactTitleID = ct.ContactTitleID
--  INNER JOIN Addresses.CustomerAddress ca
--          ON c.CustomerID = ca.CustomerID
--  INNER JOIN Addresses.AddressType at
--          ON ca.AddressTypeID = at.AddressTypeID
--  INNER JOIN Administration.Country co
--          ON ca.CountryID = co.CountryID
--  INNER JOIN Communications.CustomerCommunication cc
--          ON c.CustomerID = cc.CustomerID
--  INNER JOIN Communications.CommunicationType comt
--          ON cc.CommunicationTypeID = comt.CommunicationTypeID
--  INNER JOIN Communications.CommunicationOrder como
--          ON cc.CommunicationOrderID = como.CommunicationOrderID
--ORDER  BY c.CustomerName
--  END
--
CREATE PROCEDURE [Customers].[usp_Customer_ReadAll]
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    WITH CustomerCTE
         AS (SELECT
               c.CustomerID
               ,c.CustomerName
               ,c.ContactTitleID
               ,ct.ContactTitleName
             FROM
               Customers.Customer c
               INNER JOIN Administration.ContactTitle ct
                       ON c.ContactTitleID = ct.ContactTitleID),
					   
         AddressCTE
         AS (SELECT
               ca.CustomerAddressID
               ,ca.CustomerID
               ,ca.AddressTypeID
               ,at.AddressTypeName
               ,ca.CountryID
               ,co.CountryName
             FROM
               Addresses.CustomerAddress ca
               INNER JOIN Addresses.AddressType at
                       ON ca.AddressTypeID = at.AddressTypeID
               INNER JOIN Administration.Country co
                       ON ca.CountryID = co.CountryID),
					   
         CommunicationCTE
         AS (SELECT
               cc.CustomerCommunicationID
               ,cc.CustomerID
               ,cc.CommunicationTypeID
               ,ct.CommunicationTypeName
               ,cc.CommunicationOrderID
               ,co.CommunicationOrderName
               ,cc.Communication
             FROM
               Communications.CustomerCommunication cc
               INNER JOIN Communications.CommunicationType ct
                       ON cc.CommunicationTypeID = ct.CommunicationTypeID
               INNER JOIN Communications.CommunicationOrder co
                       ON cc.CommunicationOrderID = co.CommunicationOrderID)
					   
    SELECT
      cuCTE.CustomerID
      ,cuCTE.CustomerName
      ,cuCTE.ContactTitleID
      ,cuCTE.ContactTitleName
      ,aCTE.CustomerAddressID
      ,aCTE.AddressTypeID
      ,aCTE.AddressTypeName
      ,aCTE.CountryID
      ,aCTE.CountryName
      ,coCTE.CustomerCommunicationID
      ,coCTE.CommunicationTypeID
      ,coCTE.CommunicationTypeName
      ,coCTE.CommunicationOrderID
      ,coCTE.CommunicationOrderName
      ,coCTE.Communication
    FROM
      CustomerCTE cuCTE
      INNER JOIN AddressCTE aCTE
              ON cuCTE.CustomerID = aCTE.CustomerID
      INNER JOIN CommunicationCTE coCTE
              ON cuCTE.CustomerID = coCTE.CustomerID
    ORDER  BY cuCTE.CustomerName
  END 
GO

IF OBJECT_ID('Customers.usp_Customer_ReadAllList',
             'P') IS NOT NULL
  DROP PROC Customers.usp_Customer_ReadAllList
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
--       Notes: http://www.codeproject.com/Articles/12338/Using-ROW-NUMBER-to-paginate-your-data-with-SQL-Se
-- =============================================
CREATE PROCEDURE Customers.usp_Customer_ReadAllList
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    SELECT
      c.CustomerID
      ,c.CustomerName
    FROM
      Customers.Customer c
    ORDER  BY c.CustomerName
  END
GO

IF OBJECT_ID('Customers.usp_Customer_ReadById',
             'P') IS NOT NULL
  DROP PROC Customers.usp_Customer_ReadById
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Customers.usp_Customer_ReadById @CustomerID INT
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    SELECT
      CustomerID
      ,CustomerName
      ,ContactName
      ,ContactTitleID
      ,CustomerIDOld
      ,AddedBy
      ,AddedDate
      ,ModifiedBy
      ,ModifiedDate
      ,Modified
    FROM
      Customers.Customer
    WHERE  CustomerID = @CustomerID

    SELECT
      ca.CustomerAddressID
      ,ca.CustomerID
      ,c.CustomerName
      ,ca.AddressTypeID
      ,at.AddressTypeName
      ,ca.AddressLine1
      ,ca.AddressLine2
      ,ca.City
      ,ca.Region
      ,ca.PostalCode
      ,ca.CountryID
	  ,co.CountryName
      ,ca.AddedBy
      ,ca.AddedDate
      ,ca.ModifiedBy
      ,ca.ModifiedDate
      ,ca.Modified
    FROM
      Addresses.CustomerAddress ca
      INNER JOIN Addresses.AddressType at
              ON ca.AddressTypeID = at.AddressTypeID
      INNER JOIN Customers.Customer c
              ON ca.CustomerID = c.CustomerID
	  INNER JOIN Administration.Country co
	          ON ca.CountryID = co.CountryID
    WHERE  ca.CustomerID = @CustomerID

    SELECT
      comm.CustomerCommunicationID
      ,comm.CustomerID
      ,c.CustomerName
      ,comm.CommunicationTypeID
      ,ct.CommunicationTypeName
      ,comm.CommunicationOrderID
      ,co.CommunicationOrderName
      ,comm.Communication
      ,comm.AddedBy
      ,comm.AddedDate
      ,comm.ModifiedBy
      ,comm.ModifiedDate
      ,comm.Modified
    FROM
      Communications.CustomerCommunication comm
      INNER JOIN Communications.CommunicationOrder co
              ON comm.CommunicationOrderID = co.CommunicationOrderID
      INNER JOIN Communications.CommunicationType ct
              ON comm.CommunicationTypeID = ct.CommunicationTypeID
      INNER JOIN Customers.Customer c
              ON comm.CustomerID = c.CustomerID
    WHERE  comm.CustomerID = @CustomerID

    SELECT
      i.InvoiceID              AS InvoiceID
      ,i.InvoiceDate           AS InvoiceDate
      ,SUM(ii.DiscountedTotal) AS Amount
    FROM
      Sales.Invoice i
      INNER JOIN Sales.InvoiceItem ii
              ON i.InvoiceID = ii.InvoiceID
    WHERE  i.CustomerID = @CustomerID
    GROUP  BY i.InvoiceID
              ,i.InvoiceDate
    ORDER  BY i.InvoiceDate DESC
  END 
GO
IF OBJECT_ID('Customers.usp_Customer_Update',
             'P') IS NOT NULL
  DROP PROC Customers.usp_Customer_Update
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Customers.usp_Customer_Update @CustomerID      INT
                                               ,@CustomerName   VARCHAR(50)
                                               ,@ContactName    VARCHAR(50)
                                               ,@ContactTitleID INT
                                               ,@CustomerIDOld  NCHAR(5)
                                               ,@ModifiedBy     VARCHAR(20)
                                               ,@newModified    TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE Customer
    SET    CustomerName = @CustomerName
           ,ContactName = @ContactName
           ,ContactTitleID = @ContactTitleID
           ,CustomerIDOld = @CustomerIDOld
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    FROM   Customers.Customer
    WHERE  CustomerID = @CustomerID

    SELECT
      @newModified = Modified
    FROM
      Customers.Customer
    WHERE  CustomerID = @CustomerID
  END
GO
IF OBJECT_ID('Customers.usp_Customer_Delete',
             'P') IS NOT NULL
  DROP PROC Customers.usp_Customer_Delete
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- http://www.4guysfromrolla.com/webtech/080305-1.shtml
-- =============================================
CREATE PROCEDURE Customers.usp_Customer_Delete @CustomerID INT
AS
  BEGIN
    DECLARE @Msg VARCHAR(500)
    -- STEP 1: Start the transaction
    BEGIN TRANSACTION
    -- STEP 2 & 3: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Addresses.CustomerAddress
    WHERE  CustomerID = @CustomerID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting CustomerAddress record with CustomerID= '
                   + CONVERT(CHAR(5), @CustomerID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 4 & 5: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Communications.CustomerCommunication
    WHERE  CustomerID = @CustomerID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting CustomerCommunication record with CustomerID= '
                   + CONVERT(CHAR(5), @CustomerID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 6 & 7: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Customers.Customer
    WHERE  CustomerID = @CustomerID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting Customer record with CustomerID= '
                   + CONVERT(CHAR(5), @CustomerID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 8: If we reach this point, the commands completed successfully
    --         Commit the transaction....
    COMMIT
  END
GO
PRINT '****************************'
PRINT 'Create HumanResources Views '
PRINT '****************************'
GO
IF OBJECT_ID('HumanResources.vw_EmployeeNameLF',
             'V') IS NOT NULL
  DROP VIEW HumanResources.vw_EmployeeNameLF
GO
CREATE VIEW HumanResources.vw_EmployeeNameLF
AS
  SELECT
    e.EmployeeID
    ,e.LastName + ', ' + e.FirstName AS EmployeeName
  FROM
    HumanResources.Employee e
GO
IF OBJECT_ID('HumanResources.vw_EmployeeNameFL',
             'V') IS NOT NULL
  DROP VIEW HumanResources.vw_EmployeeNameFL
GO
CREATE VIEW HumanResources.vw_EmployeeNameFL
AS
  SELECT
    e.EmployeeID
    ,e.FirstName + ' ' + e.LastName AS EmployeeName
  FROM
    HumanResources.Employee e
GO
PRINT '****************************'
PRINT 'Create HumanResources SPROCS'
PRINT '****************************'
GO
PRINT '**********************'
PRINT 'Create Employee SPROCS'
PRINT '**********************'
GO
IF OBJECT_ID('HumanResources.usp_Employee_Insert',
             'P') IS NOT NULL
  DROP PROC HumanResources.usp_Employee_Insert
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE HumanResources.usp_Employee_Insert @LastName           VARCHAR(50)
                                                    ,@FirstName         VARCHAR(50)
                                                    ,@TitleID           INT
                                                    ,@TitleOfCourtesyID INT
                                                    ,@BirthDate         DATETIME
                                                    ,@HireDate          DATETIME
                                                    ,@Picture           IMAGE = NULL
                                                    ,@Notes             VARCHAR(MAX)
                                                    ,@ReportsToID       INT
                                                    ,@PicturePath       VARCHAR(255)
                                                    ,@AddedBy           VARCHAR(20)
                                                    ,@ModifiedBy        VARCHAR(20)
                                                    ,@newEmployeeID     INT OUTPUT
                                                    ,@newModified       TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO HumanResources.Employee
                (LastName
                 ,FirstName
                 ,TitleID
                 ,TitleOfCourtesyID
                 ,BirthDate
                 ,HireDate
                 ,Picture
                 ,Notes
                 ,ReportsToID
                 ,PicturePath
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @LastName
                  ,@FirstName
                  ,@TitleID
                  ,@TitleOfCourtesyID
                  ,@BirthDate
                  ,@HireDate
                  ,@Picture
                  ,@Notes
                  ,@ReportsToID
                  ,@PicturePath
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newEmployeeID = EmployeeID
      ,@newModified = Modified
    FROM
      HumanResources.Employee
    WHERE  EmployeeID = IDENT_CURRENT('HumanResources.Employee')
  END
GO
IF OBJECT_ID('HumanResources.usp_Employee_ReadAll',
             'P') IS NOT NULL
  DROP PROC HumanResources.usp_Employee_ReadAll
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	09/04/2014 - modified to just bring everything back - filtering done
--                           in DAL side of application.
--              10/15/2014 - modified to utilize Common Table Expressions in the 
--                           queries 
-- =============================================
--ALTER PROCEDURE [HumanResources].[usp_Employee_ReadAll] @LastName           NVARCHAR(50) = NULL
--                                                     ,@FirstName         NVARCHAR(50) = NULL
--                                                     ,@TitleID           INT = 0
--                                                     ,@TitleOfCourtesyID INT = 0
--                                                     ,@AddressTypeID     INT = 0
--                                                     ,@CountryID         INT = 0
--                                                     ,@StartBirthDate    DATETIME2 = NULL
--                                                     ,@EndBirthDate      DATETIME2 = NULL
--                                                     ,@StartHireDate     DATETIME2 = NULL
--                                                     ,@EndHireDate       DATETIME2 = NULL
--                                                     ,@ReportsToID       INT = 0
--                                                     ,@SortBy            VARCHAR(100) = 'LastName'
--                                                     ,@PageSize          INT = 999999
--                                                     ,@StartRecord       INT = 0
--AS
--  BEGIN
--    -- SET NOCOUNT ON added to prevent extra result sets from
--    -- interfering with SELECT statements.
--    SET NOCOUNT ON

--    IF OBJECT_ID('tempdb..##Customers') IS NOT NULL
--      BEGIN
--        DROP TABLE ##Customers
--      END

--    DECLARE @sql NVARCHAR(4000)
--    DECLARE @where NVARCHAR(4000)
--    SET @sql = ''
--    SET @where = ''
--    --
--    -- Build Select with FROM clause and INNER JOINS
--    --
--    SET @sql = @sql + 'SELECT TOP '
--               + LTRIM(RTRIM(CONVERT(CHAR(10), @PageSize)))
--               + ' '
--    SET @sql = @sql + ' * '
--    SET @sql = @sql + 'FROM (SELECT '
--    SET @sql = @sql + '  ROW_NUMBER() '
--    SET @sql = @sql + '  OVER ( '
--    SET @sql = @sql + '   ORDER BY ' + @SortBy
--               + ') AS RecordNumber '
--    SET @sql = @sql + ' ,e.EmployeeID '
--    SET @sql = @sql + ' ,e.LastName + ' + ''', '''
--               + '+  e.FirstName AS EmployeeName '
--    SET @sql = @sql + ' ,e.TitleID '
--    SET @sql = @sql + ' ,t.TitleName '
--    SET @sql = @sql + ' ,e.TitleOfCourtesyID '
--    SET @sql = @sql + ' ,toc.TitleOfCourtesyName '
--    SET @sql = @sql + ' ,e.BirthDate '
--    SET @sql = @sql + ' ,e.HireDate '
--    SET @sql = @sql + ' ,e.ReportsToID '
--    SET @sql = @sql + ' ,ea.AddressTypeID '
--    SET @sql = @sql + ' ,at.AddressTypeName '
--    SET @sql = @sql + ' ,ea.CountryID '
--    SET @sql = @sql + ' ,co.CountryName '
--    SET @sql = @sql + 'FROM HumanResources.Employee e '
--    SET @sql = @sql
--               + 'INNER JOIN HumanResources.Title t ON e.TitleID = t.TitleID '
--    SET @sql = @sql
--               + 'INNER JOIN HumanResources.TitleOfCourtesy toc ON e.TitleOfCourtesyID = toc.TitleOfCourtesyID '
--    SET @sql = @sql
--               + 'INNER JOIN Addresses.EmployeeAddress ea   ON e.EmployeeID = ea.EmployeeID '
--    SET @sql = @sql
--               + 'INNER JOIN Addresses.AddressType at       ON ea.AddressTypeID = at.AddressTypeID '
--    SET @sql = @sql
--               + 'INNER JOIN Administration.Country co      ON ea.CountryID = co.CountryID '

--    --
--    -- Build WHERE Clause depending on parameters passed in
--    --

--    -- WHERE Clause for LastName
--    IF @LastName IS NOT NULL
--      BEGIN
--        SET @where = 'WHERE '
--        SET @where = @where + ' ( e.LastName LIKE ' + '''%'
--                     + @LastName + '%''' + ' ) '
--      END

--    -- WHERE Clause for FirstName.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF @FirstName IS NOT NULL
--          BEGIN
--            SET @where = @where + '  AND ( e.FirstName LIKE ' + '''%'
--                         + @FirstName + '%''' + ' ) '
--          END
--      END
--    ELSE
--      BEGIN
--        SET @where = 'WHERE '
--        SET @where = @where + ' ( e.FirstName LIKE ' + '''%'
--                     + @FirstName + '%''' + ' ) '
--      END

--    -- WHERE Clause for TitleID.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @TitleID > 0 )
--          BEGIN
--            SET @where = @where + '  AND ( e.TitleID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @TitleID)))
--                         + ') '
--          END
--      END
--    ELSE
--      BEGIN
--        IF ( @TitleID > 0 )
--          BEGIN
--            SET @where = 'WHERE '
--            SET @where = @where + ' ( e.TitleID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @TitleID)))
--                         + ') '
--          END
--      END

--    -- WHERE Clause for TitleOfCourtesyID.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @TitleOfCourtesyID > 0 )
--          BEGIN
--            SET @where = @where + '  AND ( e.TitleOfCourtesyID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @TitleOfCourtesyID)))
--                         + ') '
--          END
--      END
--    ELSE
--      BEGIN
--        IF ( @TitleOfCourtesyID > 0 )
--          BEGIN
--            SET @where = 'WHERE '
--            SET @where = @where + ' ( e.TitleOfCourtesyID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @TitleOfCourtesyID)))
--                         + ') '
--          END
--      END

--    -- WHERE Clause for AddressTypeID.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @AddressTypeID > 0 )
--          BEGIN
--            SET @where = @where + '  AND ( at.AddressTypeID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @AddressTypeID)))
--                         + ') '
--          END
--      END
--    ELSE
--      BEGIN
--        IF ( @AddressTypeID > 0 )
--          BEGIN
--            SET @where = 'WHERE '
--            SET @where = @where + ' ( at.AddressTypeID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @AddressTypeID)))
--                         + ') '
--          END
--      END

--    -- WHERE Clause for CountryID.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @CountryID > 0 )
--          BEGIN
--            SET @where = @where + '  AND ( co.CountryID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @CountryID)))
--                         + ') '
--          END
--      END
--    ELSE
--      BEGIN
--        IF ( @CountryID > 0 )
--          BEGIN
--            SET @where = 'WHERE '
--            SET @where = @where + ' ( co.CountryID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @CountryID)))
--                         + ') '
--          END
--      END

--    -- WHERE Clause for BirthDate.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @StartBirthDate IS NOT NULL
--             AND @EndBirthDate IS NOT NULL )
--          BEGIN
--            SET @where = @where + '  AND (e.BirthDate BETWEEN '''
--                         + LTRIM(RTRIM(CONVERT(CHAR(12), @StartBirthDate, 101)))
--                         + ''' AND '''
--                         + LTRIM(RTRIM(CONVERT(CHAR(12), @EndBirthDate, 101)))
--                         + ''') '
--          END

--      END
--    ELSE
--      BEGIN
--        SET @where = 'WHERE '
--        SET @where = @where + ' (e.BirthDate BETWEEN '''
--                     + LTRIM(RTRIM(CONVERT(CHAR(12), @StartBirthDate, 101)))
--                     + ''' AND '''
--                     + LTRIM(RTRIM(CONVERT(CHAR(12), @EndBirthDate, 101)))
--                     + ''') '
--      END

--    -- WHERE Clause for HireDate.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @StartHireDate IS NOT NULL
--             AND @EndHireDate IS NOT NULL )
--          BEGIN
--            SET @where = @where + '  AND (e.HireDate BETWEEN '''
--                         + LTRIM(RTRIM(CONVERT(CHAR(12), @StartHireDate, 101)))
--                         + ''' AND '''
--                         + LTRIM(RTRIM(CONVERT(CHAR(12), @EndHireDate, 101)))
--                         + ''') '
--          END
--      END
--    ELSE
--      BEGIN
--        SET @where = 'WHERE '
--        SET @where = @where + ' (e.HireDate BETWEEN '''
--                     + LTRIM(RTRIM(CONVERT(CHAR(12), @StartHireDate, 101)))
--                     + ''' AND '''
--                     + LTRIM(RTRIM(CONVERT(CHAR(12), @EndHireDate, 101)))
--                     + ''') '
--      END

--    -- WHERE Clause for ReportsToID.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @ReportsToID > 0 )
--          BEGIN
--            SET @where = @where + '  AND ( e.ReportsToID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @ReportsToID)))
--                         + ') '
--          END
--      END
--    ELSE
--      BEGIN
--        IF ( @ReportsToID > 0 )
--          BEGIN
--            SET @where = 'WHERE '
--            SET @where = @where + ' ( e.ReportsToID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @ReportsToID)))
--                         + ') '
--          END
--      END

--    -- If length of @where > 0, concatenate @where and @sql
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        SET @sql = @sql + @where
--      END

--    SET @sql = @sql + ') AS EmployeerRecords '
--    SET @sql = @sql + 'WHERE '
--    SET @sql = @sql + 'RecordNumber > '
--               + LTRIM(RTRIM(CONVERT(CHAR(10), @StartRecord)))
--               + ' '
--    PRINT @sql

--    EXEC sp_executesql
--      @sql
--
--ALTER PROCEDURE [HumanResources].[usp_Employee_ReadAll]
--AS
--  BEGIN
--    -- SET NOCOUNT ON added to prevent extra result sets from
--    -- interfering with SELECT statements.
--    SET NOCOUNT ON

--    SELECT
--      e.EmployeeID
--      ,e.LastName
--      ,e.FirstName
--      ,e.TitleID
--      ,t.TitleName
--      ,e.TitleOfCourtesyID
--      ,toc.TitleOfCourtesyName
--      ,e.BirthDate
--      ,e.HireDate
--      ,ISNull(e.ReportsToID,
--              0) AS ReportsToID
--      ,ea.AddressTypeID
--      ,at.AddressTypeName
--      ,ea.CountryID
--      ,co.CountryName
--    FROM
--      HumanResources.Employee e
--      INNER JOIN HumanResources.Title t
--              ON e.TitleID = t.TitleID
--      INNER JOIN HumanResources.TitleOfCourtesy toc
--              ON e.TitleID = toc.TitleOfCourtesyID
--      INNER JOIN Addresses.EmployeeAddress ea
--              ON e.EmployeeID = ea.EmployeeID
--      INNER JOIN Addresses.AddressType at
--              ON ea.AddressTypeID = at.AddressTypeID
--      INNER JOIN Administration.Country co
--              ON ea.CountryID = co.CountryID
--    ORDER  BY e.LastName
--              ,e.FirstName
--  END
CREATE PROCEDURE [HumanResources].[usp_Employee_ReadAll]
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    WITH EmployeeCTE
         AS (SELECT
               e.EmployeeID
               ,e.LastName
               ,e.FirstName
               ,e.TitleID
               ,t.TitleName
               ,e.TitleOfCourtesyID
               ,toc.TitleOfCourtesyName
             FROM
               HumanResources.Employee e
               INNER JOIN HumanResources.Title t
                       ON e.TitleID = t.TitleID
               INNER JOIN HumanResources.TitleOfCourtesy toc
                       ON e.TitleOfCourtesyID = toc.TitleOfCourtesyID),

         AddressCTE
         AS (SELECT
               ea.EmployeeAddressID
               ,ea.EmployeeID
               ,ea.AddressTypeID
               ,at.AddressTypeName
               ,ea.CountryID
               ,co.CountryName
             FROM
               Addresses.EmployeeAddress ea
               INNER JOIN Addresses.AddressType at
                       ON ea.AddressTypeID = at.AddressTypeID
               INNER JOIN Administration.Country co
                       ON ea.CountryID = co.CountryID),

         CommunicationCTE
         AS (SELECT
               ec.EmployeeCommunicationID
               ,ec.EmployeeID
               ,ec.CommunicationTypeID
               ,ct.CommunicationTypeName
               ,ec.CommunicationOrderID
               ,co.CommunicationOrderName
               ,ec.Communication
             FROM
               Communications.EmployeeCommunication ec
               INNER JOIN Communications.CommunicationType ct
                       ON ec.CommunicationTypeID = ct.CommunicationTypeID
               INNER JOIN Communications.CommunicationOrder co
                       ON ec.CommunicationOrderID = co.CommunicationOrderID)

    SELECT
      eCTE.EmployeeID
      ,eCTE.LastName
      ,eCTE.FirstName
      ,eCTE.TitleID
      ,eCTE.TitleName
      ,eCTE.TitleOfCourtesyID
      ,eCTE.TitleOfCourtesyName
      ,aCTE.EmployeeAddressID
      ,aCTE.AddressTypeID
      ,aCTE.AddressTypeName
      ,aCTE.CountryID
      ,aCTE.CountryName
      ,coCTE.EmployeeCommunicationID
      ,coCTE.CommunicationTypeID
      ,coCTE.CommunicationTypeName
      ,coCTE.CommunicationOrderID
      ,coCTE.CommunicationOrderName
      ,coCTE.Communication
    FROM
      EmployeeCTE eCTE
      INNER JOIN AddressCTE aCTE
              ON eCTE.EmployeeID = aCTE.EmployeeID
      INNER JOIN CommunicationCTE coCTE
              ON eCTE.EmployeeID = coCTE.EmployeeID
    ORDER  BY eCTE.LastName
              ,eCTE.FirstName
  END 
GO
IF OBJECT_ID('HumanResources.usp_Employee_ReadAllList',
             'P') IS NOT NULL
  DROP PROC HumanResources.usp_Employee_ReadAllList
GO

CREATE PROCEDURE [HumanResources].[usp_Employee_ReadAllList]
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    SELECT
      e.EmployeeID
      ,e.LastName + ', ' + e.FirstName AS EmployeeName
    FROM
      HumanResources.Employee e
    ORDER  BY e.LastName
              ,e.FirstName
  END
GO
IF OBJECT_ID('HumanResources.usp_Employee_ReadById',
             'P') IS NOT NULL
  DROP PROC HumanResources.usp_Employee_ReadById
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE [HumanResources].[usp_Employee_ReadById] @EmployeeID INT
AS
  BEGIN
    SET NOCOUNT ON

    SELECT
      EmployeeID
      ,LastName
      ,FirstName
      ,TitleID
      ,TitleOfCourtesyID
      ,BirthDate
      ,HireDate
      ,Picture
      ,Notes
      ,ReportsToID
      ,PicturePath
      ,AddedBy
      ,AddedDate
      ,ModifiedBy
      ,ModifiedDate
      ,Modified
    FROM
      HumanResources.Employee
    WHERE  EmployeeID = @EmployeeID

    SELECT
      ea.EmployeeAddressID
      ,ea.EmployeeID
      ,at.AddressTypeID
      ,ea.AddressLine1
      ,ea.AddressLine2
      ,ea.City
      ,ea.Region
      ,ea.PostalCode
      ,ea.CountryID
      ,ea.AddedBy
      ,ea.AddedDate
      ,ea.ModifiedBy
      ,ea.ModifiedDate
      ,ea.Modified
    FROM
      Addresses.EmployeeAddress ea
      INNER JOIN Addresses.AddressType at
              ON ea.AddressTypeID = at.AddressTypeID
    WHERE  ea.EmployeeID = @EmployeeID

    SELECT
      comm.EmployeeCommunicationID
      ,comm.EmployeeID
      ,comm.CommunicationTypeID
      ,comm.CommunicationOrderID
      ,comm.Communication
      ,comm.AddedBy
      ,comm.AddedDate
      ,comm.ModifiedBy
      ,comm.ModifiedDate
      ,comm.Modified
    FROM
      Communications.EmployeeCommunication comm
    WHERE  comm.EmployeeID = @EmployeeID

    SELECT
      i.InvoiceID              AS InvoiceID
      ,i.InvoiceDate           AS InvoiceDate
      ,SUM(ii.DiscountedTotal) AS Amount
    FROM
      Sales.Invoice i
      INNER JOIN Sales.InvoiceItem ii
              ON i.InvoiceID = ii.InvoiceID
    WHERE  i.EmployeeID = @EmployeeID
    GROUP  BY i.InvoiceID
              ,i.InvoiceDate
    ORDER  BY i.InvoiceDate DESC
  END
GO
IF OBJECT_ID('HumanResources.usp_Employee_Update',
             'P') IS NOT NULL
  DROP PROC HumanResources.usp_Employee_Update
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE HumanResources.usp_Employee_Update @EmployeeID         INT
                                                    ,@LastName          VARCHAR(50)
                                                    ,@FirstName         VARCHAR(50)
                                                    ,@TitleID           INT
                                                    ,@TitleOfCourtesyID INT
                                                    ,@BirthDate         DATETIME
                                                    ,@HireDate          DATETIME
                                                    ,@Picture           IMAGE = NULL
                                                    ,@Notes             NTEXT
                                                    ,@ReportsToID       INT
                                                    ,@PicturePath       VARCHAR(255)
                                                    ,@ModifiedBy        VARCHAR(20)
                                                    ,@newModified       TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE Employee
    SET    LastName = @LastName
           ,FirstName = @FirstName
           ,TitleID = @TitleID
           ,TitleOfCourtesyID = @TitleOfCourtesyID
           ,BirthDate = @BirthDate
           ,HireDate = @HireDate
           ,Picture = @Picture
           ,Notes = @Notes
           ,ReportsToID = @ReportsToID
           ,PicturePath = @PicturePath
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    FROM   HumanResources.Employee
    WHERE  EmployeeID = @EmployeeID
    SELECT
      @newModified = Modified
    FROM
      HumanResources.Employee
    WHERE  EmployeeID = @EmployeeID
  END
GO
IF OBJECT_ID('HumanResources.usp_Employee_Delete',
             'P') IS NOT NULL
  DROP PROC HumanResources.usp_Employee_Delete
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- http://www.4guysfromrolla.com/webtech/080305-1.shtml
-- =============================================
CREATE PROCEDURE HumanResources.usp_Employee_Delete @EmployeeID INT
AS
  BEGIN
    DECLARE @Msg VARCHAR(500)
    -- STEP 1: Start the transaction
    BEGIN TRANSACTION
    -- STEP 2 & 3: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Addresses.EmployeeAddress
    WHERE  EmployeeID = @EmployeeID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting EmployeeAddress record with EmployeeID= '
                   + CONVERT(CHAR(5), @EmployeeID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 4 & 5: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Communications.EmployeeCommunication
    WHERE  EmployeeID = @EmployeeID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting EmployeeCommunication record with EmployeeID= '
                   + CONVERT(CHAR(5), @EmployeeID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 6 & 7: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE HumanResources.Employee
    WHERE  EmployeeID = @EmployeeID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting Employee record with EmployeeID= '
                   + CONVERT(CHAR(5), @EmployeeID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 8: If we reach this point, the commands completed successfully
    --         Commit the transaction....
    COMMIT
  END
GO
PRINT '**********************'
PRINT 'Create Products SPROCS'
PRINT '**********************'
GO
PRINT '*********************'
PRINT 'Create Product SPROCS'
PRINT '*********************'
GO
IF OBJECT_ID('Products.usp_Product_Insert',
             'P') IS NOT NULL
  DROP PROC Products.usp_Product_Insert
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Products.usp_Product_Insert @ProductName      VARCHAR(50)
                                             ,@SupplierID      INT
                                             ,@CategoryID      INT
                                             ,@QuantityPerUnit VARCHAR(20)
                                             ,@UnitPrice       MONEY
                                             ,@UnitsInStock    INT
                                             ,@UnitsOnOrder    INT
                                             ,@ReorderLevel    INT
                                             ,@IsDiscontinued  BIT
                                             ,@AddedBy         VARCHAR(20)
                                             ,@ModifiedBy      VARCHAR(20)
                                             ,@newProductID    INT OUTPUT
                                             ,@newModified     TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO Products.Product
                (ProductName
                 ,SupplierID
                 ,CategoryID
                 ,QuantityPerUnit
                 ,UnitPrice
                 ,UnitsInStock
                 ,UnitsOnOrder
                 ,ReorderLevel
                 ,IsDiscontinued
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @ProductName
                  ,@SupplierID
                  ,@CategoryID
                  ,@QuantityPerUnit
                  ,@UnitPrice
                  ,@UnitsInStock
                  ,@UnitsOnOrder
                  ,@ReorderLevel
                  ,@IsDiscontinued
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newProductID = ProductID
      ,@newModified = Modified
    FROM
      Products.Product
    WHERE  ProductID = IDENT_CURRENT('Products.Product')
  END
GO
IF OBJECT_ID('Products.usp_Product_ReadAll',
             'P') IS NOT NULL
  DROP PROC Products.usp_Product_ReadAll
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
--ALTER PROCEDURE [Products].[usp_Product_ReadAll] @ProductName     NVARCHAR(50) = NULL
--                                              ,@SupplierID     INT = 0
--                                              ,@CategoryID     INT = 0
--                                              ,@IsDiscontinued BIT = 0
--                                              ,@SortBy         VARCHAR(100) = 'ProductName'
--                                              ,@PageSize       INT = 999999
--                                              ,@StartRecord    INT = 0
--AS
--  BEGIN
--    -- SET NOCOUNT ON added to prevent extra result sets from
--    -- interfering with SELECT statements.
--    SET NOCOUNT ON

--    DECLARE @sql NVARCHAR(4000)
--    DECLARE @where NVARCHAR(4000)
--    SET @sql = ''
--    SET @where = ''
--    --
--    -- Build Select with FROM clause and INNER JOINS
--    --
--    SET @sql = @sql + 'SELECT TOP '
--               + LTRIM(RTRIM(CONVERT(CHAR(10), @PageSize)))
--    SET @sql = @sql + ' * '
--    SET @sql = @sql + 'FROM (SELECT '
--    SET @sql = @sql + '  ROW_NUMBER() '
--    SET @sql = @sql + '  OVER ( '
--    SET @sql = @sql + '   ORDER BY ' + @SortBy
--               + ') AS RecordNumber '
--    SET @sql = @sql + ' ,p.ProductID '
--    SET @sql = @sql + ' ,p.ProductName '
--    SET @sql = @sql + ' ,p.SupplierID '
--    SET @sql = @sql + ' ,s.SupplierName '
--    SET @sql = @sql + ' ,p.CategoryID '
--    SET @sql = @sql + ' ,c.CategoryName '
--    SET @sql = @sql + ' ,p.IsDiscontinued '
--    SET @sql = @sql + 'FROM Products.Product p '
--    SET @sql = @sql
--               + 'INNER JOIN Products.Supplier s ON p.SupplierID = s.SupplierID '
--    SET @sql = @sql
--               + 'INNER JOIN Products.Category c ON p.CategoryID = c.CategoryID '
--    --
--    -- Build WHERE Clause depending on parameters passed in
--    --

--    -- WHERE Clause for ProductName
--    IF @ProductName IS NOT NULL
--      BEGIN
--        SET @where = 'WHERE '
--        SET @where = @where + ' ( p.ProductName LIKE ' + '''%'
--                     + @ProductName + '%''' + ' ) '
--      END

--    -- WHERE Clause for SupplierID.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @SupplierID > 0 )
--          BEGIN
--            SET @where = @where + '  AND ( p.SupplierID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @SupplierID)))
--                         + ') '
--          END
--      END
--    ELSE
--      BEGIN
--        IF ( @SupplierID > 0 )
--          BEGIN
--            SET @where = 'WHERE '
--            SET @where = @where + ' ( p.SupplierID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @SupplierID)))
--                         + ') '
--          END
--      END

--    -- WHERE Clause for CategoryID.  Check length of WHERE Clause:
--    --  If > 0 build with AND, Otherwise WHERE
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        IF ( @CategoryID > 0 )
--          BEGIN
--            SET @where = @where + '  AND ( p.CategoryID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @CategoryID)))
--                         + ') '
--          END
--      END
--    ELSE
--      BEGIN
--        IF ( @CategoryID > 0 )
--          BEGIN
--            SET @where = 'WHERE '
--            SET @where = @where + ' ( p.CategoryID = '
--                         + LTRIM(RTRIM(CONVERT(CHAR(10), @CategoryID)))
--                         + ') '
--          END
--      END

--    -- If length of @where > 0, concatenate @where and @sql
--    IF ( LEN(@where) > 0 )
--      BEGIN
--        SET @sql = @sql + @where
--      END

--    SET @sql = @sql + ') AS CustomerRecords '
--    SET @sql = @sql + 'WHERE '
--    SET @sql = @sql + 'RecordNumber > '
--               + LTRIM(RTRIM(CONVERT(CHAR(10), @StartRecord)))
--               + ' '
--    PRINT @sql

--    EXEC sp_executesql
--      @sql
CREATE PROCEDURE [Products].[usp_Product_ReadAll]
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    SELECT
      p.ProductID
      ,p.ProductName
      ,p.SupplierID
      ,s.SupplierName
      ,p.CategoryID
      ,c.CategoryName
      ,p.QuantityPerUnit
      ,p.UnitPrice
      ,p.UnitsInStock
      ,p.UnitsOnOrder
      ,p.ReorderLevel
      ,p.IsDiscontinued
    FROM
      Products.Product p
      INNER JOIN Products.Supplier s
              ON p.SupplierID = s.SupplierID
      INNER JOIN Products.Category c
              ON p.CategoryID = c.CategoryID
    ORDER  BY p.ProductName
  END 
GO
IF OBJECT_ID('Products.usp_Product_ReadById',
             'P') IS NOT NULL
  DROP PROC Products.usp_Product_ReadById
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Products.usp_Product_ReadById @ProductID INT
AS
  BEGIN
    SET NOCOUNT ON
    SELECT
      ProductID
      ,ProductName
      ,SupplierID
      ,CategoryID
      ,QuantityPerUnit
      ,UnitPrice
      ,UnitsInStock
      ,UnitsOnOrder
      ,ReorderLevel
      ,IsDiscontinued
      ,AddedBy
      ,AddedDate
      ,ModifiedBy
      ,ModifiedDate
	  ,Modified
    FROM
      Products.Product
    WHERE  ProductID = @ProductID

    SELECT
      ii.InvoiceItemID
	  ,i.InvoiceDate
      ,ii.InvoiceID
      ,ii.ProductID
      ,ii.UnitPrice
      ,ii.Quantity
      ,ii.Discount
	  ,ii.Quantity * ii.UnitPrice AS Amount
    FROM
      Sales.InvoiceItem ii
	INNER JOIN Sales.Invoice i
	ON ii.InvoiceID = i.InvoiceID
    WHERE  ii.ProductID = @ProductID
  END
GO

IF OBJECT_ID('Products.usp_Product_ReadAllList',
             'P') IS NOT NULL
  DROP PROC Products.usp_Product_ReadAllList
GO
CREATE PROCEDURE Products.usp_Product_ReadAllList
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    SELECT
      ProductID
      ,ProductName
    FROM
      Products.Product
    ORDER  BY ProductName
  END 
GO
IF OBJECT_ID('Products.usp_Product_Update',
             'P') IS NOT NULL
  DROP PROC Products.usp_Product_Update
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Products.usp_Product_Update @ProductID        INT
                                             ,@ProductName     VARCHAR(50)
                                             ,@SupplierID      INT
                                             ,@CategoryID      INT
                                             ,@QuantityPerUnit VARCHAR(20)
                                             ,@UnitPrice       MONEY
                                             ,@UnitsInStock    INT
                                             ,@UnitsOnOrder    INT
                                             ,@ReorderLevel    INT
                                             ,@IsDiscontinued  BIT
                                             ,@ModifiedBy      VARCHAR(20)
                                             ,@newModified     TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE Product
    SET    ProductName = @ProductName
           ,SupplierID = @SupplierID
           ,CategoryID = @CategoryID
           ,QuantityPerUnit = @QuantityPerUnit
           ,UnitPrice = @UnitPrice
           ,UnitsInStock = @UnitsInStock
           ,UnitsOnOrder = @UnitsOnOrder
           ,ReorderLevel = @ReorderLevel
           ,IsDiscontinued = @IsDiscontinued
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    FROM   Products.Product
    WHERE  ProductID = @ProductID
    SELECT
      @newModified = Modified
    FROM
      Products.Product
    WHERE  ProductID = @ProductID
  END
GO
IF OBJECT_ID('Products.usp_Product_Delete',
             'P') IS NOT NULL
  DROP PROC Products.usp_Product_Delete
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- http://www.4guysfromrolla.com/webtech/080305-1.shtml
-- =============================================
CREATE PROCEDURE Products.usp_Product_Delete @ProductID INT
AS
  BEGIN
    DECLARE @Msg VARCHAR(500)
    -- STEP 1: Start the transaction
    BEGIN TRANSACTION
    -- STEP 2 & 3: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Sales.InvoiceItem
    WHERE  ProductID = @ProductID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting InvoiceItem record with ProductID= '
                   + CONVERT(CHAR(5), @ProductID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 4 & 5: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Products.Product
    WHERE  ProductID = @ProductID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting Product record with ProductID= '
                   + CONVERT(CHAR(5), @ProductID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 6: If we reach this point, the commands completed successfully
    --         Commit the transaction....
    COMMIT
  END
GO
PRINT '**********************'
PRINT 'Create Supplier SPROCS'
PRINT '**********************'
GO
IF OBJECT_ID('Products.usp_Supplier_Insert',
             'P') IS NOT NULL
  DROP PROC Products.usp_Supplier_Insert
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Products.usp_Supplier_Insert @SupplierName    VARCHAR(50)
                                              ,@ContactName    VARCHAR(50)
                                              ,@ContactTitleID INT
                                              ,@HomePage       VARCHAR(255)
                                              ,@AddedBy        VARCHAR(20)
                                              ,@ModifiedBy     VARCHAR(20)
                                              ,@newSupplierID  INT OUTPUT
                                              ,@newModified    TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO Products.Supplier
                (SupplierName
                 ,ContactName
                 ,ContactTitleID
                 ,HomePage
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @SupplierName
                  ,@ContactName
                  ,@ContactTitleID
                  ,@HomePage
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newSupplierID = SupplierID
      ,@newModified = Modified
    FROM
      Products.Supplier
    WHERE  SupplierID = IDENT_CURRENT('Products.Supplier')
  END
GO
IF OBJECT_ID('Products.usp_Supplier_ReadAll',
             'P') IS NOT NULL
  DROP PROC Products.usp_Supplier_ReadAll
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
--ALTER PROCEDURE [Products].[usp_Supplier_ReadAll] @SupplierName    NVARCHAR(50) = NULL
--                                               ,@ContactTitleID INT = 0
--                                               ,@AddressTypeID  INT = 0
--                                               ,@CountryID      INT = 0
--                                               ,@SortBy         VARCHAR(100) = 'SupplierName'
--                                               ,@PageSize       INT = 999999
--                                               ,@StartRecord    INT = 0
--AS
  --BEGIN
  --  -- SET NOCOUNT ON added to prevent extra result sets from
  --  -- interfering with SELECT statements.
  --  SET NOCOUNT ON

  --  DECLARE @sql NVARCHAR(4000)
  --  DECLARE @where NVARCHAR(4000)
  --  -- Optimize for LIKE condition using NVARCHAR
  --  DECLARE @optSupplierName NVARCHAR(50)

  --  IF @SupplierName IS NOT NULL
  --    BEGIN
  --      SET @optSupplierName = N'' + '''%' + @SupplierName + '%'''
  --    END

  --  SET @sql = ''
  --  SET @where = ''
  --  --
  --  -- Build Select with FROM clause and INNER JOINS
  --  --
  --  SET @sql = @sql + 'SELECT TOP '
  --             + LTRIM(RTRIM(CONVERT(CHAR(10), @PageSize)))
  --  SET @sql = @sql + ' * '
  --  SET @sql = @sql + 'FROM (SELECT '
  --  SET @sql = @sql + '  ROW_NUMBER() '
  --  SET @sql = @sql + '  OVER ( '
  --  SET @sql = @sql + '   ORDER BY ' + @SortBy
  --             + ') AS RecordNumber '
  --  SET @sql = @sql + ' ,s.SupplierID '
  --  SET @sql = @sql + ' ,s.SupplierName '
  --  SET @sql = @sql + ' ,s.ContactName '
  --  SET @sql = @sql + ' ,s.ContactTitleID '
  --  SET @sql = @sql + ' ,ct.ContactTitleName '
  --  SET @sql = @sql + ' ,sa.AddressTypeID '
  --  SET @sql = @sql + ' ,at.AddressTypeName '
  --  SET @sql = @sql + ' ,sa.CountryID '
  --  SET @sql = @sql + ' ,co.CountryName '
  --  SET @sql = @sql + 'FROM Products.Supplier s '
  --  SET @sql = @sql
  --             + 'INNER JOIN Administration.ContactTitle ct ON s.ContactTitleID = ct.ContactTitleID '
  --  SET @sql = @sql
  --             + 'INNER JOIN Addresses.SupplierAddress sa   ON s.SupplierID = sa.SupplierID '
  --  SET @sql = @sql
  --             + 'INNER JOIN Addresses.AddressType at       ON sa.AddressTypeID = at.AddressTypeID '
  --  SET @sql = @sql
  --             + 'INNER JOIN Administration.Country co      ON sa.CountryID = co.CountryID '

  --  --
  --  -- Build WHERE Clause depending on parameters passed in
  --  --

  --  -- WHERE Clause for SupplierName
  --  IF @SupplierName IS NOT NULL
  --    BEGIN
  --      SET @where = 'WHERE '
  --      SET @where = @where + ' ( s.SupplierName LIKE ' + '''%'
  --                   + @SupplierName + '%''' + ' ) '
  --    END

  --  -- WHERE Clause for ContactTitleID.  Check length of WHERE Clause:
  --  --  If > 0 build with AND, Otherwise WHERE
  --  IF ( LEN(@where) > 0 )
  --    BEGIN
  --      IF ( @ContactTitleID > 0 )
  --        BEGIN
  --          SET @where = @where + '  AND ( s.ContactTitleID = '
  --                       + LTRIM(RTRIM(CONVERT(CHAR(10), @ContactTitleID)))
  --                       + ') '
  --        END
  --    END
  --  ELSE
  --    BEGIN
  --      IF ( @ContactTitleID > 0 )
  --        BEGIN
  --          SET @where = 'WHERE '
  --          SET @where = @where + ' ( s.ContactTitleID = '
  --                       + LTRIM(RTRIM(CONVERT(CHAR(10), @ContactTitleID)))
  --                       + ') '
  --        END
  --    END

  --  -- WHERE Clause for AddressTypeID.  Check length of WHERE Clause:
  --  --  If > 0 build with AND, Otherwise WHERE
  --  IF ( LEN(@where) > 0 )
  --    BEGIN
  --      IF ( @AddressTypeID > 0 )
  --        BEGIN
  --          SET @where = @where + '  AND ( at.AddressTypeID = '
  --                       + LTRIM(RTRIM(CONVERT(CHAR(10), @AddressTypeID)))
  --                       + ') '
  --        END
  --    END
  --  ELSE
  --    BEGIN
  --      IF ( @AddressTypeID > 0 )
  --        BEGIN
  --          SET @where = 'WHERE '
  --          SET @where = @where + ' ( at.AddressTypeID = '
  --                       + LTRIM(RTRIM(CONVERT(CHAR(10), @AddressTypeID)))
  --                       + ') '
  --        END
  --    END

  --  -- WHERE Clause for CountryID.  Check length of WHERE Clause:
  --  --  If > 0 build with AND, Otherwise WHERE
  --  IF ( LEN(@where) > 0 )
  --    BEGIN
  --      IF ( @CountryID > 0 )
  --        BEGIN
  --          SET @where = @where + '  AND ( co.CountryID = '
  --                       + LTRIM(RTRIM(CONVERT(CHAR(10), @CountryID)))
  --                       + ') '
  --        END
  --    END
  --  ELSE
  --    BEGIN
  --      IF ( @CountryID > 0 )
  --        BEGIN
  --          SET @where = 'WHERE '
  --          SET @where = @where + ' ( co.CountryID = '
  --                       + LTRIM(RTRIM(CONVERT(CHAR(10), @CountryID)))
  --                       + ') '
  --        END
  --    END

  --  -- If length of @where > 0, concatenate @where and @sql
  --  IF ( LEN(@where) > 0 )
  --    BEGIN
  --      SET @sql = @sql + @where
  --    END

  --  SET @sql = @sql + ') AS SupplierRecords '
  --  SET @sql = @sql + 'WHERE '
  --  SET @sql = @sql + 'RecordNumber > '
  --             + LTRIM(RTRIM(CONVERT(CHAR(10), @StartRecord)))
  --             + ' '
  --  PRINT @sql

  --  EXEC sp_executesql
  --    @sql
  --END
CREATE PROCEDURE [Products].[usp_Supplier_ReadAll]
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    WITH SupplierCTE
         AS (SELECT
               s.SupplierID
               ,s.SupplierName
               ,s.ContactTitleID
               ,ct.ContactTitleName
             FROM
               Products.Supplier s
               INNER JOIN Administration.ContactTitle ct
                       ON s.ContactTitleID = ct.ContactTitleID),

         AddressCTE
         AS (SELECT
               ca.SupplierAddressID
               ,ca.SupplierID
               ,ca.AddressTypeID
               ,at.AddressTypeName
               ,ca.CountryID
               ,co.CountryName
             FROM
               Addresses.SupplierAddress ca
               INNER JOIN Addresses.AddressType at
                       ON ca.AddressTypeID = at.AddressTypeID
               INNER JOIN Administration.Country co
                       ON ca.CountryID = co.CountryID),

         CommunicationCTE
         AS (SELECT
               cc.SupplierCommunicationID
               ,cc.SupplierID
               ,cc.CommunicationTypeID
               ,ct.CommunicationTypeName
               ,cc.CommunicationOrderID
               ,co.CommunicationOrderName
               ,cc.Communication
             FROM
               Communications.SupplierCommunication cc
               INNER JOIN Communications.CommunicationType ct
                       ON cc.CommunicationTypeID = ct.CommunicationTypeID
               INNER JOIN Communications.CommunicationOrder co
                       ON cc.CommunicationOrderID = co.CommunicationOrderID)

    SELECT
      cuCTE.SupplierID
      ,cuCTE.SupplierName
      ,cuCTE.ContactTitleID
      ,cuCTE.ContactTitleName
      ,aCTE.SupplierAddressID
      ,aCTE.AddressTypeID
      ,aCTE.AddressTypeName
      ,aCTE.CountryID
      ,aCTE.CountryName
      ,coCTE.SupplierCommunicationID
      ,coCTE.CommunicationTypeID
      ,coCTE.CommunicationTypeName
      ,coCTE.CommunicationOrderID
      ,coCTE.CommunicationOrderName
      ,coCTE.Communication
    FROM
      SupplierCTE cuCTE
      INNER JOIN AddressCTE aCTE
              ON cuCTE.SupplierID = aCTE.SupplierID
      INNER JOIN CommunicationCTE coCTE
              ON cuCTE.SupplierID = coCTE.SupplierID
    ORDER  BY cuCTE.SupplierName
  END 
GO
IF OBJECT_ID('Products.usp_Supplier_ReadById',
             'P') IS NOT NULL
  DROP PROC Products.usp_Supplier_ReadById
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Products.usp_Supplier_ReadById @SupplierID INT
AS
  BEGIN
    SET NOCOUNT ON
    SELECT
      SupplierID
      ,SupplierName
      ,ContactName
      ,ContactTitleID
      ,HomePage
      ,AddedBy
      ,AddedDate
      ,ModifiedBy
      ,ModifiedDate
      ,Modified
    FROM
      Products.Supplier
    WHERE  SupplierID = @SupplierID
    SELECT
      sa.SupplierID
      ,at.AddressTypeID
      ,sa.AddressLine1
      ,sa.AddressLine2
      ,sa.City
      ,sa.Region
      ,sa.PostalCode
      ,sa.CountryID
      ,sa.AddedBy
      ,sa.AddedDate
      ,sa.ModifiedBy
      ,sa.ModifiedDate
      ,sa.Modified
    FROM
      Addresses.SupplierAddress sa
      INNER JOIN Addresses.AddressType at
              ON sa.AddressTypeID = at.AddressTypeID
    WHERE  sa.SupplierID = @SupplierID

    SELECT
      comm.SupplierID
      ,comm.CommunicationTypeID
      ,comm.CommunicationOrderID
      ,comm.Communication
    FROM
      Communications.SupplierCommunication comm
    WHERE  comm.SupplierID = @SupplierID
  END
GO
IF OBJECT_ID('Products.usp_Supplier_Update',
             'P') IS NOT NULL
  DROP PROC Products.usp_Supplier_Update
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Products.usp_Supplier_Update @SupplierID      INT
                                              ,@SupplierName   VARCHAR(50)
                                              ,@ContactName    VARCHAR(50)
                                              ,@ContactTitleID INT
                                              ,@HomePage       VARCHAR(255)
                                              ,@ModifiedBy     VARCHAR(20)
                                              ,@newModified    TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE Supplier
    SET    SupplierName = @SupplierName
           ,ContactName = @ContactName
           ,ContactTitleID = @ContactTitleID
           ,HomePage = @HomePage
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    FROM   Products.Supplier
    WHERE  SupplierID = @SupplierID

    SELECT
      @newModified = Modified
    FROM
      Products.Supplier
    WHERE  SupplierID = @SupplierID
  END
GO
IF OBJECT_ID('Products.usp_Supplier_Delete',
             'P') IS NOT NULL
  DROP PROC Products.usp_Supplier_Delete
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- http://www.4guysfromrolla.com/webtech/080305-1.shtml
-- =============================================
CREATE PROCEDURE Products.usp_Supplier_Delete @SupplierID INT
AS
  BEGIN
    DECLARE @Msg VARCHAR(500)
    -- STEP 1: Start the transaction
    BEGIN TRANSACTION
    -- STEP 2 & 3: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Addresses.SupplierAddress
    WHERE  SupplierID = @SupplierID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting SupplierAddress record with SupplierID= '
                   + CONVERT(CHAR(5), @SupplierID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 4 & 5: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Communications.SupplierCommunication
    WHERE  SupplierID = @SupplierID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting SupplierCommunication record with SupplierID= '
                   + CONVERT(CHAR(5), @SupplierID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 6 & 7: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Products.Supplier
    WHERE  SupplierID = @SupplierID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting Supplier record with SupplierID= '
                   + CONVERT(CHAR(5), @SupplierID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 8: If we reach this point, the commands completed successfully
    --         Commit the transaction....
    COMMIT
  END
GO
PRINT '*******************'
PRINT 'Create Sales SPROCS'
PRINT '*******************'
GO
PRINT '*********************'
PRINT 'Create Invoice SPROCS'
PRINT '*********************'
GO
IF OBJECT_ID('Sales.usp_Invoice_Insert',
             'P') IS NOT NULL
  DROP PROC Sales.usp_Invoice_Insert
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/20/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Sales.usp_Invoice_Insert @CustomerID        INT
                                          ,@EmployeeID       INT
                                          ,@InvoiceDate      DATETIME
                                          ,@RequiredDate     DATETIME
                                          ,@ShipperID        INT
                                          ,@Freight          MONEY
                                          ,@ShipName         VARCHAR(50)
                                          ,@ShipAddressLine1 VARCHAR(50)
                                          ,@ShipAddressLine2 VARCHAR(50)
                                          ,@ShipCity         VARCHAR(50)
                                          ,@ShipRegion       VARCHAR(50)
                                          ,@ShipPostalCode   VARCHAR(20)
                                          ,@CountryID        INT
                                          ,@AddedBy          VARCHAR(20)
                                          ,@ModifiedBy       VARCHAR(20)
                                          ,@newInvoiceID     INT OUTPUT
                                          ,@newModified      TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO Sales.Invoice
                (CustomerID
                 ,EmployeeID
                 ,InvoiceDate
                 ,RequiredDate
                 ,ShipperID
                 ,Freight
                 ,ShipName
                 ,ShipAddressLine1
                 ,ShipAddressLine2
                 ,ShipCity
                 ,ShipRegion
                 ,ShipPostalCode
                 ,CountryID
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @CustomerID
                  ,@EmployeeID
                  ,@InvoiceDate
                  ,@RequiredDate
                  ,@ShipperID
                  ,@Freight
                  ,@ShipName
                  ,@ShipAddressLine1
                  ,@ShipAddressLine2
                  ,@ShipCity
                  ,@ShipRegion
                  ,@ShipPostalCode
                  ,@CountryID
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newInvoiceID = InvoiceID
      ,@newModified = Modified
    FROM
      Sales.Invoice
    WHERE  InvoiceID = IDENT_CURRENT('Sales.Invoice')
  END
GO
IF OBJECT_ID('Sales.usp_Invoice_ReadAll',
             'P') IS NOT NULL
  DROP PROC Sales.usp_Invoice_ReadAll
GO
CREATE PROCEDURE Sales.usp_Invoice_ReadAll @CustomerID         INT = 0
                                           ,@EmployeeID        INT = 0
                                           ,@StartInvoiceDate  DATETIME = NULL
                                           ,@EndInvoiceDate    DATETIME = NULL
                                           ,@StartRequiredDate DATETIME = NULL
                                           ,@EndRequiredDate   DATETIME = NULL
                                           ,@StartShippedDate  DATETIME = NULL
                                           ,@EndShippedDate    DATETIME = NULL
                                           ,@ShipperID         INT = 0
                                           ,@CountryID         INT = 0
                                           ,@SortBy            VARCHAR(100) = 'InvoiceDate DESC'
                                           ,@PageSize          INT = 999999
                                           ,@StartRecord       INT = 0
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    DECLARE @sql NVARCHAR(4000)
    DECLARE @where NVARCHAR(4000)

    SET @sql = ''
    SET @where = ''
    --
    -- Build Select with FROM clause and INNER JOINS
    --
    SET @sql = @sql + 'SELECT TOP '
               + LTRIM(RTRIM(CONVERT(CHAR(10), @PageSize)))
               + ' '
    SET @sql = @sql + ' * '
    SET @sql = @sql + 'FROM (SELECT '
    SET @sql = @sql + '  ROW_NUMBER() '
    SET @sql = @sql + '  OVER ( '
    SET @sql = @sql + '   ORDER BY ' + @SortBy
               + ') AS RecordNumber '
    SET @sql = @sql + ' ,i.InvoiceID '
    SET @sql = @sql + ' ,i.CustomerID '
    SET @sql = @sql + ' ,c.CustomerName '
    SET @sql = @sql + ' ,i.EmployeeID '
    SET @sql = @sql + ' ,e.EmployeeName '
    SET @sql = @sql + ' ,i.InvoiceDate '
    SET @sql = @sql + ' ,i.RequiredDate '
    SET @sql = @sql + ' ,i.ShippedDate '
    SET @sql = @sql + ' ,i.ShipperID '
    SET @sql = @sql + ' ,s.ShipperName '
    SET @sql = @sql + ' ,i.CountryID '
    SET @sql = @sql + ' ,co.CountryName '
    SET @sql = @sql
               + ' ,SUM(ii.Total)           AS Total '
    SET @sql = @sql
               + ' ,SUM(ii.TotalDiscount)   AS TotalDiscount '
    SET @sql = @sql
               + ' ,SUM(ii.DiscountedTotal) AS InvoiceTotal '
    SET @sql = @sql + 'FROM Sales.Invoice i '
    SET @sql = @sql
               + 'INNER JOIN Sales.InvoiceItem ii               ON i.InvoiceID = ii.InvoiceID '
    SET @sql = @sql
               + 'INNER JOIN Customers.Customer c               ON i.CustomerID = c.CustomerID '
    SET @sql = @sql
               + 'INNER JOIN HumanResources.vw_EmployeeNameLF e ON i.EmployeeID = e.EmployeeID '
    SET @sql = @sql
               + 'INNER JOIN Sales.Shipper s                    ON i.ShipperID = s.ShipperID '
    SET @sql = @sql
               + 'INNER JOIN Administration.Country co          ON i.CountryID = co.CountryID '

    --
    -- Build WHERE Clause depending on parameters passed in
    --

    -- WHERE Clause for CustomerID
    IF ( @CustomerID > 0 )
      BEGIN
        SET @where = 'WHERE '
        SET @where = @where + ' ( i.CustomerID = '
                     + LTRIM(RTRIM(CONVERT(CHAR(10), @CustomerID)))
                     + ') '
      END

    -- WHERE Clause for EmployeeID.  Check length of WHERE Clause:
    --  If > 0 build with AND, Otherwise WHERE
    IF ( LEN(@where) > 0 )
      BEGIN
        IF ( @EmployeeID > 0 )
          BEGIN
            SET @where = @where + '  AND ( i.EmployeeID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @EmployeeID)))
                         + ') '
          END
      END
    ELSE
      BEGIN
        IF ( @EmployeeID > 0 )
          BEGIN
            SET @where = 'WHERE '
            SET @where = @where + ' ( i.EmployeeID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @EmployeeID)))
                         + ') '
          END
      END

    -- WHERE Clause for InvoiceDate.  Check length of WHERE Clause:
    --  If > 0 build with AND, Otherwise WHERE
    IF ( LEN(@where) > 0 )
      BEGIN
        IF ( @StartInvoiceDate IS NOT NULL
             AND @EndInvoiceDate IS NOT NULL )
          BEGIN
            SET @where = @where + '  AND (i.InvoiceDate BETWEEN '''
                         + LTRIM(RTRIM(CONVERT(CHAR(12), @StartInvoiceDate, 101)))
                         + ''' AND '''
                         + LTRIM(RTRIM(CONVERT(CHAR(12), @EndInvoiceDate, 101)))
                         + ''') '
          END
      END
    ELSE
      BEGIN
        SET @where = 'WHERE '
        SET @where = @where + ' (i.InvoiceDate BETWEEN '''
                     + LTRIM(RTRIM(CONVERT(CHAR(12), @StartInvoiceDate, 101)))
                     + ''' AND '''
                     + LTRIM(RTRIM(CONVERT(CHAR(12), @EndInvoiceDate, 101)))
                     + ''') '
      END

    -- WHERE Clause for RequiredDate.  Check length of WHERE Clause:
    --  If > 0 build with AND, Otherwise WHERE
    IF ( LEN(@where) > 0 )
      BEGIN
        IF ( @StartRequiredDate IS NOT NULL
             AND @EndRequiredDate IS NOT NULL )
          BEGIN
            SET @where = @where + '  AND (i.RequiredDate BETWEEN '''
                         + LTRIM(RTRIM(CONVERT(CHAR(12), @StartRequiredDate, 101)))
                         + ''' AND '''
                         + LTRIM(RTRIM(CONVERT(CHAR(12), @EndRequiredDate, 101)))
                         + ''') '
          END
      END
    ELSE
      BEGIN
        SET @where = 'WHERE '
        SET @where = @where + ' (i.RequiredDate BETWEEN '''
                     + LTRIM(RTRIM(CONVERT(CHAR(12), @StartRequiredDate, 101)))
                     + ''' AND '''
                     + LTRIM(RTRIM(CONVERT(CHAR(12), @EndRequiredDate, 101)))
                     + ''') '
      END

    -- WHERE Clause for ShippedDate.  Check length of WHERE Clause:
    --  If > 0 build with AND, Otherwise WHERE
    IF ( LEN(@where) > 0 )
      BEGIN
        IF ( @StartShippedDate IS NOT NULL
             AND @EndShippedDate IS NOT NULL )
          BEGIN
            SET @where = @where + '  AND (i.ShippedDate BETWEEN '''
                         + LTRIM(RTRIM(CONVERT(CHAR(12), @StartShippedDate, 101)))
                         + ''' AND '''
                         + LTRIM(RTRIM(CONVERT(CHAR(12), @EndShippedDate, 101)))
                         + ''') '
          END
      END
    ELSE
      BEGIN
        SET @where = 'WHERE '
        SET @where = @where + ' (i.ShippedDate BETWEEN '''
                     + LTRIM(RTRIM(CONVERT(CHAR(12), @StartShippedDate, 101)))
                     + ''' AND '''
                     + LTRIM(RTRIM(CONVERT(CHAR(12), @EndShippedDate, 101)))
                     + ''') '
      END

    -- WHERE Clause for ShipperID.  Check length of WHERE Clause:
    --  If > 0 build with AND, Otherwise WHERE
    IF ( LEN(@where) > 0 )
      BEGIN
        IF ( @ShipperID > 0 )
          BEGIN
            SET @where = @where + '  AND ( i.ShipperID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @ShipperID)))
                         + ') '
          END
      END
    ELSE
      BEGIN
        IF ( @ShipperID > 0 )
          BEGIN
            SET @where = 'WHERE '
            SET @where = @where + ' ( i.ShipperID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @ShipperID)))
                         + ') '
          END
      END

    -- WHERE Clause for CountryID.  Check length of WHERE Clause:
    --  If > 0 build with AND, Otherwise WHERE
    IF ( LEN(@where) > 0 )
      BEGIN
        IF ( @CountryID > 0 )
          BEGIN
            SET @where = @where + '  AND ( i.CountryID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @CountryID)))
                         + ') '
          END
      END
    ELSE
      BEGIN
        IF ( @CountryID > 0 )
          BEGIN
            SET @where = 'WHERE '
            SET @where = @where + ' ( i.CountryID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @CountryID)))
                         + ') '
          END
      END

    -- If length of @where > 0, concatenate @where and @sql
    IF ( LEN(@where) > 0 )
      BEGIN
        SET @sql = @sql + @where
      END

    -- Build GROUP BY Clause
    SET @sql = @sql + ' GROUP BY '
    SET @sql = @sql + '  i.InvoiceID '
    SET @sql = @sql + ' ,i.CustomerID '
    SET @sql = @sql + ' ,c.CustomerName '
    SET @sql = @sql + ' ,i.EmployeeID '
    SET @sql = @sql + ' ,e.EmployeeName '
    SET @sql = @sql + ' ,i.InvoiceDate '
    SET @sql = @sql + ' ,i.RequiredDate '
    SET @sql = @sql + ' ,i.ShippedDate '
    SET @sql = @sql + ' ,i.ShipperID '
    SET @sql = @sql + ' ,s.ShipperName '
    SET @sql = @sql + ' ,i.CountryID '
    SET @sql = @sql + ' ,co.CountryName '
    -- Finish off sql statement
    SET @sql = @sql + ') AS InvoiceRecords '
    SET @sql = @sql + 'WHERE '
    SET @sql = @sql + 'RecordNumber > '
               + LTRIM(RTRIM(CONVERT(CHAR(10), @StartRecord)))
               + ' '
    PRINT @sql

    EXEC sp_executesql
      @sql
  END
GO
IF OBJECT_ID('Sales.usp_Invoice_ReadById',
             'P') IS NOT NULL
  DROP PROC Sales.usp_Invoice_ReadById
GO
CREATE PROCEDURE Sales.usp_Invoice_ReadById @InvoiceID INT
AS
  BEGIN
    SELECT
      i.InvoiceID
      ,i.CustomerID
      ,i.EmployeeID
      ,i.InvoiceDate
      ,i.RequiredDate
      ,i.ShippedDate
      ,i.ShipperID
      ,i.Freight
      ,i.ShipName
      ,i.ShipAddressLine1
      ,i.ShipAddressLine2
      ,i.ShipCity
      ,i.ShipRegion
      ,i.ShipPostalCode
      ,i.CountryID
      ,i.AddedBy
      ,i.AddedDate
      ,i.ModifiedBy
      ,i.ModifiedDate
      ,i.Modified
    FROM
      Sales.Invoice i
    WHERE  i.InvoiceID = @InvoiceID
    SELECT
      ii.InvoiceItemID
      ,ii.InvoiceID
      ,ii.ProductID
      ,ii.UnitPrice
      ,ii.Quantity
      ,ii.Discount
      ,ii.Total
      ,ii.TotalDiscount
      ,ii.DiscountedTotal
      ,ii.AddedBy
      ,ii.AddedDate
      ,ii.ModifiedBy
      ,ii.ModifiedDate
      ,ii.Modified
    FROM
      Sales.InvoiceItem ii
    WHERE  ii.InvoiceID = @InvoiceID
    ORDER  BY ii.InvoiceItemID
  END
GO
IF OBJECT_ID('Sales.usp_Invoice_Update',
             'P') IS NOT NULL
  DROP PROC Sales.usp_Invoice_Update
GO
CREATE PROCEDURE Sales.usp_Invoice_Update @InvoiceID         INT
                                          ,@CustomerID       INT
                                          ,@EmployeeID       INT
                                          ,@InvoiceDate      DATETIME
                                          ,@RequiredDate     DATETIME
                                          ,@ShippedDate      DATETIME
                                          ,@ShipperID        INT
                                          ,@Freight          MONEY
                                          ,@ShipName         VARCHAR(50)
                                          ,@ShipAddressLine1 VARCHAR(50)
                                          ,@ShipAddressLine2 VARCHAR(50)
                                          ,@ShipCity         VARCHAR(50)
                                          ,@ShipRegion       VARCHAR (50)
                                          ,@ShipPostalCode   VARCHAR(20)
                                          ,@CountryID        INT
                                          ,@ModifiedBy       VARCHAR(20)
                                          ,@newModified      TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE Invoice
    SET    CustomerID = @CustomerID
           ,EmployeeID = @EmployeeID
           ,InvoiceDate = @InvoiceDate
           ,RequiredDate = @RequiredDate
           ,ShippedDate = @ShippedDate
           ,ShipperID = @ShipperID
           ,Freight = @Freight
           ,ShipName = @ShipName
           ,ShipAddressLine1 = @ShipAddressLine1
           ,ShipAddressLine2 = @ShipAddressLine2
           ,ShipCity = @ShipCity
           ,ShipRegion = @ShipRegion
           ,ShipPostalCode = @ShipPostalCode
           ,CountryID = @CountryID
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    FROM   Sales.Invoice
    WHERE  InvoiceID = @InvoiceID
    SELECT
      @newModified = Modified
    FROM
      Sales.Invoice
    WHERE  InvoiceID = @InvoiceID
  END
GO
IF OBJECT_ID('Sales.usp_Invoice_Delete',
             'P') IS NOT NULL
  DROP PROC Sales.usp_Invoice_Delete
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- http://www.4guysfromrolla.com/webtech/080305-1.shtml
-- =============================================
CREATE PROCEDURE Sales.usp_Invoice_Delete @InvoiceID INT
AS
  BEGIN
    DECLARE @Msg VARCHAR(500)
    -- STEP 1: Start the transaction
    BEGIN TRANSACTION
    -- STEP 2 & 3: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Sales.InvoiceItem
    WHERE  InvoiceID = @InvoiceID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting InvoiceItem record with InvoiceID= '
                   + CONVERT(CHAR(5), @InvoiceID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 4 & 5: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Sales.Invoice
    WHERE  InvoiceID = @InvoiceID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting Invoice record with InvoiceID= '
                   + CONVERT(CHAR(5), @InvoiceID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 8: If we reach this point, the commands completed successfully
    --         Commit the transaction....
    COMMIT
  END
GO

PRINT '*************************'
PRINT 'Create InvoiceItem SPROCS'
PRINT '*************************'
GO
IF OBJECT_ID('Sales.usp_InvoiceItem_Insert',
             'P') IS NOT NULL
  DROP PROC Sales.usp_InvoiceItem_Insert
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/20/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Sales.usp_InvoiceItem_Insert @InvoiceID         INT
                                              ,@ProductID        INT
                                              ,@UnitPrice        MONEY
                                              ,@Quantity         INT
                                              ,@Discount         DECIMAL(18, 2)
                                              ,@AddedBy          VARCHAR(20)
                                              ,@ModifiedBy       VARCHAR(20)
                                              ,@newInvoiceItemID INT OUTPUT
                                              ,@newModified      TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO Sales.InvoiceItem
                (InvoiceID
                 ,ProductID
                 ,UnitPrice
                 ,Quantity
                 ,Discount
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @InvoiceID
                  ,@ProductID
                  ,@UnitPrice
                  ,@Quantity
                  ,@Discount
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newInvoiceItemID = InvoiceItemID
      ,@newModified = Modified
    FROM
      Sales.InvoiceItem
    WHERE  InvoiceID = IDENT_CURRENT('Sales.InvoiceItem')
  END
GO
IF OBJECT_ID('Sales.usp_InvoiceItem_ReadAll',
             'P') IS NOT NULL
  DROP PROC Sales.usp_InvoiceItem_ReadAll
GO
CREATE PROCEDURE Sales.usp_InvoiceItem_ReadAll @InvoiceID         INT = 0
                                               ,@ProductID        INT = 0
                                               ,@CustomerID       INT = 0
                                               ,@EmployeeID       INT = 0
                                               ,@StartInvoiceDate DATETIME = NULL
                                               ,@EndInvoiceDate   DATETIME = NULL
                                               ,@SortBy           VARCHAR(100) = 'InvoiceItemID DESC'
                                               ,@PageSize         INT = 999999
                                               ,@StartRecord      INT = 0
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    DECLARE @sql NVARCHAR(4000)
    DECLARE @where NVARCHAR(4000)

    SET @sql = ''
    SET @where = ''
    --
    -- Build Select with FROM clause and INNER JOINS
    --
    SET @sql = @sql + 'SELECT TOP '
               + LTRIM(RTRIM(CONVERT(CHAR(10), @PageSize)))
               + ' '
    SET @sql = @sql + ' * '
    SET @sql = @sql + 'FROM (SELECT '
    SET @sql = @sql + '  ROW_NUMBER() '
    SET @sql = @sql + '  OVER ( '
    SET @sql = @sql + '   ORDER BY ' + @SortBy
               + ') AS RecordNumber '
    SET @sql = @sql + ' ,ii.InvoiceItemID '
    SET @sql = @sql + ' ,ii.InvoiceID '
    SET @sql = @sql + ' ,c.CustomerID '
    SET @sql = @sql + ' ,c.CustomerName '
    SET @sql = @sql + ' ,e.EmployeeID '
    SET @sql = @sql + ' ,e.EmployeeName '
    SET @sql = @sql + ' ,i.InvoiceDate '
    SET @sql = @sql + ' ,ii.ProductID '
    SET @sql = @sql + ' ,p.ProductName '
    SET @sql = @sql + ' ,ii.UnitPrice '
    SET @sql = @sql + ' ,ii.Quantity '
    SET @sql = @sql + ' ,ii.Discount '
    SET @sql = @sql + ' ,ii.Total '
    SET @sql = @sql + ' ,ii.TotalDiscount '
    SET @sql = @sql + ' ,ii.DiscountedTotal '
    SET @sql = @sql + 'FROM Sales.InvoiceItem ii '
    SET @sql = @sql
               + 'INNER JOIN Sales.Invoice i                    ON ii.InvoiceID = i.InvoiceID '
    SET @sql = @sql
               + 'INNER JOIN Products.Product p                 ON ii.ProductID = p.ProductID '
    SET @sql = @sql
               + 'INNER JOIN Customers.Customer c               ON i.CustomerID = c.CustomerID '
    SET @sql = @sql
               + 'INNER JOIN HumanResources.vw_EmployeeNameLF e ON i.EmployeeID = e.EmployeeID '

    --
    -- Build WHERE Clause depending on parameters passed in
    --

    -- WHERE Clause for InvoiceID
    IF @InvoiceID IS NOT NULL
      BEGIN
        SET @where = 'WHERE '
        SET @where = @where + ' ( ii.InvoiceID = '
                     + LTRIM(RTRIM(CONVERT(CHAR(10), @InvoiceID)))
                     + ') '
      END

    -- WHERE Clause for ProductID.  Check length of WHERE Clause:
    --  If > 0 build with AND, Otherwise WHERE
    IF ( LEN(@where) > 0 )
      BEGIN
        IF ( @ProductID > 0 )
          BEGIN
            SET @where = @where + '  AND ( ii.ProductID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @ProductID)))
                         + ') '
          END
      END
    ELSE
      BEGIN
        IF ( @ProductID > 0 )
          BEGIN
            SET @where = 'WHERE '
            SET @where = @where + ' ( ii.ProductID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @ProductID)))
                         + ') '
          END
      END

    -- WHERE Clause for CustomerID.  Check length of WHERE Clause:
    --  If > 0 build with AND, Otherwise WHERE
    IF ( LEN(@where) > 0 )
      BEGIN
        IF ( @CustomerID > 0 )
          BEGIN
            SET @where = @where + '  AND ( c.CustomerID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @CustomerID)))
                         + ') '
          END
      END
    ELSE
      BEGIN
        IF ( @CustomerID > 0 )
          BEGIN
            SET @where = 'WHERE '
            SET @where = @where + ' ( c.CustomerID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @CustomerID)))
                         + ') '
          END
      END

    -- WHERE Clause for EmployeeID.  Check length of WHERE Clause:
    --  If > 0 build with AND, Otherwise WHERE
    IF ( LEN(@where) > 0 )
      BEGIN
        IF ( @EmployeeID > 0 )
          BEGIN
            SET @where = @where + '  AND ( e.EmployeeID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @EmployeeID)))
                         + ') '
          END
      END
    ELSE
      BEGIN
        IF ( @EmployeeID > 0 )
          BEGIN
            SET @where = 'WHERE '
            SET @where = @where + ' ( e.EmployeeID = '
                         + LTRIM(RTRIM(CONVERT(CHAR(10), @EmployeeID)))
                         + ') '
          END
      END

    -- WHERE Clause for InvoiceDate.  Check length of WHERE Clause:
    --  If > 0 build with AND, Otherwise WHERE
    IF ( LEN(@where) > 0 )
      BEGIN
        IF ( @StartInvoiceDate IS NOT NULL
             AND @EndInvoiceDate IS NOT NULL )
          SET @where = @where + '  AND (i.InvoiceDate BETWEEN '''
                       + LTRIM(RTRIM(CONVERT(CHAR(12), @StartInvoiceDate, 101)))
                       + ''' AND '''
                       + LTRIM(RTRIM(CONVERT(CHAR(12), @EndInvoiceDate, 101)))
                       + ''') '
      END
    ELSE
      BEGIN
        SET @where = 'WHERE '
        SET @where = @where + ' (i.InvoiceDate BETWEEN '''
                     + LTRIM(RTRIM(CONVERT(CHAR(12), @StartInvoiceDate, 101)))
                     + ''' AND '''
                     + LTRIM(RTRIM(CONVERT(CHAR(12), @EndInvoiceDate, 101)))
                     + ''') '
      END

    -- If length of @where > 0, concatenate @where and @sql
    IF ( LEN(@where) > 0 )
      BEGIN
        SET @sql = @sql + @where
      END

    SET @sql = @sql + ') AS InvoiceRecords '
    SET @sql = @sql + 'WHERE '
    SET @sql = @sql + 'RecordNumber > '
               + LTRIM(RTRIM(CONVERT(CHAR(10), @StartRecord)))
               + ' '
    PRINT @sql

    EXEC sp_executesql
      @sql
  END
GO
IF OBJECT_ID('Sales.usp_InvoiceItem_ReadById',
             'P') IS NOT NULL
  DROP PROC Sales.usp_InvoiceItem_ReadById
GO
CREATE PROCEDURE Sales.usp_InvoiceItem_ReadById @InvoiceItemID INT
AS
  BEGIN
    SELECT
      ii.InvoiceItemID
      ,ii.InvoiceID
      ,ii.ProductID
      ,ii.UnitPrice
      ,ii.Quantity
      ,ii.Discount
      ,ii.Total
      ,ii.TotalDiscount
      ,ii.DiscountedTotal
      ,ii.AddedBy
      ,ii.AddedDate
      ,ii.ModifiedBy
      ,ii.ModifiedDate
      ,ii.Modified
    FROM
      Sales.InvoiceItem ii
    WHERE  ii.InvoiceItemID = @InvoiceItemID
  END
GO
IF OBJECT_ID('Sales.usp_InvoiceItem_Update',
             'P') IS NOT NULL
  DROP PROC Sales.usp_InvoiceItem_Update
GO
CREATE PROCEDURE Sales.usp_InvoiceItem_Update @InvoiceItemID     INT
                                              ,@InvoiceID        INT
                                              ,@ProductID        INT
                                              ,@UnitPrice        MONEY
                                              ,@Quantity         INT
                                              ,@Discount         DECIMAL(18, 2)
                                              ,@ModifiedBy       VARCHAR(20)
                                              ,@newInvoiceItemID INT OUTPUT
                                              ,@newModified      TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE InvoiceItem
    SET    InvoiceID = @InvoiceID
           ,ProductID = @ProductID
           ,UnitPrice = @UnitPrice
           ,Quantity = @Quantity
           ,Discount = @Discount
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    FROM   Sales.InvoiceItem
    WHERE  InvoiceItemID = @InvoiceItemID
    SELECT
      @newModified = Modified
    FROM
      Sales.InvoiceItem
    WHERE  InvoiceItemID = @InvoiceItemID
  END
GO
IF OBJECT_ID('Sales.usp_InvoiceItem_Delete',
             'P') IS NOT NULL
  DROP PROC Sales.usp_InvoiceItem_Delete
GO
-- =============================================
--      Author:	KSafford
-- Create date:	08/20/2014
-- Description:	
--   Revisions:	
-- http://www.4guysfromrolla.com/webtech/080305-1.shtml
-- =============================================
CREATE PROCEDURE Sales.usp_InvoiceItem_Delete @InvoiceItemID INT
AS
  BEGIN
    DELETE Sales.InvoiceItem
    WHERE  InvoiceItemID = @InvoiceItemID
  END
GO
IF OBJECT_ID('Addresses.usp_CustomerAddress_Insert',
             'P') IS NOT NULL
  DROP PROC Addresses.usp_CustomerAddress_Insert
GO
CREATE PROCEDURE Addresses.usp_CustomerAddress_Insert @CustomerID            INT
                                                      ,@AddressTypeID        INT
                                                      ,@AddressLine1         VARCHAR(50)
                                                      ,@AddressLine2         VARCHAR(50)
                                                      ,@City                 VARCHAR(50)
                                                      ,@Region               VARCHAR(50)
                                                      ,@PostalCode           VARCHAR(20)
                                                      ,@CountryID            INT
                                                      ,@AddedBy              VARCHAR(20)
                                                      ,@ModifiedBy           VARCHAR(20)
                                                      ,@newCustomerAddressID INT OUTPUT
                                                      ,@newModified          TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO Addresses.CustomerAddress
                (CustomerID
                 ,AddressTypeID
                 ,AddressLine1
                 ,AddressLine2
                 ,City
                 ,Region
                 ,PostalCode
                 ,CountryID
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @CustomerID
                  ,@AddressTypeID
                  ,@AddressLine1
                  ,@AddressLine2
                  ,@City
                  ,@Region
                  ,@PostalCode
                  ,@CountryID
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newCustomerAddressID = CustomerAddressID
      ,@newModified = Modified
    FROM
      Addresses.CustomerAddress
    WHERE  CustomerAddressID = IDENT_CURRENT('Addresses.CustomerAddress')
  END
GO

IF OBJECT_ID('Communications.usp_CustomerCommunication_Insert',
             'P') IS NOT NULL
  DROP PROC Communications.usp_CustomerCommunication_Insert
GO
CREATE PROCEDURE Communications.usp_CustomerCommunication_Insert @CustomerID                  INT
                                                                 ,@CommunicationTypeID        INT
                                                                 ,@CommunicationOrderID       INT
                                                                 ,@Communication              VARCHAR(100)
                                                                 ,@AddedBy                    VARCHAR(20)
                                                                 ,@ModifiedBy                 VARCHAR(20)
                                                                 ,@newCustomerCommunicationID INT OUTPUT
                                                                 ,@newModified                TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO [Communications].[CustomerCommunication]
                (CustomerID
                 ,CommunicationTypeID
                 ,CommunicationOrderID
                 ,Communication
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @CustomerID
                  ,@CommunicationTypeID
                  ,@CommunicationOrderID
                  ,@Communication
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newCustomerCommunicationID = CustomerCommunicationID
      ,@newModified = Modified
    FROM
      Communications.CustomerCommunication
    WHERE  CustomerCommunicationID = IDENT_CURRENT('Communications.CustomerCommunication')
  END
GO

IF OBJECT_ID('Addresses.usp_CustomerAddress_Update',
             'P') IS NOT NULL
  DROP PROC Addresses.usp_CustomerAddress_Update
GO

CREATE PROCEDURE Addresses.usp_CustomerAddress_Update @CustomerAddressID INT
                                                      ,@CustomerID       INT
                                                      ,@AddressTypeID    INT
                                                      ,@AddressLine1     VARCHAR(50)
                                                      ,@AddressLine2     VARCHAR(50)
                                                      ,@City             VARCHAR(50)
                                                      ,@Region           VARCHAR(50)
                                                      ,@PostalCode       VARCHAR(20)
                                                      ,@CountryID        INT
                                                      ,@ModifiedBy       VARCHAR(20)
                                                      ,@newModified      TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE Addresses.CustomerAddress
    SET    CustomerID = @CustomerID
           ,AddressTypeID = AddressTypeID
           ,AddressLine1 = @AddressLine1
           ,AddressLine2 = @AddressLine2
           ,City = @City
           ,Region = @Region
           ,PostalCode = @PostalCode
           ,CountryID = @CountryID
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    WHERE  CustomerAddressID = @CustomerAddressID

    SELECT
      @newModified = Modified
    FROM
      Addresses.CustomerAddress
    WHERE  CustomerAddressID = @CustomerAddressID
  END
GO

IF OBJECT_ID('Communications.usp_CustomerCommunication_Update',
             'P') IS NOT NULL
  DROP PROC Communications.usp_CustomerCommunication_Update
GO

CREATE PROCEDURE Communications.usp_CustomerCommunication_Update @CustomerCommunicationID INT
                                                                 ,@CustomerID             INT
                                                                 ,@CommunicationTypeID    INT
                                                                 ,@CommunicationOrderID   INT
                                                                 ,@Communication          VARCHAR(100)
                                                                 ,@ModifiedBy             VARCHAR(20)
                                                                 ,@newModified            TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE [Communications].[CustomerCommunication]
    SET    [CustomerID] = @CustomerID
           ,[CommunicationTypeID] = CommunicationTypeID
           ,[CommunicationOrderID] = CommunicationOrderID
           ,[Communication] = @Communication
           ,[ModifiedBy] = @ModifiedBy
           ,[ModifiedDate] = CURRENT_TIMESTAMP
    WHERE  CustomerCommunicationID = @CustomerCommunicationID

    SELECT
      @newModified = Modified
    FROM
      Communications.CustomerCommunication
    WHERE  CustomerCommunicationID = @CustomerCommunicationID
  END
GO



IF OBJECT_ID('Addresses.usp_CustomerAddress_Delete',
             'P') IS NOT NULL
  DROP PROC Addresses.usp_CustomerAddress_Delete
GO
CREATE PROCEDURE Addresses.usp_CustomerAddress_Delete @CustomerAddressID INT
AS
  BEGIN
    DELETE FROM Addresses.CustomerAddress
    WHERE  CustomerAddressID = @CustomerAddressID
  END
GO

IF OBJECT_ID('Communications.usp_CustomerCommunication_Delete',
             'P') IS NOT NULL
  DROP PROC Communications.usp_CustomerCommunication_Delete
GO
CREATE PROCEDURE Communications.usp_CustomerCommunication_Delete @CustomerCommunicationID INT
AS
  BEGIN
    DELETE FROM Communications.CustomerCommunication
    WHERE  CustomerCommunicationID = @CustomerCommunicationID
  END
GO

IF OBJECT_ID('Addresses.usp_EmployeeAddress_Insert',
             'P') IS NOT NULL
  DROP PROC Addresses.usp_EmployeeAddress_Insert
GO
CREATE PROCEDURE [Addresses].[usp_EmployeeAddress_Insert] @EmployeeID            INT
                                                          ,@AddressTypeID        INT
                                                          ,@AddressLine1         VARCHAR(50)
                                                          ,@AddressLine2         VARCHAR(50)
                                                          ,@City                 VARCHAR(50)
                                                          ,@Region               VARCHAR(50)
                                                          ,@PostalCode           VARCHAR(20)
                                                          ,@CountryID            INT
                                                          ,@AddedBy              VARCHAR(20)
                                                          ,@ModifiedBy           VARCHAR(20)
                                                          ,@newEmployeeAddressID INT OUTPUT
                                                          ,@newModified          TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO Addresses.EmployeeAddress
                (EmployeeID
                 ,AddressTypeID
                 ,AddressLine1
                 ,AddressLine2
                 ,City
                 ,Region
                 ,PostalCode
                 ,CountryID
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @EmployeeID
                  ,@AddressTypeID
                  ,@AddressLine1
                  ,@AddressLine2
                  ,@City
                  ,@Region
                  ,@PostalCode
                  ,@CountryID
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newEmployeeAddressID = EmployeeAddressID
      ,@newModified = Modified
    FROM
      Addresses.EmployeeAddress
    WHERE  EmployeeAddressID = IDENT_CURRENT('Addresses.EmployeeAddress')
  END
GO

IF OBJECT_ID('Communications.usp_EmployeeCommunication_Insert',
             'P') IS NOT NULL
  DROP PROC Communications.usp_EmployeeCommunication_Insert
GO
CREATE PROCEDURE [Communications].[usp_EmployeeCommunication_Insert] @EmployeeID                  INT
                                                                     ,@CommunicationTypeID        INT
                                                                     ,@CommunicationOrderID       INT
                                                                     ,@Communication              VARCHAR(100)
                                                                     ,@AddedBy                    VARCHAR(20)
                                                                     ,@ModifiedBy                 VARCHAR(20)
                                                                     ,@newEmployeeCommunicationID INT OUTPUT
                                                                     ,@newModified                TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO [Communications].[EmployeeCommunication]
                (EmployeeID
                 ,CommunicationTypeID
                 ,CommunicationOrderID
                 ,Communication
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @EmployeeID
                  ,@CommunicationTypeID
                  ,@CommunicationOrderID
                  ,@Communication
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newEmployeeCommunicationID = EmployeeCommunicationID
      ,@newModified = Modified
    FROM
      Communications.EmployeeCommunication
    WHERE  EmployeeCommunicationID = IDENT_CURRENT('Communications.EmployeeCommunication')
  END
GO


IF OBJECT_ID('Addresses.usp_EmployeeAddress_Update',
             'P') IS NOT NULL
  DROP PROC Addresses.usp_EmployeeAddress_Update
GO

CREATE PROCEDURE [Addresses].[usp_EmployeeAddress_Update] @EmployeeAddressID INT
                                                          ,@EmployeeID       INT
                                                          ,@AddressTypeID    INT
                                                          ,@AddressLine1     VARCHAR(50)
                                                          ,@AddressLine2     VARCHAR(50)
                                                          ,@City             VARCHAR(50)
                                                          ,@Region           VARCHAR(50)
                                                          ,@PostalCode       VARCHAR(20)
                                                          ,@CountryID        INT
                                                          ,@ModifiedBy       VARCHAR(20)
                                                          ,@newModified      TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE Addresses.EmployeeAddress
    SET    EmployeeID = @EmployeeID
           ,AddressTypeID = AddressTypeID
           ,AddressLine1 = @AddressLine1
           ,AddressLine2 = @AddressLine2
           ,City = @City
           ,Region = @Region
           ,PostalCode = @PostalCode
           ,CountryID = @CountryID
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    WHERE  EmployeeAddressID = @EmployeeAddressID

    SELECT
      @newModified = Modified
    FROM
      Addresses.EmployeeAddress
    WHERE  EmployeeAddressID = @EmployeeAddressID
  END
GO


IF OBJECT_ID('Communications.usp_EmployeeCommunication_Update',
             'P') IS NOT NULL
  DROP PROC Communications.usp_EmployeeCommunication_Update
GO
CREATE PROCEDURE [Communications].[usp_EmployeeCommunication_Update] @EmployeeCommunicationID INT
                                                                     ,@EmployeeID             INT
                                                                     ,@CommunicationTypeID    INT
                                                                     ,@CommunicationOrderID   INT
                                                                     ,@Communication          VARCHAR(100)
                                                                     ,@ModifiedBy             VARCHAR(20)
                                                                     ,@newModified            TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE [Communications].[EmployeeCommunication]
    SET    [EmployeeID] = @EmployeeID
           ,[CommunicationTypeID] = CommunicationTypeID
           ,[CommunicationOrderID] = CommunicationOrderID
           ,[Communication] = @Communication
           ,[ModifiedBy] = @ModifiedBy
           ,[ModifiedDate] = CURRENT_TIMESTAMP
    WHERE  EmployeeCommunicationID = @EmployeeCommunicationID

    SELECT
      @newModified = Modified
    FROM
      Communications.EmployeeCommunication
    WHERE  EmployeeCommunicationID = @EmployeeCommunicationID
  END
GO

IF OBJECT_ID('Addresses.usp_EmployeeAddress_Delete',
             'P') IS NOT NULL
  DROP PROC Addresses.usp_EmployeeAddress_Delete
GO

CREATE PROCEDURE [Addresses].[usp_EmployeeAddress_Delete] @EmployeeAddressID INT
AS
  BEGIN
    DELETE FROM Addresses.EmployeeAddress
    WHERE  EmployeeAddressID = @EmployeeAddressID
  END
GO

IF OBJECT_ID('Communications.usp_EmployeeCommunication_Delete',
             'P') IS NOT NULL
  DROP PROC Communications.usp_EmployeeCommunication_Delete
GO
CREATE PROCEDURE [Communications].[usp_EmployeeCommunication_Delete] @EmployeeCommunicationID INT
AS
  BEGIN
    DELETE FROM Communications.EmployeeCommunication
    WHERE  EmployeeCommunicationID = @EmployeeCommunicationID
  END
GO 

USE [Northwind2]
GO
PRINT '**********************'
PRINT 'Create Security SPROCS'
PRINT '**********************'
GO
PRINT '************************'
PRINT 'Create SystemRole SPROCS'
PRINT '************************'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF OBJECT_ID('Security.usp_SystemRole_Delete',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemRole_Delete
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemRole_Delete @SystemRoleID INT
AS
  BEGIN
    DECLARE @Msg VARCHAR(500)
    -- STEP 1: Start the transaction
    BEGIN TRANSACTION
    -- STEP 2 & 3: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Security.SystemUserToSystemRole
    WHERE  SystemRoleID = @SystemRoleID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting SystemUserToSystemRole record with SystemRoleID= '
                   + CONVERT(CHAR(5), @SystemRoleID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 4 & 5: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Security.SystemRole
    WHERE  SystemRoleID = @SystemRoleID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting SystemRole record with SystemRoleID= '
                   + CONVERT(CHAR(5), @SystemRoleID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 6: If we reach this point, the commands completed successfully
    --         Commit the transaction....
    COMMIT
  END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF OBJECT_ID('Security.usp_SystemRole_Insert',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemRole_Insert
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemRole_Insert @SystemRoleName   VARCHAR(50)
                                                ,@AddedBy         VARCHAR(20)
                                                ,@ModifiedBy      VARCHAR(20)
                                                ,@newSystemRoleID INT OUTPUT
                                                ,@newModified     TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO Security.SystemRole
                (SystemRoleName
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @SystemRoleName
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newSystemRoleID = SystemRoleID
      ,@newModified = Modified
    FROM
      Security.SystemRole
    WHERE  SystemRoleID = IDENT_CURRENT('Security.SystemRole')
  END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF OBJECT_ID('Security.usp_SystemRole_ReadAll',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemRole_ReadAll
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemRole_ReadAll
AS
  BEGIN
    SELECT
      SystemRoleID
      ,SystemRoleName
    FROM
      Security.SystemRole
    ORDER  BY SystemRoleName
  END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF OBJECT_ID('Security.usp_SystemRole_ReadById',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemRole_ReadById
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemRole_ReadById @SystemRoleID INT
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    SELECT
      SystemRoleID
      ,SystemRoleName
      ,AddedBy
      ,AddedDate
      ,ModifiedBy
      ,ModifiedDate
      ,Modified
    FROM
      Security.SystemRole
    WHERE  SystemRoleID = @SystemRoleID

    SELECT
      su.SystemUserId
      ,su.LastName + ', ' + su.FirstName AS SystemUserName
    FROM
      Security.SystemUser su
      INNER JOIN Security.SystemUserToSystemRole susr
              ON su.SystemUserID = susr.SystemUserID
    WHERE  susr.SystemRoleID = @SystemRoleID
    ORDER  BY su.LastName
              ,su.FirstName
  END 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF OBJECT_ID('Security.usp_SystemRole_Update',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemRole_Update
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemRole_Update @SystemRoleID    INT
                                                ,@SystemRoleName VARCHAR(50)
                                                ,@ModifiedBy     VARCHAR(20)
                                                ,@newModified    TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE SystemRole
    SET    SystemRoleName = @SystemRoleName
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    FROM   Security.SystemRole
    WHERE  SystemRoleID = @SystemRoleID

    SELECT
      @newModified = Modified
    FROM
      Security.SystemRole
    WHERE  SystemRoleID = @SystemRoleID
  END
GO

IF OBJECT_ID('Security.usp_SystemRole_ReadByRoleName',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemRole_ReadByRoleName
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemRole_ReadByRoleName @SystemRoleName VARCHAR(50)
AS
  BEGIN
    SELECT
      sr.SystemRoleID
      ,sr.SystemRoleName
      ,sr.AddedBy
      ,sr.AddedDate
      ,sr.ModifiedBy
      ,sr.ModifiedDate
      ,sr.Modified
    FROM
      Security.SystemRole sr
    WHERE  sr.SystemRoleName = @SystemRoleName

    SELECT
      su.SystemUserID                    AS SystemUserID
      ,su.LastName + ', ' + su.FirstName AS SystemUserName
    FROM
      Security.SystemUser su
      INNER JOIN Security.SystemUserToSystemRole susr
              ON su.SystemUserID = susr.SystemUserID
      INNER JOIN Security.SystemRole sr
              ON susr.SystemRoleID = sr.SystemRoleID
    WHERE  sr.SystemRoleName = @SystemRoleName
    ORDER  BY su.LastName
              ,su.FirstName
  END 
GO
PRINT '************************'
PRINT 'Create SystemUser SPROCS'
PRINT '************************'
GO
IF OBJECT_ID('Security.usp_SystemUser_Delete',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUser_Delete
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUser_Delete @SystemUserID INT
AS
  BEGIN
    DECLARE @Msg VARCHAR(500)
    -- STEP 1: Start the transaction
    BEGIN TRANSACTION
    -- STEP 2 & 3: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Security.SystemUserToSystemRole
    WHERE  SystemUserID = @SystemUserID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting SystemUserToSystemRole record with SystemUserID= '
                   + CONVERT(CHAR(5), @SystemUserID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 4 & 5: Issue the DELETE statements, checking @@ERROR after each statement
    DELETE Security.SystemUser
    WHERE  SystemUserID = @SystemUserID
    -- Rollback the transaction if there were any errors
    IF @@ERROR <> 0
      BEGIN
        ROLLBACK
        SET @Msg = 'Error in deleting SystemUser record with SystemUserID= '
                   + CONVERT(CHAR(5), @SystemUserID)
        RAISERROR (@Msg,16,1)
        RETURN
      END
    -- STEP 6: If we reach this point, the commands completed successfully
    --         Commit the transaction....
    COMMIT
  END
GO
IF OBJECT_ID('Security.usp_SystemUser_Insert',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUser_Insert
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUser_Insert @LastName                VARCHAR(50)
                                                ,@FirstName              VARCHAR(50)
                                                ,@Username               VARCHAR(50)
                                                ,@Password               VARCHAR(50)
                                                ,@Email                  VARCHAR(100)
                                                ,@LastPasswordChangeDate DATETIME
                                                ,@AddedBy                VARCHAR(20)
                                                ,@ModifiedBy             VARCHAR(20)
                                                ,@newSystemUserID        INT OUTPUT
                                                ,@newModified            TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO Security.SystemUser
                (LastName
                 ,FirstName
                 ,Username
                 ,Password
                 ,Email
                 ,LastPasswordChangeDate
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @LastName
                  ,@FirstName
                  ,@Username
                  ,@Password
                  ,@Email
                  ,@LastPasswordChangeDate
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newSystemUserID = SystemUserID
      ,@newModified = Modified
    FROM
      Security.SystemUser
    WHERE  SystemUserID = IDENT_CURRENT('Security.SystemUser')
  END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF OBJECT_ID('Security.usp_SystemUser_ReadAll',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUser_ReadAll
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUser_ReadAll
AS
  BEGIN
    SELECT
      SystemUserID
      ,LastName
	  ,FirstName
      ,Username
      ,Email
      ,LastLoginDate
      ,LastActivityDate
      ,LastPasswordChangeDate
    FROM
      Security.SystemUser
    ORDER  BY LastName
              ,FirstName
  END
GO
IF OBJECT_ID('Security.usp_SystemUser_ReadAllList',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUser_ReadAllList
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUser_ReadAllList
AS
  BEGIN
    SELECT
      SystemUserID
      ,LastName + ', ' + FirstName AS SystemUserName
    FROM
      Security.SystemUser
    ORDER  BY LastName
              ,FirstName
  END
GO 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF OBJECT_ID('Security.usp_SystemUser_ReadById',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUser_ReadById
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUser_ReadById @SystemUserID INT
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    SELECT
      su.SystemUserID
      ,su.LastName
      ,su.FirstName
      ,su.Username
      ,su.Password
      ,su.Email
      ,su.LastLoginDate
      ,su.LastActivityDate
      ,su.LastPasswordChangeDate
      ,su.AddedBy
      ,su.AddedDate
      ,su.ModifiedBy
      ,su.ModifiedDate
      ,su.Modified
    FROM
      Security.SystemUser su
    WHERE  su.SystemUserID = @SystemUserID

    SELECT
      sr.SystemRoleId
      ,sr.SystemRoleName
    FROM
      Security.SystemRole sr
      INNER JOIN Security.SystemUserToSystemRole susr
              ON sr.SystemRoleID = susr.SystemRoleID
    WHERE  susr.SystemUserID = @SystemUserID
    ORDER  BY sr.SystemRoleName
  END 
GO
IF OBJECT_ID('Security.usp_SystemUser_ReadByUsername',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUser_ReadByUsername
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUser_ReadByUsername @Username VARCHAR(50)
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    SELECT
      su.SystemUserID
      ,su.LastName
      ,su.FirstName
      ,su.Username
      ,su.Password
      ,su.Email
      ,su.LastLoginDate
      ,su.LastActivityDate
      ,su.LastPasswordChangeDate
      ,su.AddedBy
      ,su.AddedDate
      ,su.ModifiedBy
      ,su.ModifiedDate
      ,su.Modified
    FROM
      Security.SystemUser su
    WHERE  su.Username = @Username
	
    SELECT
      sr.SystemRoleId
      ,sr.SystemRoleName
    FROM
      Security.SystemRole sr
      INNER JOIN Security.SystemUserToSystemRole susr
              ON sr.SystemRoleID = susr.SystemRoleID
      INNER JOIN Security.SystemUser su
              ON susr.SystemUserID = su.SystemUserID
    WHERE  su.Username = @Username
    ORDER  BY sr.SystemRoleName
  END 
GO

IF OBJECT_ID('Security.usp_SystemUser_ReadByUsernamePassword',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUser_ReadByUsernamePassword
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUser_ReadByUsernamePassword @Username  VARCHAR(50)
                                                                ,@Password VARCHAR(50)
AS
  BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

	SELECT
      su.SystemUserID
      ,su.LastName
      ,su.FirstName
      ,su.Username
      ,su.Password
      ,su.Email
      ,su.LastLoginDate
      ,su.LastActivityDate
      ,su.LastPasswordChangeDate
      ,su.AddedBy
      ,su.AddedDate
      ,su.ModifiedBy
      ,su.ModifiedDate
      ,su.Modified
    FROM
      Security.SystemUser su
    WHERE  su.Username = @Username
       AND su.Password = @Password
	
    SELECT
      sr.SystemRoleId
      ,sr.SystemRoleName
    FROM
      Security.SystemRole sr
      INNER JOIN Security.SystemUserToSystemRole susr
              ON sr.SystemRoleID = susr.SystemRoleID
      INNER JOIN Security.SystemUser su
              ON susr.SystemUserID = su.SystemUserID
    WHERE  su.Username = @Username
    ORDER  BY sr.SystemRoleName
  END

GO

IF OBJECT_ID('Security.usp_SystemUser_Update',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUser_Update
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUser_Update @SystemUserID            INT
                                                ,@LastName               VARCHAR(50)
                                                ,@FirstName              VARCHAR(50)
                                                ,@Username               VARCHAR(50)
                                                ,@Password               VARCHAR(50)
                                                ,@Email                  VARCHAR(100)
                                                ,@ModifiedBy             VARCHAR(20)
                                                ,@newModified            TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE SystemUser
    SET    LastName = @LastName
           ,FirstName = @FirstName
           ,Username = @Username
           ,Password = @Password
           ,Email = @Email
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    FROM   Security.SystemUser
    WHERE  SystemUserID = @SystemUserID

    SELECT
      @newModified = Modified
    FROM
      Security.SystemUser
    WHERE  SystemUserID = @SystemUserID
  END
GO

IF OBJECT_ID('Security.usp_SystemUser_UpdateLastActivityDate',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUser_UpdateLastActivityDate
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUser_UpdateLastActivityDate @Username          VARCHAR(20)
                                                               ,@LastActivityDate DATETIME2
                                                               ,@newModified      TIMESTAMP OUTPUT															   
AS
  BEGIN
    UPDATE SystemUser
    SET    LastActivityDate = @LastActivityDate
    FROM   Security.SystemUser
    WHERE  Username = @Username
	
    SELECT
      @newModified = Modified
    FROM
      Security.SystemUser
    WHERE  Username = @Username	
  END
GO  

IF OBJECT_ID('Security.usp_SystemUser_UpdatePassword',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUser_UpdatePassword
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/17/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUser_UpdatePassword @SystemUserID INT
                                                        ,@Password    VARCHAR(50)
                                                        ,@newModified TIMESTAMP OUTPUT																
AS
  BEGIN
    UPDATE SystemUser
    SET    Password = @Password
    FROM   Security.SystemUser
    WHERE  SystemUserID = @SystemUserID
	
    SELECT
      @newModified = Modified
    FROM
      Security.SystemUser
    WHERE  SystemUserID = @SystemUserID	
  END
GO 

PRINT '************************************'
PRINT 'Create SystemUserToSystemRole SPROCS'
PRINT '************************************'
GO
IF OBJECT_ID('Security.usp_SystemUserToSystemRole_Delete',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUserToSystemRole_Delete
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUserToSystemRole_Delete @SystemUserToSystemRoleID  INT
AS
  BEGIN
    DELETE Security.SystemUserToSystemRole
    WHERE  SystemUserToSystemRoleID = @SystemUserToSystemRoleID
  END 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF OBJECT_ID('Security.usp_SystemUserToSystemRole_Insert',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUserToSystemRole_Insert
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUserToSystemRole_Insert @SystemUserID                 INT
                                                            ,@SystemRoleID                INT
                                                            ,@AddedBy                     VARCHAR(20)
                                                            ,@ModifiedBy                  VARCHAR(20)
                                                            ,@newSystemUserToSystemRoleID INT OUTPUT
                                                            ,@newModified                 TIMESTAMP OUTPUT
AS
  BEGIN
    INSERT INTO Security.SystemUserToSystemRole
                (SystemUserID
                 ,SystemRoleID
                 ,AddedBy
                 ,AddedDate
                 ,ModifiedBy
                 ,ModifiedDate)
    VALUES      ( @SystemUserID
                  ,@SystemRoleID
                  ,@AddedBy
                  ,CURRENT_TIMESTAMP
                  ,@ModifiedBy
                  ,CURRENT_TIMESTAMP )
    SELECT
      @newSystemUserToSystemRoleID = SystemUserToSystemRoleID
      ,@newModified = Modified
    FROM
      Security.SystemUserToSystemRole
    WHERE  SystemUserToSystemRoleID = IDENT_CURRENT('Security.SystemUserToSystemRole')
  END
GO
IF OBJECT_ID('Security.usp_SystemUserToSystemRole_ReadAll',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUserToSystemRole_ReadAll
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUserToSystemRole_ReadAll
AS
  BEGIN
    SELECT
      susr.SystemUserToSystemRoleID
      ,susr.SystemUserID
	  ,su.LastName
	  ,su.FirstName
      ,susr.SystemRoleID
      ,sr.SystemRoleName
    FROM
      Security.SystemUserToSystemRole susr
      INNER JOIN Security.SystemUser su
              ON susr.SystemUserID = su.SystemUserID
      INNER JOIN Security.SystemRole sr
              ON susr.SystemRoleID = sr.SystemRoleID
  END
GO

IF OBJECT_ID('Security.usp_SystemUserToSystemRole_ReadByIds',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUserToSystemRole_ReadByIds
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUserToSystemRole_ReadByIds @SystemUserID  INT
                                                                  ,@SystemRoleID INT
AS
  BEGIN
    SELECT
      susr.SystemUserToSystemRoleID
      ,susr.SystemUserID
      ,su.LastName 
	  ,su.FirstName
	  ,su.Username
	  ,su.Email
      ,susr.SystemRoleID
      ,sr.SystemRoleName
      ,susr.AddedBy
      ,susr.AddedDate
      ,susr.ModifiedBy
      ,susr.ModifiedDate
      ,susr.Modified
    FROM
      Security.SystemUserToSystemRole susr
      INNER JOIN Security.SystemUser su
              ON susr.SystemUserID = su.SystemUserID
      INNER JOIN Security.SystemRole sr
              ON susr.SystemRoleID = sr.SystemRoleID
    WHERE  su.SystemUserID = @SystemUserID
       AND sr.SystemRoleID = @SystemRoleID
  END 
GO
IF OBJECT_ID('Security.usp_SystemUserToSystemRole_ReadById',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUserToSystemRole_ReadById
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUserToSystemRole_ReadById @SystemUserToSystemRoleID INT
AS
  BEGIN
    SELECT
      SystemUserToSystemRoleID
      ,SystemUserID
      ,SystemRoleID
      ,AddedBy
      ,AddedDate
      ,ModifiedBy
      ,ModifiedDate
      ,Modified
    FROM
      Security.SystemUserToSystemRole
    WHERE  SystemUserToSystemRoleID = @SystemUserToSystemRoleID

  --SELECT
  --  SystemUserID
  --  ,LastName
  --  ,FirstName
  --FROM
  --  Security.SystemUser
  --WHERE  SystemUserID = @SystemUserID

  --SELECT
  --  SystemRoleID
  --  ,SystemRoleName
  --FROM
  --  Security.SystemRole
  --WHERE  SystemRoleID = @SystemRoleID
  END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF OBJECT_ID('Security.usp_SystemUserToSystemRole_Update',
             'P') IS NOT NULL
  DROP PROC Security.usp_SystemUserToSystemRole_Update
GO
-- =============================================
--      Author:	KSafford
-- Create date:	09/16/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Security.usp_SystemUserToSystemRole_Update @SystemUserToSystemRoleID INT
                                                            ,@SystemUserID            INT
                                                            ,@SystemRoleID            INT
                                                            ,@ModifiedBy              VARCHAR(20)
                                                            ,@newModified             TIMESTAMP OUTPUT
AS
  BEGIN
    UPDATE SystemUserToSystemRole
    SET    SystemUserID = @SystemUserID
           ,SystemRoleID = @SystemRoleID
           ,ModifiedBy = @ModifiedBy
           ,ModifiedDate = CURRENT_TIMESTAMP
    FROM   Security.SystemUserToSystemRole
    WHERE  SystemUserToSystemRoleID = @SystemUserToSystemRoleID

    SELECT
      @newModified = Modified
    FROM
      Security.SystemUserToSystemRole
    WHERE  SystemUserToSystemRoleID = @SystemUserToSystemRoleID
  END
GO 
