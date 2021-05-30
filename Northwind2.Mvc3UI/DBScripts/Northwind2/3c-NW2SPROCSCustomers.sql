USE Northwind2
GO

-- Reference Articles
--   HTTP://www.sqlservercurry.com/2010/07/CHECK-IF-stored-procedure-EXISTS-ELSE.html
--   http://www.mssqltips.com/tutorial.asp?tutorial=162 
--   http://www.queryingsql.com/2013/02/handling-null-values-in-sql-server.html
/* ---------------------------------------------------------------------- */
/*                                                                        */
/*  Add Customers Stored Procedures                                       */
/*    Customer                                                            */
/*      Customers.usp_Customer_Add                                        */
/*      Customers.usp_Customer_GetAll                                     */
/*      Customers.usp_Customer_GetAllList                                 */
/*      Customers.usp_Customer_GetByID                                    */
/*      Customers.usp_Customer_Update                                     */
/*                                                                        */
/* ---------------------------------------------------------------------- */


IF OBJECTPROPERTY(OBJECT_ID('Customers.usp_Customer_Add'),
                  N'IsProcedure') = 1
  DROP PROC Customers.usp_Customer_Add
GO

CREATE PROC [Customers].[usp_Customer_Add]
    @CustomerName   VARCHAR(40),
    @ContactName    VARCHAR(40),
    @ContactTitleID INT,
    @Address1       VARCHAR(50) = NULL,
    @Address2       VARCHAR(50) = NULL,
    @City           VARCHAR(50) = NULL,
    @Region         VARCHAR(15) = NULL,
    @PostalCode     VARCHAR(10) = NULL,
    @CountryID      INT = 23,
    @Phone          VARCHAR (40) = NULL,
    @Fax            VARCHAR(40) = NULL,
    @Email          VARCHAR(100) = NULL,
    @CustomerIDOld  CHAR(5),
    @IsActive       BIT = 1,
    @AddedBy        VARCHAR(20),
    @ModifiedBy     VARCHAR(20),
    @newCustomerID  INT OUTPUT,
    @newModified    TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
    BEGIN

		SET NOCOUNT OFF
		
        BEGIN TRY
            INSERT INTO Customers.Customer
            (
                CustomerName,
                ContactName,
                ContactTitleID,
                Address1,
                Address2,
                City,
                Region,
                PostalCode,
                CountryID,
                Phone,
                Fax,
                EMail,
                CustomerIDOld,
                IsActive,
                AddedBy,
                AddedDate,
                ModifiedBy,
                ModifiedDate
            )
            VALUES
            (
                @CustomerName,
                @ContactName,
                @ContactTitleID,
                @Address1,
                @Address2,
                @City,
                @Region,
                @PostalCode,
                @CountryID,
                @Phone,
                @Fax,
                @Email,
                @CustomerIDOld,
                @IsActive,
                @AddedBy,
                CURRENT_TIMESTAMP,
                @ModifiedBy,
                CURRENT_TIMESTAMP
            )
            SELECT
                @newCustomerID = CustomerID
                ,@newModified = Modified
            FROM
                Customers.Customer
            WHERE
                CustomerID = IDENT_CURRENT( 'Customers.Customer' );
        END TRY

        BEGIN CATCH
            EXEC dbo.usp_LogError;
        END CATCH;
    END; 

GO


