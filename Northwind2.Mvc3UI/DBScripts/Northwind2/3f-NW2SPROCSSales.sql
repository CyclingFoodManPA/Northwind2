USE Northwind2
GO


-- Reference Articles
--   HTTP://www.sqlservercurry.com/2010/07/CHECK-IF-stored-procedure-EXISTS-ELSE.html
--   http://www.mssqltips.com/tutorial.asp?tutorial=162 
--   http://www.queryingsql.com/2013/02/handling-null-values-in-sql-server.html
/* ---------------------------------------------------------------------- */
/*                                                                        */
/*  Add Sales Stored Procedures                                           */
/*    Invoice                                                             */
/*      Sales.usp_Invoice_Add                                             */
/*      Sales.usp_Invoice_GetAll                                          */
/*      Sales.usp_Invoice_GetById                                         */
/*      Sales.usp_Invoice_Update                                          */
/*                                                                        */
/*    InvoiceItem                                                         */
/*      Sales.usp_InvoiceItem_Add                                         */
/*      Sales.usp_InvoiceItem_GetAll                                      */
/*      Sales.usp_InvoiceItem_GetById                                     */
/*      Sales.usp_InvoiceItem_Update                                      */
/*                                                                        */
/*    Shipper                                                             */
/*      Sales.usp_Shipper_Add                                             */
/*      Sales.usp_Shipper_GetAll                                          */
/*      Sales.usp_Shipper_GetAllList                                      */
/*      Sales.usp_Shipper_GetById                                         */
/*      Sales.usp_Shipper_Update                                          */
/*                                                                        */
/*	  Sales.usp_CustomerInvoiceHistory                                    */
/*	  Sales.usp_CustomerInvoiceDetail                                     */
/*    Sales.usp_CustomerInvoicesInvoices                                  */
/*    Sales.vw_InvoiceSubtotals                                           */
/*    Sales.usp_EmployeeSalesByCountry                                    */
/*    Sales.usp_SalesByYear                                               */
/*    Sales.usp_SalesByCategory                                           */
/* ---------------------------------------------------------------------- */
PRINT '****************'
PRINT ' Invoice SPROCS '
PRINT '****************'
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_Invoice_Add'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_Invoice_Add
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Sales.usp_Invoice_Add @CustomerID        INT
                                  ,@EmployeeID       INT
                                  ,@InvoiceDate      DATETIME2
                                  ,@RequiredDate     DATETIME2
                                  ,@ShippedDate      DATETIME2
                                  ,@ShipperID        INT
                                  ,@Freight          MONEY
                                  ,@ShipName         VARCHAR(40)
                                  ,@ShipAddress1     VARCHAR(50)
                                  ,@ShipAddress2     VARCHAR(50)
                                  ,@ShipCity         VARCHAR(50)
                                  ,@ShipRegion       VARCHAR(15)
                                  ,@ShipPostalCode   VARCHAR(10)
                                  ,@CountryID        INT
                                  ,@AddedBy          VARCHAR(20)
                                  ,@ModifiedBy       VARCHAR(20)
                                  ,@newInvoiceID     INT OUTPUT
                                  ,@newModified      TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT OFF

    BEGIN TRY
      INSERT INTO Sales.Invoice
                  (CustomerID
                   ,EmployeeID
                   ,InvoiceDate
                   ,RequiredDate
                   ,ShippedDate
                   ,ShipperID
                   ,Freight
                   ,ShipName
                   ,ShipAddress1
                   ,ShipAddress2
                   ,ShipCity
                   ,ShipRegion
                   ,ShipPostalCode
                   ,CountryID
                   ,AddedBy
                   ,AddedDate
                   ,ModifiedBy
                   ,ModifiedDate)
      VALUES      (@CustomerID
                   ,@EmployeeID
                   ,@InvoiceDate
                   ,@RequiredDate
                   ,@ShippedDate
                   ,@ShipperID
                   ,@Freight
                   ,@ShipName
                   ,@ShipAddress1
                   ,@ShipAddress2
                   ,@ShipCity
                   ,@ShipRegion
                   ,@ShipPostalCode
                   ,@CountryID
                   ,@AddedBy
                   ,CURRENT_TIMESTAMP
                   ,@ModifiedBy
                   ,CURRENT_TIMESTAMP)

      SELECT
        @newInvoiceID = InvoiceID
        ,@newModified = Modified
      FROM
        Sales.Invoice
      WHERE  InvoiceID = IDENT_CURRENT('Sales.Invoice');
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO

IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_Invoice_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_Invoice_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [Sales].[usp_Invoice_GetAll] @CustomerID         INT = NULL
                                         ,@CustomerName      VARCHAR(40) = NULL
                                         ,@EmployeeID        INT= NULL
                                         ,@EmployeeName      VARCHAR(40)= NULL
                                         ,@InvoiceDateStart  DATETIME2= NULL
                                         ,@InvoiceDateEnd    DATETIME2= NULL
                                         ,@RequiredDateStart DATETIME2= NULL
                                         ,@RequiredDateEnd   DATETIME2= NULL
                                         ,@ShippedDateStart  DATETIME2= NULL
                                         ,@ShippedDateEnd    DATETIME2= NULL
                                         ,@ShipperID         INT= NULL
                                         ,@ShipperName       VARCHAR(40)= NULL
                                         ,@ShipAddress1      VARCHAR(50)= NULL
                                         ,@ShipCity          VARCHAR(50)= NULL
                                         ,@ShipRegion        VARCHAR(15)= NULL
                                         ,@ShipPostalCode    VARCHAR(10)= NULL
                                         ,@CountryID         INT= NULL
                                         ,@CountryName       VARCHAR(40)= NULL
				 			             ,@PageIndex         INT = 0
				 				         ,@PageSize          INT = 2147483647
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
        I.InvoiceID
        ,I.CustomerID
        ,C.CustomerName
        ,I.EmployeeID
        ,dbo.udf_Trim(E.LastName) + ', '
         + dbo.udf_Trim(E.FirstName) AS EmployeeName
        ,I.InvoiceDate
        ,I.RequiredDate
        ,I.ShippedDate
        ,I.ShipperID
        ,S.ShipperName
        ,I.Freight
        ,I.ShipName
        ,I.ShipAddress1
        ,I.ShipAddress2
        ,I.ShipCity
        ,I.ShipRegion
        ,I.ShipPostalCode
        ,I.CountryID
        ,CO.CountryName
        ,I.AddedBy
        ,I.AddedDate
        ,I.ModifiedBy
        ,I.ModifiedDate
        ,I.Modified
      FROM
        Sales.Invoice AS I
        INNER JOIN Customers.Customer AS C
                ON I.CustomerID = C.CustomerID
        INNER JOIN HumanResources.Employee AS E
                ON I.EmployeeID = E.EmployeeID
        INNER JOIN Sales.Shipper AS S
                ON I.ShipperID = S.ShipperID
        INNER JOIN Administration.Country AS CO
                ON I.CountryID = CO.CountryID
      WHERE  ( I.CustomerID = @CustomerID
                OR @CustomerID IS NULL )
         AND ( C.CustomerName LIKE '%' + ISNULL(@CustomerName, C.CustomerName)
                                   + '%' )
         AND ( I.EmployeeID = @EmployeeID
                OR @EmployeeID IS NULL )
         AND ( ( E.LastName LIKE '%' + ISNULL(@EmployeeName, E.LastName) + '%' )
                OR ( E.FirstName LIKE '%' + ISNULL(@EmployeeName, E.FirstName) + '%' ) )
         AND ( I.InvoiceDate BETWEEN ISNULL(@InvoiceDateStart,
                                            I.InvoiceDate) AND ISNULL(@InvoiceDateEnd,
                                                                      I.InvoiceDate) )
         AND ( I.RequiredDate BETWEEN ISNULL(@RequiredDateStart,
                                             I.RequiredDate) AND ISNULL(@RequiredDateEnd,
                                                                        I.RequiredDate) )
         AND ( I.ShippedDate BETWEEN ISNULL(@ShippedDateStart,
                                            I.ShippedDate) AND ISNULL(@ShippedDateEnd,
                                                                      I.ShippedDate) )
         AND ( I.ShipperID = @ShipperID
                OR @ShipperID IS NULL )
         AND ( S.ShipperName LIKE '%' + ISNULL(@ShipperName, S.ShipperName) + '%' )
         AND ( I.ShipAddress1 LIKE '%'
                                       + ISNULL(@ShipAddress1, I.ShipAddress1)
                                       + '%' )
         AND ( I.ShipCity LIKE '%' + ISNULL(@ShipCity, I.ShipCity) + '%' )
         AND ( I.ShipRegion LIKE '%' + ISNULL(@ShipRegion, I.ShipRegion) + '%' )
         AND ( I.ShipPostalCode LIKE '%'
                                     + ISNULL(@ShipPostalCode, I.ShipPostalCode)
                                     + '%' )
         AND ( I.CountryID = @CountryID
                OR @CountryID IS NULL )
         AND ( CO.CountryName LIKE '%' + ISNULL(@CountryName, Co.CountryName)
                                   + '%' )
      ORDER  BY I.InvoiceDate DESC
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_Invoice_GetByID'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_Invoice_GetByID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Sales.usp_Invoice_GetById @InvoiceID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        I.InvoiceID
        ,I.CustomerID
        ,I.EmployeeID
        ,I.InvoiceDate
        ,I.RequiredDate
        ,I.ShippedDate
        ,I.ShipperID
        ,I.Freight
        ,I.ShipName
        ,I.ShipAddress1
        ,I.ShipAddress2
        ,I.ShipCity
        ,I.ShipRegion
        ,I.ShipPostalCode
        ,I.CountryID
        ,I.AddedBy
        ,I.AddedDate
        ,I.ModifiedBy
        ,I.ModifiedDate
        ,I.Modified
      FROM
        Sales.Invoice AS I
      WHERE  I.InvoiceID = @InvoiceID

      SELECT
        II.InvoiceItemID
        ,II.InvoiceID
        ,II.ProductID
        ,II.UnitPrice
        ,II.Quantity
        ,II.Discount
        ,( II.UnitPrice * II.Quantity )                       AS Total
        ,( II.UnitPrice * II.Quantity * II.Discount )         AS TotalDiscount
        ,( II.UnitPrice * II.Quantity ) * ( 1 - II.Discount ) AS DiscountedTotal
        ,II.AddedBy
        ,II.AddedDate
        ,II.ModifiedBy
        ,II.ModifiedDate
        ,II.Modified
      FROM
        Sales.InvoiceItem AS II
      WHERE  II.InvoiceID = @InvoiceID
      ORDER  BY II.InvoiceItemID

    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_Invoice_Update'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_Invoice_Update
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Sales.usp_Invoice_Update @InvoiceID         INT
                                     ,@CustomerID       INT
                                     ,@EmployeeID       INT
                                     ,@InvoiceDate      DATETIME2
                                     ,@RequiredDate     DATETIME2
                                     ,@ShippedDate      DATETIME2
                                     ,@ShipperID        INT
                                     ,@Freight          MONEY
                                     ,@ShipName         VARCHAR(40)
                                     ,@ShipAddress1     VARCHAR(50)
                                     ,@ShipAddress2     VARCHAR(50)
                                     ,@ShipCity         VARCHAR(50)
                                     ,@ShipRegion       VARCHAR(15)
                                     ,@ShipPostalCode   VARCHAR(10)
                                     ,@CountryID        INT
                                     ,@ModifiedBy       VARCHAR(20)
                                     ,@newModified      TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      UPDATE Sales.Invoice
      SET    CustomerID = @CustomerID
             ,EmployeeID = @EmployeeID
             ,InvoiceDate = @InvoiceDate
             ,RequiredDate = @RequiredDate
             ,ShippedDate = @ShippedDate
             ,ShipperID = @ShipperID
             ,Freight = @Freight
             ,ShipName = @ShipName
             ,ShipAddress1 = @ShipAddress1
             ,ShipAddress2 = @ShipAddress2
             ,ShipCity = @ShipCity
             ,ShipRegion = @ShipRegion
             ,ShipPostalCode = @ShipPostalCode
             ,CountryID = @CountryID
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      WHERE  InvoiceID = @InvoiceID

      SELECT
        @newModified = Modified
      FROM
        Sales.Invoice
      WHERE  InvoiceID = @InvoiceID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


