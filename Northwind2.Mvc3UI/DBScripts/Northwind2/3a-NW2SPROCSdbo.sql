USE Northwind2
GO
/* ---------------------------------------------------------------------- */
/*                                                                        */
/*  Create Security Stored Procedures                                     */
/*    usp_PrintError                                                      */
/*                                                                        */
/*    ErrorLog                                                            */
/*      usp_LogError                                                      */
/*                                                                        */
/* ---------------------------------------------------------------------- */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECTPROPERTY(OBJECT_ID('dbo.usp_PrintError'),
                  N'IsProcedure') = 1
  DROP PROC dbo.usp_PrintError
GO
--
-- usp_PrintError prints error information about the error that caused 
-- execution to jump to the CATCH block of a TRY...CATCH construct. 
-- Should be executed from within the scope of a CATCH block otherwise 
-- it will return without printing any error information.
--
CREATE PROC dbo.usp_PrintError
AS
  BEGIN
    SET NOCOUNT ON;

    -- Print error information. 
    PRINT 'Error '
          + CONVERT(VARCHAR(50), ERROR_NUMBER())
          + ', Severity '
          + CONVERT(VARCHAR(5), ERROR_SEVERITY())
          + ', State '
          + CONVERT(VARCHAR(5), ERROR_STATE())
          + ', Procedure '
          + ISNULL(ERROR_PROCEDURE(), '-') + ', Line '
          + CONVERT(VARCHAR(5), ERROR_LINE());

    PRINT ERROR_MESSAGE();
  END;
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECTPROPERTY(OBJECT_ID('dbo.usp_LogError'),
                  N'IsProcedure') = 1
  DROP PROC dbo.usp_LogError
GO

--
-- usp_LogError logs error information in the ErrorLog table about the 
-- error that caused execution to jump to the CATCH block of a 
-- TRY...CATCH construct. This should be executed from within the scope 
-- of a CATCH block otherwise it will return without inserting error 
-- information. 
--
CREATE PROC dbo.usp_LogError @ErrorLogID INT = 0 OUTPUT -- contains the ErrorLogID of the row inserted
AS
  BEGIN
    SET NOCOUNT ON;
    -- Output parameter value of 0 indicates that error 
    -- information was not logged
    SET @ErrorLogID = 0;

    BEGIN TRY
      -- Return if there is no error information to log
      IF ERROR_NUMBER() IS NULL
        RETURN;

      -- Return if inside an uncommittable transaction.
      -- Data insertion/modification is not allowed when 
      -- a transaction is in an uncommittable state.
      IF XACT_STATE() = -1
        BEGIN
          PRINT 'Cannot log error since the current transaction is in an uncommittable state. '
                + 'Rollback the transaction before executing uspLogError in order to successfully log error information.';
          RETURN;
        END

      INSERT dbo.ErrorLog
             (UserName
              ,ErrorNumber
              ,ErrorSeverity
              ,ErrorState
              ,ErrorProcedure
              ,ErrorLine
              ,ErrorMessage)
      VALUES ( CONVERT(SYSNAME, CURRENT_USER)
               ,ERROR_NUMBER()
               ,ERROR_SEVERITY()
               ,ERROR_STATE()
               ,ERROR_PROCEDURE()
               ,ERROR_LINE()
               ,ERROR_MESSAGE() );

      -- Pass back the ErrorLogID of the row inserted
      SET @ErrorLogID = @@IDENTITY;
    END TRY

    BEGIN CATCH
      PRINT 'An error occurred in stored procedure usp_LogError: ';
      EXECUTE dbo.usp_PrintError;
      RETURN -1;
    END CATCH
  END; 
