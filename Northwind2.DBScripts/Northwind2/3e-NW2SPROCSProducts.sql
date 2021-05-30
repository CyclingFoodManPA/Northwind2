USE Northwind2
GO

-- Reference Articles
--   HTTP://www.sqlservercurry.com/2010/07/CHECK-IF-stored-procedure-EXISTS-ELSE.html
--   http://www.mssqltips.com/tutorial.asp?tutorial=162 
--   http://www.queryingsql.com/2013/02/handling-null-values-in-sql-server.html
/* ---------------------------------------------------------------------- */
/*                                                                        */
/*  Add HumanResources Stored Procedures                                  */
/*    Product                                                             */
/*      Products.usp_Product_Add                                          */
/*      Products.usp_Product_GetAll                                       */
/*      Products.usp_Product_GetAllList                                   */
/*      Products.usp_Product_GetByID                                      */
/*      Products.usp_Product_Update                                       */
/*                                                                        */
/*    Supplier                                                            */
/*      Products.usp_Supplier_Add                                         */
/*      Products.usp_Supplier_GetAll                                      */
/*      Products.usp_Supplier_GetAllList                                  */
/*      Products.usp_Supplier_GetByID                                     */
/*      Products.usp_Supplier_Update                                      */
/*                                                                        */
/*      Products.usp_TenMostExpensiveProducts                             */
/*                                                                        */
/* ---------------------------------------------------------------------- */


PRINT '***************'
PRINT 'Product SPROCS '
PRINT '***************'
GO