PRINT '********************'
PRINT ' InvoiceItem SPROCS '
PRINT '********************'
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_InvoiceItem_Add'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_InvoiceItem_Add
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Sales.usp_InvoiceItem_Add @InvoiceItemID     INT
                                      ,@ProductID        INT
                                      ,@UnitPrice        MONEY
                                      ,@Quantity         INT
                                      ,@Discount         DECIMAL(18, 6)
                                      ,@AddedBy          VARCHAR(100)
                                      ,@ModifiedBy       VARCHAR(100)
                                      ,@newInvoiceItemID INT OUTPUT
                                      ,@newModified      TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT OFF

    BEGIN TRY
      INSERT INTO Sales.InvoiceItem
                  (InvoiceItemID
                   ,ProductID
                   ,UnitPrice
                   ,Quantity
                   ,Discount
                   ,AddedBy
                   ,AddedDate
                   ,ModifiedBy
                   ,ModifiedDate)
      VALUES      (@InvoiceItemID
                   ,@ProductID
                   ,@UnitPrice
                   ,@Quantity
                   ,@Discount
                   ,@AddedBy
                   ,CURRENT_TIMESTAMP
                   ,@ModifiedBy
                   ,CURRENT_TIMESTAMP)

      SELECT
        @newInvoiceItemID = InvoiceItemID
        ,@newModified = Modified
      FROM
        Sales.InvoiceItem
      WHERE  InvoiceItemID = IDENT_CURRENT('Sales.InvoiceItem');
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_InvoiceItem_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_InvoiceItem_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [Sales].[usp_InvoiceItem_GetAll] @InvoiceItemID   INT = NULL
                                             ,@ProductID      INT= NULL
                                             ,@ProductName    VARCHAR(40)= NULL
                                             ,@UnitPriceStart MONEY = NULL
                                             ,@UnitPriceEnd   MONEY = NULL
                                             ,@QuantityStart  INT = NULL
                                             ,@QuantityEnd    INT = NULL
                                             ,@DiscountStart  DATETIME2= NULL
                                             ,@DiscountEnd    DATETIME2= NULL
		 			    		             ,@PageIndex      INT = 0
		 				    		         ,@PageSize       INT = 2147483647
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
        II.InvoiceItemID
        ,II.InvoiceItemID
        ,II.ProductID
        ,P.ProductName
        ,II.UnitPrice
        ,II.Quantity
        ,II.Discount
  ,( II.UnitPrice * II.Quantity )                       AS Total
  ,( II.UnitPrice * II.Quantity * II.Discount )         AS TotalDiscount
  ,( II.UnitPrice * II.Quantity ) * ( 1 - II.Discount ) AS DiscountedTotal
        ,II.AddedBy
        ,II.AddedDate
        ,II.ModifiedBy
        ,II.ModifiedDate
        ,II.Modified
      FROM
        Sales.InvoiceItem AS II
        INNER JOIN Products.Product AS P
                ON II.ProductID = P.ProductID
      WHERE  ( II.InvoiceItemID = @InvoiceItemID
                OR @InvoiceItemID IS NULL )
         AND ( II.ProductID = @ProductID
                OR @ProductID IS NULL )
         AND ( P.ProductName LIKE '%' + ISNULL(@ProductName, P.ProductName) + '%' )
         AND ( II.UnitPrice BETWEEN ISNULL(@UnitPriceStart,
                                           II.UnitPrice) AND ISNULL(@UnitPriceEnd,
                                                                    II.UnitPrice) )
         AND ( II.Quantity BETWEEN ISNULL(@QuantityStart,
                                          II.Quantity) AND ISNULL(@QuantityEnd,
                                                                  II.Quantity) )
      ORDER  BY II.InvoiceID DESC
                ,II.InvoiceItemID ASC
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_InvoiceItem_GetById'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_InvoiceItem_GetById
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Sales.usp_InvoiceItem_GetById @InvoiceItemID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        II.InvoiceItemID
        ,II.InvoiceItemID
        ,II.ProductID
        ,II.UnitPrice
        ,II.Quantity
        ,II.Discount
        ,( II.UnitPrice * II.Quantity )                       AS Total
        ,( II.UnitPrice * II.Quantity * II.Discount )         AS TotalDiscount
        ,( II.UnitPrice * II.Quantity ) * ( 1 - II.Discount ) AS DiscountedTotal
        ,II.AddedBy
        ,II.AddedDate
        ,II.ModifiedBy
        ,II.ModifiedDate
        ,II.Modified
      FROM
        Sales.InvoiceItem AS II
      WHERE  II.InvoiceItemID = @InvoiceItemID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_InvoiceItem_Update'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_InvoiceItem_Update
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Sales.usp_InvoiceItem_Update @InvoiceItemID INT
                                         ,@InvoiceID    INT
                                         ,@ProductID    INT
                                         ,@UnitPrice    MONEY
                                         ,@Quantity     INT
                                         ,@Discount     DECIMAL(18, 6)
                                         ,@ModifiedBy   VARCHAR(100)
                                         ,@newModified  TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      UPDATE Sales.InvoiceItem
      SET    InvoiceID = @InvoiceID
             ,ProductID = @ProductID
             ,UnitPrice = @UnitPrice
             ,Quantity = @Quantity
             ,Discount = @Discount
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      WHERE  InvoiceItemID = @InvoiceItemID

      SELECT
        @newModified = Modified
      FROM
        Sales.InvoiceItem
      WHERE  InvoiceItemID = @InvoiceItemID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


