USE Northwind2
GO

-- Reference Articles
--   HTTP://www.sqlservercurry.com/2010/07/CHECK-IF-stored-procedure-EXISTS-ELSE.html
--   http://www.mssqltips.com/tutorial.asp?tutorial=162 
--   http://www.queryingsql.com/2013/02/handling-null-values-in-sql-server.html
/* ---------------------------------------------------------------------- */
/*                                                                        */
/*  Add HumanResources Stored Procedures                                  */
/*    Employee                                                            */
/*      HumanResources.usp_Employee_Add                                   */
/*      HumanResources.usp_Employee_GetAll                                */
/*      HumanResources.usp_Employee_GetAllList                            */
/*      HumanResources.usp_Employee_GetById                               */
/*      HumanResources.usp_Employee_Update                                */
/*                                                                        */
/*    EmployeeToTerritory                                                 */
/*      HumanResources.usp_EmployeeToTerritory_Add                        */
/*      HumanResources.usp_EmployeeToTerritory_GetAll                     */
/*      HumanResources.usp_EmployeeToTerritory_GetById                    */
/*      HumanResources.usp_EmployeeToTerritory_Update                     */
/*                                                                        */
/*    Territory                                                           */
/*      usp_Territory_Add                                                 */
/*		usp_Territory_GetAll                                              */
/*		usp_Territory_GetAllList                                          */
/*      usp_Territory_GetById                                             */
/*      usp_Territory_Update                                              */
/*                                                                        */
/* ---------------------------------------------------------------------- */