IF OBJECTPROPERTY(OBJECT_ID('Products.usp_Product_Add'),
                  N'IsProcedure') = 1
  DROP PROC Products.usp_Product_Add
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Products.usp_Product_Add @ProductName      VARCHAR(40)
                                     ,@SupplierID      INT
                                     ,@CategoryID      INT
                                     ,@QuantityPerUnit VARCHAR(20)
                                     ,@UnitPrice       MONEY
                                     ,@UnitsInStock    INT
                                     ,@UnitsOnOrder    INT
                                     ,@ReorderLevel    INT
                                     ,@IsActive        BIT
                                     ,@AddedBy         VARCHAR(20)
                                     ,@ModifiedBy      VARCHAR(20)
                                     ,@newProductID    INT OUTPUT
                                     ,@newModified     TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT OFF

    BEGIN TRY
      INSERT INTO Products.Product
                  (ProductName
                   ,SupplierID
                   ,CategoryID
                   ,QuantityPerUnit
                   ,UnitPrice
                   ,UnitsInStock
                   ,UnitsOnOrder
                   ,ReorderLevel
                   ,IsActive
                   ,AddedBy
                   ,AddedDate
                   ,ModifiedBy
                   ,ModifiedDate)
      VALUES      (@ProductName
                   ,@SupplierID
                   ,@CategoryID
                   ,@QuantityPerUnit
                   ,@UnitPrice
                   ,@UnitsInStock
                   ,@UnitsOnOrder
                   ,@ReorderLevel
                   ,@IsActive
                   ,@AddedBy
                   ,CURRENT_TIMESTAMP
                   ,@ModifiedBy
                   ,CURRENT_TIMESTAMP)

      SELECT
        @newProductID = ProductID
        ,@newModified = Modified
      FROM
        Products.Product
      WHERE  ProductID = IDENT_CURRENT('Products.Product');
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Products.usp_Product_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC Products.usp_Product_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [Products].[usp_Product_GetAll] @ProductName      VARCHAR(40) = NULL
                                           ,@SupplierID       INT = NULL
                                           ,@SupplierName     VARCHAR(40) = NULL
                                           ,@CategoryID       INT = NULL
                                           ,@CategoryName     VARCHAR(40) = NULL
                                           ,@MinUnitPrice     MONEY = NULL
                                           ,@MaxUnitPrice     MONEY = NULL
                                           ,@MinUnitsInStock  INT = NULL
                                           ,@MaxUnitsInStock  INT = NULL
                                           ,@MinUnitsOnOrder  INT = NULL
                                           ,@MaxUnitsOnOrder  INT = NULL
                                           ,@MinReorderLevel  INT = NULL
                                           ,@MaxReorderLevel  INT = NULL
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
        P.ProductID
        ,P.ProductName
        ,P.SupplierID
        ,S.SupplierName
        ,P.CategoryID
        ,C.CategoryName
        ,P.QuantityPerUnit
        ,P.UnitPrice
        ,P.UnitsInStock
        ,P.UnitsOnOrder
        ,P.ReorderLevel
        ,P.IsActive
        ,P.AddedBy
        ,P.AddedDate
        ,P.ModifiedBy
        ,P.ModifiedDate
        ,P.Modified
      FROM
        Products.Product AS P
        INNER JOIN Products.Supplier AS S
                ON P.SupplierID = S.SupplierID
        INNER JOIN Products.Category AS C
                ON P.CategoryID = C.CategoryID
      WHERE
        ( P.ProductName LIKE '%' + ISNULL(@ProductName, P.ProductName) + '%' )
        AND ( P.SupplierID = @SupplierID
               OR @SupplierID IS NULL )
        AND ( S.SupplierName LIKE '%' + ISNULL(@SupplierName, S.SupplierName)
                                  + '%' )
        AND ( P.CategoryID = @CategoryID
               OR @CategoryID IS NULL )
        AND ( C.CategoryName LIKE '%' + ISNULL(@CategoryName, C.CategoryName)
                                  + '%' )
        AND ( P.UnitPrice BETWEEN ISNULL(@MinUnitPrice,
                                         P.UnitPrice) AND ISNULL(@MaxUnitPrice,
                                                                 P.UnitPrice) )
        AND ( P.UnitsInStock BETWEEN ISNULL(@MinUnitsInStock,
                                            P.UnitsInStock) AND ISNULL(@MaxUnitsInStock,
                                                                       P.UnitsInStock) )
        AND ( P.UnitsOnOrder BETWEEN ISNULL(@MinUnitsOnOrder,
                                            P.UnitsOnOrder) AND ISNULL(@MaxUnitsOnOrder,
                                                                       P.UnitsOnOrder) )
        AND ( P.ReorderLevel BETWEEN ISNULL(@MinReorderLevel,
                                            P.ReorderLevel) AND ISNULL(@MaxReorderLevel,
                                                                       P.ReorderLevel) )
        AND ( P.IsActive = @IsActive
               OR @IsActive IS NULL )
      ORDER  BY P.ProductName
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Products.usp_Product_GetAllList'),
                  N'IsProcedure') = 1
  DROP PROC Products.usp_Product_GetAllList
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Products.usp_Product_GetAllList
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        P.ProductID
        ,P.ProductName
      FROM
        Products.Product AS P
      WHERE  P.IsActive = 1
      ORDER  BY P.ProductName
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Products.usp_Product_GetByID'),
                  N'IsProcedure') = 1
  DROP PROC Products.usp_Product_GetByID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC Products.usp_Product_GetByID @ProductID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        P.ProductID
        ,P.ProductName
        ,P.SupplierID
        ,P.CategoryID
        ,P.QuantityPerUnit
        ,P.UnitPrice
        ,P.UnitsInStock
        ,P.UnitsOnOrder
        ,P.ReorderLevel
        ,P.IsActive
        ,P.AddedBy
        ,P.AddedDate
        ,P.ModifiedBy
        ,P.ModifiedDate
        ,P.Modified
      FROM
        [Products].[Product] AS P
      WHERE  P.ProductID = @ProductID

      SELECT
        II.InvoiceItemID
        ,II.InvoiceID
        ,II.UnitPrice
        ,II.Quantity
        ,SUM(II.UnitPrice * II.Quantity)                       AS Total
        ,SUM(II.UnitPrice * II.Quantity * II.Discount)         AS TotalDiscount
        ,SUM(II.UnitPrice * II.Quantity) * ( 1 - II.Discount ) AS DiscountedTotal
      FROM
        Sales.InvoiceItem AS II
      WHERE  ProductID = @ProductID
      GROUP  BY II.InvoiceItemID
                ,II.InvoiceID
                ,II.UnitPrice
                ,II.Quantity
                ,II.Discount

    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Products.usp_Product_Update'),
                  N'IsProcedure') = 1
  DROP PROC Products.usp_Product_Update
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Products.usp_Product_Update @ProductID        INT
                                        ,@ProductName     VARCHAR(40)
                                        ,@SupplierID      INT
                                        ,@CategoryID      INT
                                        ,@QuantityPerUnit VARCHAR(20)
                                        ,@UnitPrice       MONEY
                                        ,@UnitsInStock    INT
                                        ,@UnitsOnOrder    INT
                                        ,@ReorderLevel    INT
                                        ,@IsActive        BIT
                                        ,@AddedBy         VARCHAR(20)
                                        ,@ModifiedBy      VARCHAR(20)
                                        ,@newProductID    INT OUTPUT
                                        ,@newModified     TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      UPDATE Products.Product
      SET    ProductName = @ProductName
             ,SupplierID = @SupplierID
             ,CategoryID = @CategoryID
             ,QuantityPerUnit = @QuantityPerUnit
             ,UnitPrice = @UnitPrice
             ,UnitsInStock = @UnitsInStock
             ,UnitsOnOrder = @UnitsOnOrder
             ,ReorderLevel = @ReorderLevel
             ,IsActive = @IsActive
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      WHERE  ProductID = @ProductID

      SELECT
        @newModified = Modified
      FROM
        Products.Product
      WHERE  ProductID = @ProductID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