PRINT '****************'
PRINT ' Shipper SPROCS '
PRINT '****************'
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_Shipper_Add'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_Shipper_Add
GO

CREATE PROC Sales.usp_Shipper_Add @ShipperName   VARCHAR(40)
                                  ,@Phone        VARCHAR (40)
                                  ,@AddedBy      VARCHAR(20)
                                  ,@ModifiedBy   VARCHAR(20)
                                  ,@newShipperID INT OUTPUT
                                  ,@newModified  TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT OFF

    BEGIN TRY
      INSERT INTO Sales.Shipper
                  (ShipperName
                   ,Phone
                   ,AddedBy
                   ,AddedDate
                   ,ModifiedBy
                   ,ModifiedDate)
      VALUES      (@ShipperName
                   ,@Phone
                   ,@AddedBy
                   ,CURRENT_TIMESTAMP
                   ,@ModifiedBy
                   ,CURRENT_TIMESTAMP)

      SELECT
        @newShipperID = ShipperID
        ,@newModified = Modified
      FROM
        Sales.Shipper
      WHERE  ShipperID = IDENT_CURRENT('Sales.Shipper');
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_Shipper_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_Shipper_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [Sales].[usp_Shipper_GetAll] @ShipperName VARCHAR(40) = NULL
                                         ,@Phone     VARCHAR(40) = NULL
					    		         ,@PageIndex INT = 0
						    	         ,@PageSize  INT = 2147483647
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
        S.ShipperID
        ,S.ShipperName
        ,S.Phone
        ,S.AddedBy
        ,S.AddedDate
        ,S.ModifiedBy
        ,S.ModifiedDate
        ,S.Modified
      FROM
        Sales.Shipper AS S
      WHERE  ( S.ShipperName LIKE '%' + ISNULL(@ShipperName, S.ShipperName) + '%' )
         AND ( S.Phone LIKE '%' + ISNULL(@Phone, S.Phone) + '%' )
      ORDER  BY S.ShipperName
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_Shipper_GetAllList'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_Shipper_GetAllList
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Sales.usp_Shipper_GetAllList
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        S.ShipperID
        ,S.ShipperName
      FROM
        Sales.Shipper AS S
      ORDER  BY S.ShipperName
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_Shipper_GetById'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_Shipper_GetById
GO


