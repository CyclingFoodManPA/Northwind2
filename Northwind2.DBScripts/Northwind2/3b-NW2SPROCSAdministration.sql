USE Northwind2
GO

-- Reference Articles
--   HTTP://www.sqlservercurry.com/2010/07/CHECK-IF-stored-procedure-EXISTS-ELSE.html
--   http://www.mssqltips.com/tutorial.asp?tutorial=162 
/* ---------------------------------------------------------------------- */
/*                                                                        */
/*  Add Administration Stored Procedures                                  */
/*                                                                        */
/*    Holiday                                                             */
/*      usp_Holiday_Add                                                   */
/*	    usp_Holiday_GetAll                                                */
/*		usp_Holiday_GetAllList                                            */
/*      usp_Holiday_GetByID                                               */
/*      usp_Holiday_Update                                                */
/*                                                                        */
/* ---------------------------------------------------------------------- */

PRINT '***************'
PRINT 'Holiday SPROCS '
PRINT '***************'
GO

IF OBJECTPROPERTY(OBJECT_ID('Administration.usp_Holiday_Add'),
                  N'IsProcedure') = 1
  DROP PROC Administration.usp_Holiday_Add
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [Administration].[usp_Holiday_Add] @HolidayDate           DATETIME2
                                           ,@HolidayDescriptionID INT
                                           ,@AddedBy              VARCHAR(20)
                                           ,@ModifiedBy           VARCHAR(20)
                                           ,@newHolidayID         INT OUTPUT
                                           ,@newModified          TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN

    SET NOCOUNT OFF
	
    BEGIN TRY
      INSERT INTO Administration.Holiday
                  (HolidayDate
                   ,HolidayDescriptionID
                   ,AddedBy
                   ,ModifiedBy)
      VALUES      (@HolidayDate
                   ,@HolidayDescriptionID
                   ,@AddedBy
                   ,@ModifiedBy);

      SELECT
        @newHolidayID = HolidayID
        ,@newModified = Modified
      FROM
        Administration.Holiday
      WHERE
        HolidayID = IDENT_CURRENT('Administration.Holiday');
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO  


IF OBJECTPROPERTY(OBJECT_ID('[Administration.usp_Holiday_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC Administration.usp_Holiday_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [Administration].[usp_Holiday_GetAll] @HolidayDateStart       DATETIME2 = NULL
                                                  ,@HolidayDateEnd         DATETIME2 = NULL
                                                  ,@HolidayDescriptionID   INT = NULL
                                                  ,@HolidayDescriptionName VARCHAR(40) = NULL
                                                  ,@IsActive               BIT = NULL
									              ,@PageIndex              INT = 0
									              ,@PageSize               INT = 2147483647
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
        H.HolidayID
        ,H.HolidayDate
        ,H.HolidayDescriptionID
        ,HD.HolidayDescriptionName
        ,H.IsActive
      FROM
        Administration.Holiday AS H
        JOIN Administration.HolidayDescription AS HD
          ON H.HolidayDescriptionID = HD.HolidayDescriptionID
      WHERE  H.HolidayDate BETWEEN ISNULL(@HolidayDateStart,
                                          H.HolidayDate) AND ISNULL(@HolidayDateEnd,
                                                                    H.HolidayDate)
         AND H.HolidayDescriptionID = ISNULL(@HolidayDescriptionID,
                                             H.HolidayDescriptionID)
         AND HD.HolidayDescriptionName LIKE '%'
                                            + ISNULL(@HolidayDescriptionName, HD.HolidayDescriptionName)
                                            + '%'
         AND H.IsActive = ISNULL(@IsActive,
                                 H.IsActive)
      ORDER  BY H.HolidayDate DESC
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Administration.usp_Holiday_GetAllList'),
                  N'IsProcedure') = 1
  DROP PROC Administration.usp_Holiday_GetAllList
GO


CREATE PROC Administration.usp_Holiday_GetAllList
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        H.HolidayID
        ,CONVERT(CHAR(10), H.HolidayDate, 101) + ' - '
         + HD.HolidayDescriptionName AS Holiday
      FROM
        Administration.Holiday AS H
        JOIN Administration.HolidayDescription AS HD
          ON h.HolidayDescriptionID = hd.HolidayDescriptionID
      WHERE
        H.IsActive = 1
      ORDER  BY H.HolidayDate DESC;
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Administration.usp_Holiday_GetByID'),
                  N'IsProcedure') = 1
  DROP PROC Administration.usp_Holiday_GetByID
GO


CREATE PROC Administration.usp_Holiday_GetByID @HolidayID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        H.HolidayID
        ,H.HolidayDate
        ,H.HolidayDescriptionID
        ,H.AddedBy
        ,H.AddedDate
        ,H.ModifiedBy
        ,H.ModifiedDate
        ,H.Modified
      FROM
        Administration.Holiday AS H
      WHERE
        H.HolidayID = @HolidayID;
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Administration.usp_Holiday_Update'),
                  N'IsProcedure') = 1
  DROP PROC Administration.usp_Holiday_Update
GO


CREATE PROC Administration.usp_Holiday_Update @HolidayID             INT
                                              ,@HolidayDate          DATETIME2
                                              ,@HolidayDescriptionID INT
                                              ,@ModifiedBy           VARCHAR(20)
                                              ,@newModified          TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    BEGIN TRY
      UPDATE Holiday
      SET    HolidayDate = @HolidayDate
             ,HolidayDescriptionID = @HolidayDescriptionID
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      FROM   Administration.Holiday
      WHERE
        HolidayID = @HolidayID;

      SELECT
        @newModified = Modified
      FROM
        Administration.Holiday
      WHERE
        HolidayID = @HolidayID;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END
GO 