PRINT '****************'
PRINT 'Supplier SPROCS '
PRINT '****************'
GO


IF OBJECTPROPERTY(OBJECT_ID('Products.usp_Supplier_Add'),
                  N'IsProcedure') = 1
  DROP PROC Products.usp_Supplier_Add
GO


CREATE PROC Products.usp_Supplier_Add @SupplierName    VARCHAR(40)
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
                                      ,@HomePage       VARCHAR(255)
                                      ,@SupplierIDOld  CHAR(5)
                                      ,@AddedBy        VARCHAR(20)
                                      ,@ModifiedBy     VARCHAR(20)
                                      ,@newSupplierID  INT OUTPUT
                                      ,@newModified    TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT OFF

    BEGIN TRY
      INSERT INTO Products.Supplier
                  (SupplierName
                   ,ContactName
                   ,ContactTitleID
                   ,Address1
                   ,Address2
                   ,City
                   ,Region
                   ,PostalCode
                   ,CountryID
                   ,Phone
                   ,Fax
                   ,HomePage
                   ,AddedBy
                   ,AddedDate
                   ,ModifiedBy
                   ,ModifiedDate)
      VALUES      (@SupplierName
                   ,@ContactName
                   ,@ContactTitleID
                   ,@Address1
                   ,@Address2
                   ,@City
                   ,@Region
                   ,@PostalCode
                   ,@CountryID
                   ,@Phone
                   ,@Fax
                   ,@HomePage
                   ,@AddedBy
                   ,CURRENT_TIMESTAMP
                   ,@ModifiedBy
                   ,CURRENT_TIMESTAMP)

      SELECT
        @newSupplierID = SupplierID
        ,@newModified = Modified
      FROM
        Products.Supplier
      WHERE  SupplierID = IDENT_CURRENT('Products.Supplier');
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Products.usp_Supplier_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC Products.usp_Supplier_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [Products].[usp_Supplier_GetAll] @SupplierName      VARCHAR(40) = NULL
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
                                             ,@HomePage         VARCHAR(100) = NULL
											 ,@IsActive         BIT = 1
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
        S.SupplierID
        ,S.SupplierName
        ,S.ContactName
        ,S.ContactTitleID
        ,CT.ContactTitleName
        ,S.Address1
        ,S.Address2
        ,S.City
        ,S.Region
        ,S.PostalCode
        ,S.CountryID
        ,CO.CountryName
        ,S.Phone
        ,S.Fax
        ,S.HomePage
        ,S.AddedBy
        ,S.AddedDate
        ,S.ModifiedBy
        ,S.ModifiedDate
        ,S.Modified
      FROM
        Products.Supplier AS S
        INNER JOIN Administration.ContactTitle AS CT
                ON S.ContactTitleID = CT.ContactTitleID
        LEFT OUTER JOIN Administration.Country AS CO
                     ON S.CountryID = CO.CountryID
      WHERE  S.SupplierName LIKE '%' + ISNULL(@SupplierName, S.SupplierName)
                                 + '%'
         AND S.ContactName LIKE '%' + ISNULL(@ContactName, S.ContactName) + '%'
         AND ( S.ContactTitleID = @ContactTitleID
                OR @ContactTitleID IS NULL )
         AND S.ContactTitleID = ISNULL(@ContactTitleID,
                                       S.ContactTitleID)
         AND CT.ContactTitleName LIKE '%'
                                      + ISNULL(@ContactTitleName, CT.ContactTitleName)
                                      + '%'
         AND S.Address1 LIKE '%' + ISNULL(@Address1, S.Address1) + '%'
         AND S.City LIKE '%' + ISNULL(@City, S.City) + '%'
         AND S.Region LIKE '%' + ISNULL(@Region, S.Region) + '%'
         AND S.PostalCode LIKE '%' + ISNULL(@PostalCode, S.PostalCode) + '%'
         AND ( S.CountryID = @CountryID
                OR @CountryID IS NULL )
         AND CO.CountryName LIKE '%' + ISNULL(@CountryName, CO.CountryName)
                                 + '%'
      ORDER  BY S.SupplierName
                ,S.ContactName
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Products.usp_Supplier_GetAllList'),
                  N'IsProcedure') = 1
  DROP PROC Products.usp_Supplier_GetAllList
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC Products.usp_Supplier_GetAllList
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        S.SupplierID
        ,S.SupplierName
      FROM
        Products.Supplier AS S
      WHERE  S.IsActive = 1
      ORDER  BY S.SupplierName
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Products.usp_Supplier_GetByID'),
                  N'IsProcedure') = 1
  DROP PROC Products.usp_Supplier_GetByID