CREATE PROC Sales.usp_Shipper_GetById @ShipperID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        S.ShipperID
        ,S.ShipperName
        ,S.Phone
        ,S.AddedBy
        ,S.AddedDate
        ,S.ModifiedBy
        ,S.ModifiedDate
        ,S.Modified
      FROM
        Sales.Shipper AS S
      WHERE  S.ShipperID = @ShipperID

      SELECT
        I.InvoiceID
        ,I.EmployeeID
        ,E.LastName + ', ' + E.FirstName                      AS EmployeeName
        ,I.InvoiceDate
        ,II.UnitPrice
        ,II.Quantity
        ,II.Discount
        ,SUM( II.UnitPrice * II.Quantity )                       AS Total
        ,SUM( II.UnitPrice * II.Quantity * II.Discount )         AS TotalDiscount
        ,SUM(( II.UnitPrice * II.Quantity ) * ( 1 - II.Discount )) AS DiscountedTotal
      FROM
        Sales.Invoice AS I
        INNER JOIN HumanResources.Employee AS E
                ON I.EmployeeID = E.EmployeeID
        INNER JOIN Sales.InvoiceItem AS II
                ON I.InvoiceID = II.InvoiceID
      WHERE  I.ShipperID = @ShipperID
      GROUP  BY I.InvoiceID
                ,I.ShipperID
                ,I.EmployeeID
                ,E.LastName + ', ' + E.FirstName
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