PRINT '****************'
PRINT 'Employee SPROCS '
PRINT '****************'
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_Employee_Add'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_Employee_Add
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC HumanResources.usp_Employee_Add @LastName           VARCHAR(40)
                                            ,@FirstName         VARCHAR(40)
                                            ,@TitleID           INT
                                            ,@TitleOfCourtesyID INT
                                            ,@BirthDate         DATETIME2
                                            ,@HireDate          DATETIME2
                                            ,@Address1          VARCHAR(40)
                                            ,@Address2          VARCHAR(40)
                                            ,@City              VARCHAR(40)
                                            ,@Region            VARCHAR(15)
                                            ,@PostalCode        VARCHAR(10)
                                            ,@CountryID         INT
                                            ,@HomePhone         VARCHAR (40)
                                            ,@Extension         VARCHAR(4)
                                            ,@Picture           IMAGE
                                            ,@Notes             NTEXT
                                            ,@ReportsToID       INT = 0
                                            ,@PicturePath       VARCHAR(255)
                                            ,@AddedBy           VARCHAR(20)
                                            ,@ModifiedBy        VARCHAR(20)
                                            ,@newEmployeeID     INT OUTPUT
                                            ,@newModified       TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT OFF

    BEGIN TRY
      INSERT INTO HumanResources.Employee
                  (LastName
                   ,FirstName
                   ,TitleID
                   ,TitleOfCourtesyID
                   ,BirthDate
                   ,HireDate
                   ,Address1
                   ,Address2
                   ,City
                   ,Region
                   ,PostalCode
                   ,CountryID
                   ,HomePhone
                   ,Extension
                   ,Picture
                   ,Notes
                   ,ReportsToID
                   ,PicturePath
                   ,AddedBy
                   ,AddedDate
                   ,ModifiedBy
                   ,ModifiedDate)
      VALUES      (@LastName
                   ,@FirstName
                   ,@TitleID
                   ,@TitleOfCourtesyID
                   ,@BirthDate
                   ,@HireDate
                   ,@Address1
                   ,@Address2
                   ,@City
                   ,@Region
                   ,@PostalCode
                   ,@CountryID
                   ,@HomePhone
                   ,@Extension
                   ,@Picture
                   ,@Notes
                   ,@ReportsToID
                   ,@PicturePath
                   ,@AddedBy
                   ,CURRENT_TIMESTAMP
                   ,@ModifiedBy
                   ,CURRENT_TIMESTAMP)

      SELECT
        @newEmployeeID = EmployeeID
        ,@newModified = Modified
      FROM
        HumanResources.Employee
      WHERE  EmployeeID = IDENT_CURRENT('HumanResources.Employee');
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_Employee_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_Employee_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [HumanResources].[usp_Employee_GetAll] @LastName             VARCHAR(40) = NULL
                                                   ,@FirstName           VARCHAR(40) = NULL
                                                   ,@TitleID             INT = NULL
                                                   ,@TitleName           VARCHAR(40) = NULL
                                                   ,@TitleOfCourtesyID   INT = NULL
                                                   ,@TitleOfCourtesyName VARCHAR(40) = NULL
                                                   ,@MinBirthDate      DATETIME2 = NULL
                                                   ,@MaxBirthDate        DATETIME2 = NULL
                                                   ,@MinHireDate       DATETIME2 = NULL
                                                   ,@MaxHireDate         DATETIME2 = NULL
                                                   ,@Address1            VARCHAR(40) = NULL
                                                   ,@City                VARCHAR(40) = NULL
                                                   ,@Region              VARCHAR(15) = NULL
                                                   ,@PostalCode          VARCHAR(10) = NULL
                                                   ,@CountryID           INT = NULL
                                                   ,@CountryName         VARCHAR(40) = NULL
                                                   ,@ReportsToID         INT = NULL
				  					               ,@PageIndex           INT = 0
				 					               ,@PageSize            INT = 2147483647
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    DECLARE @OffsetRows INT
    DECLARE @NextRows INT

    IF ( @PageIndex = 0 )
      BEGIN
        SET @OffsetRows = 0
        SET @NextRows = @PageSize
      END
    ELSE
      BEGIN
        SET @OffsetRows = @PageIndex * @PageSize
        SET @NextRows = @PageSize
      END

    BEGIN TRY
      SELECT
        E.EmployeeID
        ,dbo.udf_Trim(E.LastName) + ', '
         + dbo.udf_Trim(E.FirstName) AS EmployeeName
        ,E.TitleID
        ,T.TitleName
        ,E.TitleOfCourtesyID
        ,TOC.TitleOfCourtesyName
        ,E.BirthDate
        ,E.HireDate
        ,E.Address1
        ,E.Address2
        ,E.City
        ,E.Region
        ,E.PostalCode
        ,E.CountryID
        ,CO.CountryName
        ,E.HomePhone
        ,E.Extension
        ,E.Picture
        ,E.Notes
        ,E.ReportsToID
        ,E.PicturePath
        ,E.AddedBy
        ,E.AddedDate
        ,E.ModifiedBy
        ,E.ModifiedDate
        ,E.Modified
      FROM
        HumanResources.Employee AS E
        INNER JOIN HumanResources.Title AS T
                ON E.TitleID = T.TitleID
        INNER JOIN HumanResources.TitleOfCourtesy AS TOC
                ON E.TitleOfCourtesyID = TOC.TitleOfCourtesyID
        LEFT OUTER JOIN Administration.Country AS CO
                     ON E.CountryID = CO.CountryID
      WHERE  ( E.LastName LIKE '%' + ISNULL(@LastName, E.LastName) + '%' )
         AND ( E.FirstName LIKE '%' + ISNULL(@FirstName, E.FirstName) + '%' )
         AND ( E.TitleID = @TitleID
                OR @TitleID IS NULL )
         AND ( T.TitleName LIKE '%' + ISNULL(@TitleName, T.TitleName) + '%' )
         AND ( E.TitleOfCourtesyID = @TitleOfCourtesyID
                OR @TitleOfCourtesyID IS NULL )
         AND ( TOC.TitleOfCourtesyName LIKE '%'
                                            + ISNULL(@TitleOfCourtesyName, TOC.TitleOfCourtesyName)
                                            + '%' )
         AND ( E.BirthDate BETWEEN ISNULL(@MinBirthDate,
                                          E.BirthDate) AND ISNULL(@MaxBirthDate,
                                                                  E.BirthDate) )
         AND ( E.HireDate BETWEEN ISNULL(@MinHireDate,
                                         E.HireDate) AND ISNULL(@MaxHireDate,
                                                                E.HireDate) )
         AND ( E.Address1 LIKE '%' + ISNULL(@Address1, E.Address1) + '%' )
         AND ( E.City LIKE '%' + ISNULL(@City, E.City) + '%' )
         AND ( ( E.Region LIKE '%' + ISNULL(@Region, E.Region) + '%' )
                OR ( @Region IS NULL
                     AND E.Region IS NULL ) )
         AND ( ( E.PostalCode LIKE '%' + ISNULL(@PostalCode, E.PostalCode) + '%' )
                OR ( @PostalCode IS NULL
                     AND E.PostalCode IS NULL ) )
         AND ( E.CountryID = @CountryID
                OR @CountryID IS NULL )
         AND ( CO.CountryName LIKE '%' + ISNULL(@CountryName, CO.CountryName)
                                   + '%' )
         AND ( E.ReportsToID = @ReportsToID
                OR @ReportsToID IS NULL )
      ORDER  BY E.LastName
                ,E.FirstName
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_Employee_GetAllList'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_Employee_GetAllList
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [HumanResources].[usp_Employee_GetAllList]
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        E.EmployeeID
        ,dbo.udf_Trim(E.LastName) + ', '
         + dbo.udf_Trim(E.FirstName) AS EmployeeName
      FROM
        HumanResources.Employee AS E
      ORDER  BY E.LastName
                ,E.FirstName
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_Employee_GetByID'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_Employee_GetByID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC HumanResources.usp_Employee_GetById @EmployeeID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        EmployeeID
        ,LastName
        ,FirstName
        ,TitleID
        ,TitleOfCourtesyID
        ,BirthDate
        ,HireDate
        ,Address1
        ,Address2
        ,City
        ,Region
        ,PostalCode
        ,CountryID
        ,HomePhone
        ,Extension
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
        I.InvoiceID
        ,I.CustomerID
        ,C.CustomerName
        ,I.InvoiceDate
        ,SUM(II.UnitPrice * II.Quantity)                       AS Total
        ,SUM(II.UnitPrice * II.Quantity * II.Discount)         AS TotalDiscount
        ,SUM(II.UnitPrice * II.Quantity) * ( 1 - II.Discount ) AS DiscountedTotal
      FROM
        Sales.Invoice AS I
        INNER JOIN Customers.Customer AS C
                ON I.CustomerID = C.CustomerID
        INNER JOIN Sales.InvoiceItem AS II
                ON I.InvoiceID = II.InvoiceID
      WHERE  I.EmployeeID = @EmployeeID
      GROUP  BY I.InvoiceID
                ,I.CustomerID
                ,C.CustomerName
                ,I.EmployeeID
                ,I.InvoiceDate
                ,II.UnitPrice
                ,II.Quantity
                ,II.Discount
      ORDER  BY I.InvoiceDate DESC

    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_Employee_Update'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_Employee_Update
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC HumanResources.usp_Employee_Update @EmployeeID         INT
                                               ,@LastName          VARCHAR(40)
                                               ,@FirstName         VARCHAR(40)
                                               ,@TitleID           INT
                                               ,@TitleOfCourtesyID INT
                                               ,@BirthDate         DATETIME2
                                               ,@HireDate          DATETIME2
                                               ,@Address1          VARCHAR(40)
                                               ,@Address2          VARCHAR(40)
                                               ,@City              VARCHAR(40)
                                               ,@Region            VARCHAR(15)
                                               ,@PostalCode        VARCHAR(10)
                                               ,@CountryID         INT
                                               ,@HomePhone         VARCHAR (40)
                                               ,@Extension         VARCHAR(4)
                                               ,@Picture           IMAGE
                                               ,@Notes             NTEXT
                                               ,@ReportsToID       INT = 0
                                               ,@PicturePath       VARCHAR(255)
                                               ,@AddedBy           VARCHAR(20)
                                               ,@ModifiedBy        VARCHAR(20)
                                               ,@newModified       TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      UPDATE HumanResources.Employee
      SET    LastName = @LastName
             ,FirstName = @FirstName
             ,TitleID = @TitleID
             ,TitleOfCourtesyID = @TitleOfCourtesyID
             ,BirthDate = @BirthDate
             ,HireDate = @HireDate
             ,Address1 = @Address1
             ,Address2 = @Address2
             ,City = @City
             ,Region = @Region
             ,PostalCode = @PostalCode
             ,CountryID = @CountryID
             ,HomePhone = @HomePhone
             ,Extension = @Extension
             ,Picture = @Picture
             ,Notes = @Notes
             ,ReportsToID = @ReportsToID
             ,PicturePath = @PicturePath
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      WHERE  EmployeeID = @EmployeeID

      SELECT
        @newModified = Modified
      FROM
        HumanResources.Employee
      WHERE  EmployeeID = @EmployeeID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