IF OBJECTPROPERTY(OBJECT_ID('Customers.usp_Customer_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC Customers.usp_Customer_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [Customers].[usp_Customer_GetAll] @CustomerName      VARCHAR(40) = NULL
                                              ,@ContactName      VARCHAR(40) = NULL
                                              ,@ContactTitleID   INT = NULL
                                              ,@ContactTitleName VARCHAR(40) = NULL
                                              ,@Address1         VARCHAR(50) = NULL
                                              ,@City             VARCHAR(50) = NULL
                                              ,@Region           VARCHAR(15) = NULL
                                              ,@PostalCode       VARCHAR(10) = NULL
                                              ,@CountryID        INT = NULL
                                              ,@CountryName      VARCHAR(40) = NULL
                                              ,@Phone            VARCHAR(40) = NULL
                                              ,@Fax              VARCHAR(40) = NULL
                                              ,@Email            VARCHAR(100) = NULL
											  ,@IsActive         BIT = NULL
									          ,@PageIndex        INT = 0
									          ,@PageSize         INT = 2147483647
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
        C.CustomerID
        ,C.CustomerName
        ,C.ContactName
        ,C.ContactTitleID
        ,CT.ContactTitleName
        ,C.Address1
        ,C.Address2
        ,C.City
        ,C.Region
        ,C.PostalCode
        ,C.CountryID
        ,CO.CountryName
        ,C.Phone
        ,C.Fax
        ,C.EMail
        ,C.CustomerIDOld
		,C.IsActive
        ,C.AddedBy
        ,C.AddedDate
        ,C.ModifiedBy
        ,C.ModifiedDate
        ,C.Modified
      FROM
        Customers.Customer AS C
        INNER JOIN Administration.ContactTitle AS CT
                ON C.ContactTitleID = CT.ContactTitleID
        LEFT OUTER JOIN Administration.Country AS CO
                     ON C.CountryID = CO.CountryID
      WHERE  ( C.CustomerName LIKE '%' + ISNULL(@CustomerName, C.CustomerName)
                                   + '%' )
         AND ( C.ContactName LIKE '%' + ISNULL(@ContactName, C.ContactName) + '%' )
         AND ( C.ContactTitleID = @ContactTitleID
                OR @ContactTitleID IS NULL )
         AND ( C.ContactTitleID = ISNULL(@ContactTitleID,
                                         C.ContactTitleID) )
         AND ( CT.ContactTitleName LIKE '%'
                                        + ISNULL(@ContactTitleName, CT.ContactTitleName)
                                        + '%' )
         AND ( C.Address1 LIKE '%' + ISNULL(@Address1, C.Address1) + '%' )
         AND ( C.City LIKE '%' + ISNULL(@City, C.City) + '%' )
         AND ( ( C.Region LIKE '%' + ISNULL(@Region, C.Region) + '%' )
                OR ( @Region IS NULL
                     AND C.Region IS NULL ) )
         AND ( ( C.PostalCode LIKE '%' + ISNULL(@PostalCode, C.PostalCode) + '%' )
                OR ( @PostalCode IS NULL
                     AND C.PostalCode IS NULL ) )
         AND ( C.CountryID = @CountryID
                OR @CountryID IS NULL )
         AND ( CO.CountryName LIKE '%' + ISNULL(@CountryName, CO.CountryName)
                                   + '%' )
         AND ( ( C.Phone LIKE '%' + ISNULL(@Phone, C.Phone) + '%' )
                OR ( @Phone IS NULL
                     AND C.Phone IS NULL ) )
         AND ( ( C.Fax LIKE '%' + ISNULL(@Fax, C.Fax) + '%' )
                OR ( @Fax IS NULL
                     AND C.Fax IS NULL ) )
         AND ( ( C.Email LIKE '%' + ISNULL(@Email, C.Email) + '%' )
                OR ( @Email IS NULL
                     AND C.Email IS NULL ) )
        AND ( C.IsActive = @IsActive
               OR @IsActive IS NULL )
      ORDER  BY C.CustomerName
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Customers.usp_Customer_GetAllList'),
                  N'IsProcedure') = 1
  DROP PROC Customers.usp_Customer_GetAllList
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Customers.usp_Customer_GetAllList
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        C.CustomerID
        ,C.CustomerName
      FROM
        Customers.Customer AS C
      WHERE  C.IsActive = 1
      ORDER  BY C.CustomerName
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Customers.usp_Customer_GetByID'),
                  N'IsProcedure') = 1
  DROP PROC Customers.usp_Customer_GetByID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [Customers].[usp_Customer_GetByID]
    @CustomerID INT