IF OBJECTPROPERTY(OBJECT_ID('Sales.usp_Shipper_Update'),
                  N'IsProcedure') = 1
  DROP PROC Sales.usp_Shipper_Update
GO


CREATE PROC Sales.usp_Shipper_Update @ShipperID     INT
                                     ,@ShipperName  VARCHAR(40)
                                     ,@Phone        VARCHAR (40)
                                     ,@ModifiedBy   VARCHAR(20)
                                     ,@newShipperID INT OUTPUT
                                     ,@newModified  TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      UPDATE Sales.Shipper
      SET    ShipperName = @ShipperName
             ,Phone = @Phone
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      WHERE  ShipperID = @ShipperID

      SELECT
        @newModified = Modified
      FROM
        Sales.Shipper
      WHERE  ShipperID = @ShipperID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO 


IF OBJECTPROPERTY( OBJECT_ID( '[Sales].[usp_CustomerInvoiceHistory]' )
                   ,N'IsProcedure' ) = 1
    DROP PROC [Sales].[usp_CustomerInvoiceHistory]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [Sales].[usp_CustomerInvoiceHistory] @CustomerID       INT
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
			P.ProductName
			,SUM( II.Quantity ) AS Total
		FROM
			Products.Product AS P
			INNER JOIN Sales.InvoiceItem AS II
					ON P.ProductID = II.ProductID
			INNER JOIN Sales.Invoice AS I
					ON II.InvoiceID = I.InvoiceID
			INNER JOIN Customers.Customer AS C
					ON I.CustomerID = C.CustomerID
		WHERE
			C.CustomerID = @CustomerID
        GROUP BY
		    P.ProductName
		ORDER  BY
			P.ProductName
	    OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY( OBJECT_ID( '[Sales].[usp_CustomerInvoiceDetail]' )
                   ,N'IsProcedure' ) = 1
    DROP PROC [Sales].[usp_CustomerInvoiceDetail]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [Sales].[usp_CustomerInvoiceDetail] @InvoiceID INT
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
			,P.ProductID
			,P.ProductName
			,ROUND( II.UnitPrice
					,2 )                       AS UnitPrice
			,II.Quantity
			,CONVERT( INT, II.Discount * 100 ) AS Discount
			,ROUND( CONVERT( MONEY, Quantity * ( 1 - II.Discount ) * II.UnitPrice )
					,1 )                       AS ExtendedPrice
		FROM
			Products.Product AS P
			INNER JOIN Sales.InvoiceItem AS II
					ON P.ProductID = II.ProductID
			INNER JOIN Sales.Invoice AS I
					ON II.InvoiceID = I.InvoiceID
			INNER JOIN Customers.Customer AS C
			        ON I.CustomerID = C.CustomerID
		WHERE
			I.InvoiceID = @InvoiceID
		ORDER  BY
			P.ProductName
	    OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO

IF OBJECTPROPERTY( OBJECT_ID( '[Sales].[usp_CustomerInvoicesInvoices]' )
                   ,N'IsProcedure' ) = 1
    DROP PROC [Sales].[usp_CustomerInvoicesInvoices]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [Sales].[usp_CustomerInvoicesInvoices] @CustomerID INT
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
			,I.InvoiceID
			,I.InvoiceDate
			,I.RequiredDate
			,I.ShippedDate
		FROM
			Sales.Invoice AS I
			INNER JOIN Customers.Customer AS C
					ON I.CustomerID = C.CustomerID
		WHERE
			I.CustomerID = @CustomerID
		ORDER  BY
			I.InvoiceID DESC
	    OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF EXISTS
   (SELECT
        *
    FROM
        sys.objects
    WHERE
       name = 'vw_InvoiceSubtotals')
    DROP VIEW [Sales].[vw_InvoiceSubtotals];
GO