PRINT '***************************'
PRINT 'EmployeeToTerritory SPROCS '
PRINT '***************************'
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_EmployeeToTerritory_Add'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_EmployeeToTerritory_Add
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC HumanResources.usp_EmployeeToTerritory_Add @EmployeeID                INT
                                                       ,@TerritoryID              INT
                                                       ,@AddedBy                  VARCHAR(20)
                                                       ,@ModifiedBy               VARCHAR(20)
                                                       ,@newEmployeeToTerritoryID INT OUTPUT
                                                       ,@newModified              TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT OFF

    BEGIN TRY
      INSERT INTO HumanResources.EmployeeToTerritory
                  (EmployeeID
                   ,TerritoryID
                   ,AddedBy
                   ,AddedDate
                   ,ModifiedBy
                   ,ModifiedDate)
      VALUES      (@EmployeeID
                   ,@TerritoryID
                   ,@AddedBy
                   ,CURRENT_TIMESTAMP
                   ,@ModifiedBy
                   ,CURRENT_TIMESTAMP)

      SELECT
        @newEmployeeToTerritoryID = EmployeeToTerritoryID
        ,@newModified = Modified
      FROM
        HumanResources.EmployeeToTerritory
      WHERE  EmployeeToTerritoryID = IDENT_CURRENT('HumanResources.EmployeeToTerritory');
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_EmployeeToTerritory_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_EmployeeToTerritory_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [HumanResources].[usp_EmployeeToTerritory_GetAll] @EmployeeToTerritory INT = NULL
                                                              ,@EmployeeID         INT = NULL
                                                              ,@LastName           VARCHAR(40) = NULL
                                                              ,@FirstName          VARCHAR(40) = NULL
                                                              ,@TerritoryID        INT = NULL
                                                              ,@TerritoryCode      CHAR(5) = NULL
                                                              ,@TerritoryName      VARCHAR (40) = NULL
		 		   					                          ,@PageIndex          INT = 0
		 							                          ,@PageSize           INT = 2147483647
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    DECLARE @OffsetRows INT
    DECLARE @NextRows INT

    IF ( @PageIndex = 0 )
      BEGIN
        SET @OffsetRows = 0
        SET @NextRows = @PageSize
      END
    ELSE
      BEGIN
        SET @OffsetRows = @PageIndex * @PageSize
        SET @NextRows = @PageSize
      END

    BEGIN TRY
      SELECT
        ET.EmployeeToTerritoryID
        ,ET.EmployeeID
        ,E.LastName
        ,E.FirstName
        ,ET.TerritoryID
        ,T.TerritoryCode
        ,T.TerritoryName
        ,ET.AddedBy
        ,ET.AddedDate
        ,ET.ModifiedBy
        ,ET.ModifiedDate
        ,ET.Modified
      FROM
        HumanResources.EmployeeToTerritory AS ET
        INNER JOIN HumanResources.Employee AS E
                ON ET.EmployeeID = E.EmployeeID
        INNER JOIN HumanResources.Territory AS T
                ON ET.TerritoryID = T.TerritoryID
      WHERE  ET.EmployeeID = ISNULL(@EmployeeID,
                                    ET.EmployeeID)
         AND E.LastName LIKE '%' + ISNULL(@LastName, E.LastName) + '%'
         AND E.FirstName LIKE '%' + ISNULL(@FirstName, E.FirstName) + '%'
         AND ET.TerritoryID = ISNULL(@TerritoryID,
                                     ET.TerritoryID)
         AND T.TerritoryCode LIKE '%'
                                  + ISNULL(@TerritoryCode, T.TerritoryCode)
                                  + '%'
         AND T.TerritoryName LIKE '%'
                                  + ISNULL(@TerritoryName, T.TerritoryName)
                                  + '%'
      ORDER  BY E.LastName
                ,E.FirstName
                ,T.TerritoryName
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_EmployeeToTerritory_GetById'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_EmployeeToTerritory_GetById
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC HumanResources.usp_EmployeeToTerritory_GetById @EmployeeToTerritoryID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        [EmployeeToTerritoryID]
        ,[EmployeeID]
        ,[TerritoryID]
        ,[AddedBy]
        ,[AddedDate]
        ,[ModifiedBy]
        ,[ModifiedDate]
        ,[Modified]
      FROM
        [HumanResources].[EmployeeToTerritory]
      WHERE  EmployeeToTerritoryID = @EmployeeToTerritoryID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_EmployeeToTerritory_Update'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_EmployeeToTerritory_Update
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC HumanResources.usp_EmployeeToTerritory_Update @EmployeeToTerritoryID INT
                                                          ,@EmployeeID           INT
                                                          ,@TerritoryID          INT
                                                          ,@AddedBy              VARCHAR(20)
                                                          ,@ModifiedBy           VARCHAR(20)
                                                          ,@newEmployeeID        INT OUTPUT
                                                          ,@newModified          TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      UPDATE HumanResources.EmployeeToTerritory
      SET    EmployeeID = @EmployeeID
             ,TerritoryID = @TerritoryID
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      WHERE  EmployeeToTerritoryID = @EmployeeToTerritoryID

      SELECT
        @newModified = Modified
      FROM
        HumanResources.EmployeeToTerritory
      WHERE  EmployeeToTerritoryID = @EmployeeToTerritoryID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