WITH EXEC AS CALLER
AS
    BEGIN
        SET NOCOUNT ON

        BEGIN TRY
            SELECT
                C.CustomerID
                ,C.CustomerName
                ,C.ContactName
                ,C.ContactTitleID
                ,CT.ContactTitleName
                ,C.Address1
                ,C.Address2
                ,C.City
                ,C.Region
                ,C.PostalCode
                ,C.CountryID
                ,CO.CountryName
                ,C.Phone
                ,C.Fax
                ,C.EMail
                ,C.CustomerIDOld
                ,C.IsActive
                ,C.AddedBy
                ,C.AddedDate
                ,C.ModifiedBy
                ,C.ModifiedDate
                ,C.Modified
            FROM
                Customers.Customer AS C
                INNER JOIN Administration.ContactTitle AS CT
                        ON C.ContactTitleID = CT.ContactTitleID
                LEFT OUTER JOIN Administration.Country AS CO
                             ON C.CountryID = CO.CountryID
            WHERE
                C.CustomerID = @CustomerID

            SELECT
                I.InvoiceID                                              AS InvoiceID
                ,E.LastName + ', ' + E.FirstName                         AS EmployeeName
                ,I.InvoiceDate                                           AS InvoiceDate
                ,SUM( II.UnitPrice * II.Quantity ) * ( 1 - II.Discount ) AS Amount
            INTO
                #CustomerInvoiceItem
            FROM
                Sales.Invoice AS I
                INNER JOIN HumanResources.Employee AS E
                        ON I.EmployeeID = E.EmployeeID
                INNER JOIN Sales.InvoiceItem AS II
                        ON I.InvoiceID = II.InvoiceID
            WHERE
                I.CustomerID = @CustomerID
            GROUP  BY
                I.InvoiceID
                ,I.CustomerID
                ,I.EmployeeID
                ,E.LastName + ', ' + E.FirstName
                ,I.InvoiceDate
                ,II.UnitPrice
                ,II.Quantity
                ,II.Discount
            ORDER  BY
                I.InvoiceDate DESC

            SELECT
                InvoiceID
                ,EmployeeName
                ,InvoiceDate
                ,SUM( Amount ) AS AmountSum
            FROM
                #CustomerInvoiceItem
            GROUP  BY
                InvoiceID
                ,EmployeeName
                ,InvoiceDate
            ORDER  BY
                InvoiceID DESC
        END TRY

        BEGIN CATCH
            EXEC dbo.usp_LogError;
        END CATCH;
    END; 
GO


IF OBJECTPROPERTY(OBJECT_ID('Customers.usp_Customer_Update'),
                  N'IsProcedure') = 1
  DROP PROC Customers.usp_Customer_Update
GO


CREATE PROC [Customers].[usp_Customer_Update] @CustomerID      INT
                                          ,@CustomerName   VARCHAR(40)
                                          ,@ContactName    VARCHAR(40)
                                          ,@ContactTitleID INT
                                          ,@Address1       VARCHAR(50)
                                          ,@Address2       VARCHAR(50)
                                          ,@City           VARCHAR(50)
                                          ,@Region         VARCHAR(15)
                                          ,@PostalCode     VARCHAR(10)
                                          ,@CountryID      INT
                                          ,@Phone          VARCHAR (40)
                                          ,@Fax            VARCHAR(40)
                                          ,@EMail          VARCHAR(100)
                                          ,@CustomerIDOld  CHAR(5)
                                          ,@ModifiedBy     VARCHAR(20)
                                          ,@newModified    TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      UPDATE Customers.Customer
      SET    CustomerName = @CustomerName
             ,ContactName = @ContactName
             ,ContactTitleID = @ContactTitleID
             ,Address1 = @Address1
             ,Address2 = @Address2
             ,City = @City
             ,Region = @Region
             ,PostalCode = @PostalCode
             ,CountryID = @CountryID
             ,Phone = @Phone
             ,Fax = @Fax
             ,EMail = @EMail
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      WHERE  CustomerID = @CustomerID

      SELECT
        @newModified = Modified
      FROM
        Customers.Customer
      WHERE  CustomerID = @CustomerID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;

GO