CREATE VIEW [Sales].[vw_InvoiceSubtotals]
AS
    SELECT
        II.InvoiceID
        ,SUM( CONVERT( MONEY, ( II.UnitPrice * II.Quantity * ( 1 - II.Discount ) / 100 ) ) * 100 ) AS Subtotal
    FROM
        Sales.InvoiceItem AS II
    GROUP  BY
        II.InvoiceID
GO


IF OBJECTPROPERTY( OBJECT_ID( '[Sales].[usp_EmployeeSalesByCountry]' )
                   ,N'IsProcedure' ) = 1
    DROP PROC [Sales].[usp_EmployeeSalesByCountry]
GO

CREATE PROC [Sales].[usp_EmployeeSalesByCountry]
    @StartDate DATETIME2,
    @EndDate   DATETIME2,
    @PageIndex INT = 0,
    @PageSize  INT = 2147483647
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
                E.CountryID
                ,C.CountryName
                ,E.LastName
                ,E.FirstName
                ,I.ShippedDate
                ,I.InvoiceID
                ,VWIS.Subtotal
            FROM
                HumanResources.Employee AS E
                INNER JOIN Administration.Country AS C
                        ON E.CountryID = C.CountryID
                INNER JOIN Sales.Invoice AS I
                        ON E.EmployeeID = I.EmployeeID
                INNER JOIN Sales.vw_InvoiceSubtotals AS VWIS
                        ON I.InvoiceID = VWIS.InvoiceID
            WHERE
                I.ShippedDate BETWEEN @StartDate AND @EndDate
			ORDER BY I.ShippedDate DESC
			OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;

        END TRY

        BEGIN CATCH
            EXECUTE dbo.usp_LogError;
        END CATCH;
    END;
GO


IF OBJECTPROPERTY( OBJECT_ID( '[Sales].[usp_SalesByYear]' )
                   ,N'IsProcedure' ) = 1
    DROP PROC [Sales].[usp_SalesByYear]
GO

CREATE PROC [Sales].[usp_SalesByYear]
    @StartDate DATETIME2,
    @EndDate   DATETIME2,
    @PageIndex INT = 0,
    @PageSize  INT = 2147483647
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
				I.ShippedDate
				,I.InvoiceID
				,VWIS.Subtotal
				,DATENAME( yy
						   ,ShippedDate ) AS ShippedDateYear
			FROM
				Sales.Invoice AS I
				INNER JOIN Sales.vw_InvoiceSubtotals AS VWIS
						ON I.InvoiceID = VWIS.InvoiceID
			WHERE
				I.ShippedDate BETWEEN @StartDate AND @EndDate
			ORDER  BY
				I.ShippedDate DESC
			OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
        END TRY

        BEGIN CATCH
            EXECUTE dbo.usp_LogError;
        END CATCH;
    END;
GO


IF OBJECTPROPERTY( OBJECT_ID( '[Sales].[usp_SalesByCategory]' )
                   ,N'IsProcedure' ) = 1
    DROP PROC [Sales].[usp_SalesByCategory]
GO

CREATE PROC [Sales].[usp_SalesByCategory]
	@CategoryName VARCHAR(20)
   ,@InvoiceYear INT = 1998
   ,@PageIndex INT = 0
   ,@PageSize  INT = 2147483647
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
				C.CategoryID
				,C.CategoryName
				,P.ProductID
				,P.ProductName
				,ROUND( SUM( CONVERT( DECIMAL(14, 2), II.Quantity * ( 1 - II.Discount ) * II.UnitPrice ) )
						,0 ) AS TotalPurchase
			FROM
				Sales.InvoiceItem AS II
				INNER JOIN Sales.Invoice AS I
						ON II.InvoiceID = I.InvoiceID
				INNER JOIN Products.Product AS P
						ON II.ProductID = P.ProductID
				INNER JOIN Products.Category AS C
						ON P.CategoryID = C.CategoryID
			WHERE
				( C.CategoryName LIKE '%' + ISNULL(@CategoryName, C.CategoryName)
									  + '%' )
				AND YEAR( I.InvoiceDate ) = @InvoiceYear
			GROUP  BY
				C.CategoryID
				,C.CategoryName
				,P.ProductID
				,P.ProductName
			ORDER  BY
				P.ProductName
			OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
        END TRY

        BEGIN CATCH
            EXECUTE dbo.usp_LogError;
        END CATCH;
    END;
GO