GO


CREATE PROC Products.usp_Supplier_GetByID @SupplierID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        C.SupplierID
        ,C.SupplierName
        ,C.ContactName
        ,C.ContactTitleID
        ,C.Address1
        ,C.Address2
        ,C.City
        ,C.Region
        ,C.PostalCode
        ,C.CountryID
        ,C.Phone
        ,C.Fax
        ,C.HomePage
        ,C.AddedBy
        ,C.AddedDate
        ,C.ModifiedBy
        ,C.ModifiedDate
        ,C.Modified
      FROM
        Products.Supplier AS C
      WHERE  C.SupplierID = @SupplierID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Products.usp_Supplier_Update'),
                  N'IsProcedure') = 1
  DROP PROC Products.usp_Supplier_Update
GO


CREATE PROC Products.usp_Supplier_Update @SupplierID      INT
                                         ,@SupplierName   VARCHAR(40)
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
                                         ,@HomePage       VARCHAR(100)
                                         ,@IsActive       BIT
                                         ,@ModifiedBy     VARCHAR(20)
                                         ,@newModified    TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      UPDATE Products.Supplier
      SET    SupplierName = @SupplierName
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
             ,HomePage = @HomePage
             ,IsActive = @IsActive
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      WHERE  SupplierID = @SupplierID

      SELECT
        @newModified = Modified
      FROM
        Products.Supplier
      WHERE  SupplierID = @SupplierID
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;

  END;
GO 


IF OBJECTPROPERTY( OBJECT_ID( '[Products].[usp_TenMostExpensiveProducts]' )
                   ,N'IsProcedure' ) = 1
    DROP PROC [Products].[usp_TenMostExpensiveProducts]
GO

CREATE PROC [Products].[usp_TenMostExpensiveProducts]
WITH EXEC AS CALLER
AS
    BEGIN
        SET NOCOUNT ON

        BEGIN TRY
            SELECT TOP 10
                P.ProductName
                ,P.UnitPrice
            FROM
                Products.Product AS P
            ORDER  BY
                P.UnitPrice DESC;
        END TRY

        BEGIN CATCH
            EXECUTE dbo.usp_LogError;
        END CATCH;
    END;
GO