PRINT '*****************'
PRINT 'Territory SPROCS '
PRINT '*****************'
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_Territory_Add'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_Territory_Add
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC HumanResources.usp_Territory_Add @TerritoryCode   CHAR(5)
                                             ,@TerritoryName  VARCHAR(40)
                                             ,@RegionID       INT
                                             ,@AddedBy        VARCHAR(100)
                                             ,@ModifiedBy     VARCHAR(100)
                                             ,@newTerritoryID INT OUTPUT
                                             ,@newModified    TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT OFF
	
    BEGIN TRY
      INSERT INTO HumanResources.Territory
                  (TerritoryCode
                   ,TerritoryName
                   ,RegionID
                   ,AddedBy
                   ,ModifiedBy)
      VALUES      (@TerritoryCode
                   ,@TerritoryName
                   ,@RegionID
                   ,@AddedBy
                   ,@ModifiedBy);

      SELECT
        @newTerritoryID = TerritoryID
        ,@newModified = Modified
      FROM
        HumanResources.Territory
      WHERE  TerritoryID = IDENT_CURRENT('HumanResources.Territory');
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_Territory_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_Territory_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [HumanResources].[usp_Territory_GetAll] @TerritoryCode  CHAR(5) = NULL
                                                    ,@TerritoryName VARCHAR(40) = NULL
                                                    ,@RegionID      INT = NULL
							    		            ,@PageIndex     INT = 0
								    	            ,@PageSize      INT = 2147483647
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    DECLARE @OffsetRows INT
    DECLARE @NextRows INT

    IF ( @PageIndex = 0 )
      BEGIN
        SET @OffsetRows = 0
        SET @NextRows = @PageSize
      END
    ELSE
      BEGIN
        SET @OffsetRows = @PageIndex * @PageSize
        SET @NextRows = @PageSize
      END

    BEGIN TRY
      SELECT
        T.TerritoryID
        ,T.TerritoryCode
        ,T.TerritoryName
        ,T.RegionID
        ,R.RegionName
      FROM
        HumanResources.Territory AS T
        JOIN HumanResources.Region AS R
          ON T.RegionID = R.RegionID
      WHERE  ( T.TerritoryCode LIKE '%'
                                    + ISNULL(@TerritoryCode, T.TerritoryCode)
                                    + '%' )
         AND ( T.TerritoryName LIKE '%'
                                    + ISNULL(@TerritoryName, T.TerritoryName)
                                    + '%' )
         AND ( T.RegionID = @RegionID
                OR @RegionID IS NULL )
      ORDER  BY T.TerritoryName
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_Territory_GetAllList'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_Territory_GetAllList
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC HumanResources.usp_Territory_GetAllList
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        T.TerritoryID
        ,T.TerritoryCode + ': ' + T.TerritoryName AS TerritoryCodeName
      FROM
        HumanResources.Territory AS T
      ORDER  BY T.TerritoryName;
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_Territory_GetByID'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_Territory_GetByID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC HumanResources.usp_Territory_GetById @TerritoryID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        T.TerritoryID
        ,T.TerritoryCode
        ,T.RegionID
        ,T.AddedBy
        ,T.AddedDate
        ,T.ModifiedBy
        ,T.ModifiedDate
        ,T.Modified
      FROM
        HumanResources.Territory AS T
      WHERE  T.TerritoryID = @TerritoryID;
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('HumanResources.usp_Territory_Update'),
                  N'IsProcedure') = 1
  DROP PROC HumanResources.usp_Territory_Update
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC HumanResources.usp_Territory_Update @TerritoryID    INT
                                                ,@TerritoryCode CHAR(5)
                                                ,@TerritoryName VARCHAR(40)
                                                ,@RegionID      INT
                                                ,@ModifiedBy    VARCHAR(20)
                                                ,@newModified   TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    BEGIN TRY
      UPDATE Territory
      SET    TerritoryCode = @TerritoryCode
             ,TerritoryName = @TerritoryName
             ,RegionID = @RegionID
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      FROM   HumanResources.Territory
      WHERE  TerritoryID = @TerritoryID;

      SELECT
        @newModified = Modified
      FROM
        HumanResources.Territory
      WHERE  TerritoryID = @TerritoryID;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END
GO 
