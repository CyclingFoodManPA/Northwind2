USE Northwind2
GO

-- Reference Articles
--   HTTP://www.sqlservercurry.com/2010/07/CHECK-IF-stored-procedure-EXISTS-ELSE.html
--   http://www.mssqltips.com/tutorial.asp?tutorial=162 
/* ---------------------------------------------------------------------- */
/*                                                                        */
/*  Create Security Stored Procedures                                     */
/*    General Security                                                    */
/*      Security.usp_ApplicationUser_IsValid                              */
/*      Security.usp_ApplicationUserToApplicationRole_IsIn                */
/*      Security.usp_ApplicationUserToApplicationRole_UsernameGet         */
/*                                                                        */
/*    ApplicationUser                                                     */
/*      usp_ApplicationRole_Add                                           */
/*		usp_ApplicationRole_GetAll                                        */
/*		usp_ApplicationRole_GetAllList                                    */
/*      usp_ApplicationRole_GetByID                                       */
/*      usp_ApplicationRole_Update                                        */
/*                                                                        */
/*    ApplicationUser                                                     */
/*      usp_ApplicationUser_Add                                           */
/*		usp_ApplicationUser_GetAll                                        */
/*		usp_ApplicationUser_GetAllList                                    */
/*      usp_ApplicationUser_GetByID                                       */
/*      usp_ApplicationUser_Update                                        */
/*                                                                        */
/*    ApplicationUserToApplicationRole                                    */
/*      usp_ApplicationUserToApplicationRole_Add                          */
/*		usp_ApplicationUserToApplicationRole_GetAll                       */
/*		usp_ApplicationUserToApplicationRole_GetAllList                   */
/*      usp_ApplicationUserToApplicationRole_GetByID                      */
/*      usp_ApplicationUserToApplicationRole_Update                       */
/*                                                                        */
/* ---------------------------------------------------------------------- */

PRINT '****************'
PRINT 'Security SPROCS '
PRINT '****************'
GO

IF OBJECTPROPERTY( OBJECT_ID( '[Security].[usp_ApplicationUser_IsValid]' )
                   ,N'IsProcedure' ) = 1
    DROP PROC [Security].[usp_ApplicationUser_IsValid]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [Security].[usp_ApplicationUser_IsValid]
    @Username VARCHAR(20) = NULL,
    @Password VARCHAR(100) = NULL,
    @IsValid  BIT OUTPUT
WITH EXEC AS CALLER
AS
    BEGIN
        SET NOCOUNT ON
		SET @IsValid = 0

        BEGIN TRY
            SELECT
                @IsValid = 1
            WHERE
                EXISTS
                (SELECT
                     AU.ApplicationUserLastName
                     ,AU.ApplicationUserFirstName
                 FROM
                     Security.ApplicationUser AS AU
                 WHERE
                    AU.UserName = @Username
                    AND AU.Password = @Password)

        END TRY

        BEGIN CATCH
            EXEC dbo.usp_LogError;
        END CATCH;
    END; 
GO

IF OBJECTPROPERTY( OBJECT_ID( '[Security].[usp_ApplicationUserToApplicationRole_IsIn]' )
                   ,N'IsProcedure' ) = 1
    DROP PROC [Security].[usp_ApplicationUserToApplicationRole_IsIn]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [Security].[usp_ApplicationUserToApplicationRole_IsIn]
    @Username VARCHAR(20) = NULL,
    @RoleName VARCHAR(40) = NULL,
    @IsIn     BIT OUTPUT
WITH EXEC AS CALLER
AS
    BEGIN
        SET NOCOUNT ON
        SET @IsIn = 0

        BEGIN TRY
            SELECT
                @IsIn = 1
            WHERE
                EXISTS
                (SELECT
                     AU.UserName
                     ,AR.ApplicationRoleName
                 FROM
                     Security.ApplicationUserToApplicationRole AS AUAR
                     JOIN Security.ApplicationUser AS AU
                       ON AUAR.ApplicationUserID = AU.ApplicationUserID
                     JOIN Security.ApplicationRole AS AR
                       ON AUAR.ApplicationRoleID = AR.ApplicationRoleID
                 WHERE
                    AU.Username                = @Username
                    AND AR.ApplicationRoleName = @RoleName)
        END TRY

        BEGIN CATCH
            EXEC dbo.usp_LogError;
        END CATCH;
    END; 
GO


IF OBJECTPROPERTY( OBJECT_ID( '[Security].[usp_ApplicationUserToApplicationRole_UsernameRoleNamesGetAll]' )
                   ,N'IsProcedure' ) = 1
    DROP PROC [Security].[usp_ApplicationUserToApplicationRole_UsernameRoleNamesGetAll]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [Security].[usp_ApplicationUserToApplicationRole_UsernameRoleNamesGetAll]
    @Username VARCHAR(20) = NULL
WITH EXEC AS CALLER
AS
    BEGIN
        SET NOCOUNT ON

        BEGIN TRY
            SELECT
			    AU.ApplicationUserID
				,AU.ApplicationUserLastName
				,AU.ApplicationUserFirstName			
                ,AU.Username
				,AR.ApplicationRoleID
                ,AR.ApplicationRoleName
            FROM
                Security.ApplicationUserToApplicationRole AS AUAR
                JOIN Security.ApplicationUser AS AU
                  ON AUAR.ApplicationUserID = AU.ApplicationUserID
                JOIN Security.ApplicationRole AS AR
                  ON AUAR.ApplicationRoleID = AR.ApplicationRoleID
            WHERE
                AU.Username = @Username
        END TRY

        BEGIN CATCH
            EXECUTE dbo.usp_LogError;
        END CATCH;
    END;
GO


PRINT '***********************'
PRINT 'ApplicationUser SPROCS '
PRINT '***********************'
GO
IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationRole_Add'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationRole_Add
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [Security].[usp_ApplicationRole_Add] @ApplicationRoleName   VARCHAR(40)
                                                 ,@IsActive             BIT
                                                 ,@AddedBy              VARCHAR(100)
                                                 ,@ModifiedBy           VARCHAR(100)
                                                 ,@newApplicationRoleID INT OUTPUT
                                                 ,@newModified          TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    BEGIN TRY
      INSERT INTO [Security].[ApplicationRole]
                  ([ApplicationRoleName]
                   ,[IsActive]
                   ,[AddedBy]
                   ,[AddedDate]
                   ,[ModifiedBy]
                   ,[ModifiedDate])
      VALUES      (@ApplicationRoleName
                   ,@IsActive
                   ,@AddedBy
                   ,CURRENT_TIMESTAMP
                   ,@ModifiedBy
                   ,CURRENT_TIMESTAMP)

      SELECT
        @newApplicationRoleID = ApplicationRoleID
        ,@newModified = Modified
      FROM
        Security.ApplicationRole
      WHERE
        ApplicationRoleID = IDENT_CURRENT('Security.ApplicationRole');
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationRole_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationRole_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [Security].[usp_ApplicationRole_GetAll] @ApplicationRoleName   VARCHAR(40) = NULL
                                                 ,@IsActive             BIT = 1
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
		   AR.ApplicationRoleID
		  ,AR.ApplicationRoleName
          ,AR.IsActive
          ,AR.AddedBy
          ,AR.AddedDate
          ,AR.ModifiedBy
          ,AR.ModifiedDate
          ,AR.Modified
		FROM
		  Security.ApplicationRole AS AR
        WHERE
          ( AR.ApplicationRoleName LIKE '%' + ISNULL(@ApplicationRoleName, AR.ApplicationRoleName) + '%' )
          AND ( AR.IsActive = @IsActive
               OR @IsActive IS NULL )
	    ORDER BY AR.ApplicationRoleName
	    OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationRole_GetAllList'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationRole_GetAllList
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [Security].[usp_ApplicationRole_GetAllList]
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        AR.ApplicationRoleID
        ,AR.ApplicationRoleName
        ,AR.IsActive
      FROM
        Security.ApplicationRole AS AR
      ORDER  BY AR.ApplicationRoleName
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationRole_GetByID'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationRole_GetByID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [Security].[usp_ApplicationRole_GetByID] @ApplicationRoleID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        AR.ApplicationRoleID
        ,AR.ApplicationRoleName
        ,AR.IsActive
        ,AR.AddedBy
        ,AR.AddedDate
        ,AR.ModifiedBy
        ,AR.ModifiedDate
        ,AR.Modified
      FROM
        Security.ApplicationRole AS AR
      WHERE
        AR.ApplicationRoleID = @ApplicationRoleID
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


PRINT '******************'
PRINT 'ApplicationUser SPROCS '
PRINT '******************'
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUser_Add'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUser_Add
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC Security.usp_ApplicationUser_Add @ApplicationUserLastName   VARCHAR(20)
                                             ,@ApplicationUserFirstName VARCHAR(20)
                                             ,@UserName                 VARCHAR(20)
                                             ,@Password                 VARCHAR(100)
                                             ,@Email                    VARCHAR(100)
                                             ,@LastPasswordChangeDate   DATETIME2
                                             ,@AddedBy                  VARCHAR(100)
                                             ,@ModifiedBy               VARCHAR(100)
                                             ,@newApplicationUserID     INT OUTPUT
                                             ,@newModified              TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      INSERT INTO Security.ApplicationUser
                  (ApplicationUserLastName
                   ,ApplicationUserFirstName
                   ,Username
                   ,Password
                   ,Email
                   ,LastPasswordChangeDate
                   ,AddedBy
                   ,ModifiedBy)
      VALUES      (@ApplicationUserLastName
                   ,@ApplicationUserFirstName
                   ,@Username
                   ,@Password
                   ,@Email
                   ,@LastPasswordChangeDate
                   ,@AddedBy
                   ,@ModifiedBy);

      SELECT
        @newApplicationUserID = ApplicationUserID
        ,@newModified = Modified
      FROM
        Security.ApplicationUser
      WHERE
        ApplicationUserID = IDENT_CURRENT('Security.ApplicationUser');

    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUser_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUser_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [Security].[usp_ApplicationUser_GetAll] @ApplicationUserLastName      VARCHAR(20) = NULL
                                                   ,@ApplicationUserFirstName    VARCHAR(20) = NULL
                                                   ,@UserName                    VARCHAR(20) = NULL
                                                   ,@Email                       VARCHAR(100) = NULL
                                                   ,@IsActive                    BIT = True
                                                   ,@LastLoginDateStart          DATETIME2 = NULL
                                                   ,@LastLoginDateEnd            DATETIME2 = NULL
                                                   ,@LastActivityDateStart       DATETIME2 = NULL
                                                   ,@LastActivityDateEnd         DATETIME2 = NULL
                                                   ,@LastPasswordChangeDateStart DATETIME2 = NULL
                                                   ,@LastPasswordChangeDateEnd   DATETIME2 = NULL
									               ,@PageIndex                   INT = 0
									               ,@PageSize                    INT = 2147483647
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
        ApplicationUserID
        ,ApplicationUserLastName
        ,ApplicationUserFirstName
        ,UserName
        ,Email
        ,LastLoginDate
        ,LastActivityDate
        ,LastPasswordChangeDate
        ,IsActive
        ,AddedBy
        ,AddedDate
        ,ModifiedBy
        ,ModifiedDate
        ,Modified
      FROM
        Security.ApplicationUser
      WHERE
        ApplicationUserLastName LIKE '%'
                                + ISNULL(@ApplicationUserLastName, ApplicationUserLastName)
                                + '%'
        AND ApplicationUserFirstName LIKE '%'
                                     + ISNULL(@ApplicationUserFirstName, ApplicationUserFirstName)
                                     + '%'
        AND UserName LIKE '%' + ISNULL(@UserName, UserName) + '%'
        AND Email LIKE '%' + ISNULL(@Email, Email) + '%'
		AND (IsActive = @IsActive)
        AND ( ( @LastLoginDateStart IS NULL
                AND @LastLoginDateEnd IS NULL )
               OR ( LastLoginDate BETWEEN ISNULL(@LastLoginDateStart,
                                                 LastLoginDate) AND ISNULL(@LastLoginDateEnd,
                                                                           LastLoginDate) ) )
        AND ( ( @LastActivityDateStart IS NULL
                AND @LastActivityDateEnd IS NULL )
               OR ( LastActivityDate BETWEEN ISNULL(@LastActivityDateStart,
                                                    LastActivityDate) AND ISNULL(@LastActivityDateEnd,
                                                                                 LastActivityDate) ) )
        AND ( ( @LastPasswordChangeDateStart IS NULL
                AND @LastPasswordChangeDateEnd IS NULL )
               OR ( LastPasswordChangeDate BETWEEN ISNULL(@LastPasswordChangeDateStart,
                                                          LastPasswordChangeDate) AND ISNULL(@LastPasswordChangeDateEnd,
                                                                                             LastPasswordChangeDate) ) )
        AND IsActive = ISNULL(@IsActive,
                              IsActive)
      ORDER  BY ApplicationUserLastName
                ,ApplicationUserFirstName
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUser_GetAllList'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUser_GetAllList
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC Security.[usp_ApplicationUser_GetAllList]
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        ApplicationUserID
        ,LTRIM(RTRIM(ApplicationUserLastName))
         + ', '
         + LTRIM(RTRIM(ApplicationUserFirstName)) AS ApplicationUserName
      FROM
        Security.ApplicationUser
      WHERE
        IsActive = 1
      ORDER  BY ApplicationUserLastName
                ,ApplicationUserFirstName;
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUser_GetByID'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUser_GetByID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC Security.usp_ApplicationUser_GetByID @ApplicationUserID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        ApplicationUserID
        ,ApplicationUserLastName
        ,ApplicationUserFirstName
        ,Username
        ,Email
        ,LastLoginDate
        ,LastActivityDate
        ,LastPasswordChangeDate
        ,IsActive
        ,AddedBy
        ,AddedDate
        ,ModifiedBy
        ,ModifiedDate
        ,Modified
      FROM
        Security.ApplicationUser
      WHERE
        ApplicationUserID = @ApplicationUserID;

      SELECT
        SR.ApplicationRoleID
        ,SR.ApplicationRoleName
        ,SR.IsActive
      FROM
        dbo.ApplicationRole AS SR
        JOIN Security.ApplicationUserToApplicationRole AS SUSR
          ON SR.ApplicationRoleID = SUSR.ApplicationRoleID
             AND SUSR.ApplicationUserID = @ApplicationUserID;
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('usp_ApplicationUser_GetByUsernamePassword'),
                  N'IsProcedure') = 1
  DROP PROC usp_ApplicationUser_GetByUsernamePassword
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [Security].[usp_ApplicationUser_GetByUsernamePassword]
    @Username VARCHAR(20) = NULL,
    @Password VARCHAR(100) = NULL
WITH EXEC AS CALLER
AS
    BEGIN
        SET NOCOUNT ON

        BEGIN TRY
            SELECT
                AU.ApplicationUserLastName
                ,AU.ApplicationUserFirstName
            FROM
                Security.ApplicationUser AS AU
            WHERE
                AU.UserName = @Username
                AND AU.Password = @Password
        END TRY

        BEGIN CATCH
            EXEC dbo.usp_LogError;
        END CATCH;
    END; 
GO

IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUser_Update'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUser_Update
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC Security.usp_ApplicationUser_Update @ApplicationUserID         INT
                                                ,@ApplicationUserLastName  VARCHAR(20)
                                                ,@ApplicationUserFirstName VARCHAR(20)
                                                ,@Username                 VARCHAR(20)
                                                ,@Email                    VARCHAR(100)
                                                ,@IsActive                 BIT
                                                ,@ModifiedBy               VARCHAR(20)
                                                ,@newModified              TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    BEGIN TRY
      UPDATE ApplicationUser
      SET    ApplicationUserLastName = @ApplicationUserLastName
             ,ApplicationUserFirstName = @ApplicationUserFirstName
             ,Username = @Username
             ,Email = @Email
             ,IsActive = @IsActive
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      FROM   Security.ApplicationUser
      WHERE
        ApplicationUserID = @ApplicationUserID;

      SELECT
        @newModified = SU.Modified
      FROM
        Security.ApplicationUser AS SU
      WHERE
        SU.ApplicationUserID = @ApplicationUserID;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


PRINT '******************************'
PRINT 'ApplicationUserToApplicationRole SPROCS '
PRINT '******************************'
GO

IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUserToApplicationRole_Add'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUserToApplicationRole_Add
GO

CREATE PROC Security.usp_ApplicationUserToApplicationRole_Add @ApplicationRoleID                      INT
                                                              ,@ApplicationUserID                     INT
                                                              ,@AddedBy                               VARCHAR(20)
                                                              ,@ModifiedBy                            VARCHAR(20)
                                                              ,@newApplicationUserToApplicationRoleID INT OUTPUT
                                                              ,@newModified                           TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      INSERT INTO Security.ApplicationUserToApplicationRole
                  (ApplicationRoleID
                   ,ApplicationUserID
                   ,AddedBy
                   ,ModifiedBy)
      VALUES      (@ApplicationRoleID
                   ,@ApplicationUserID
                   ,@AddedBy
                   ,@ModifiedBy)

      SELECT
        @newApplicationUserToApplicationRoleID = ApplicationUserToApplicationRoleID
        ,@newModified = Modified
      FROM
        Security.ApplicationUserToApplicationRole
      WHERE
        ApplicationUserToApplicationRoleID = IDENT_CURRENT('Security.ApplicationUserToApplicationRole');
    END TRY

    BEGIN CATCH
      EXEC dbo.usp_LogError;
    END CATCH;
  END;
GO

IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUserToApplicationRole_GetAll'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUserToApplicationRole_GetAll
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [Security].[usp_ApplicationUserToApplicationRole_GetAll] @ApplicationUserID         INT = NULL
                                                                     ,@ApplicationUserLastName  VARCHAR(20) = NULL
                                                                     ,@ApplicationUserFirstName VARCHAR(20) = NULL
                                                                     ,@UserName                 VARCHAR(20) = NULL
                                                                     ,@Email                    VARCHAR(100) = NULL
                                                                     ,@ApplicationRoleID        INT = NULL
                                                                     ,@ApplicationRoleName      VARCHAR(40) = NULL
					                   				                 ,@PageIndex                INT = 0
									                                 ,@PageSize                 INT = 2147483647
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
        AUAR.ApplicationUserToApplicationRoleID
        ,AUAR.ApplicationUserID
        ,AU.ApplicationUserLastName + ', '
         + AU.ApplicationUserFirstName AS ApplicationUserName
        ,AU.UserName
        ,AUAR.ApplicationRoleID
        ,AR.ApplicationRoleName
        ,AUAR.AddedBy
        ,AUAR.AddedDate
        ,AUAR.ModifiedBy
        ,AUAR.ModifiedDate
        ,AUAR.Modified
      FROM
        Security.ApplicationUserToApplicationRole AS AUAR
        JOIN Security.ApplicationUser AS AU
          ON AUAR.ApplicationUserID = AU.ApplicationUserID
        JOIN Security.ApplicationRole AS AR
          ON AUAR.ApplicationRoleID = AR.ApplicationRoleID
      WHERE
        AUAR.ApplicationUserID = ISNULL(@ApplicationUserID,
                                        AUAR.ApplicationUserID)
        AND AU.ApplicationUserLastName LIKE '%'
                                            + ISNULL(@ApplicationUserLastName, AU.ApplicationUserLastName)
                                            + '%'
        AND AU.ApplicationUserFirstName LIKE '%'
                                             + ISNULL(@ApplicationUserFirstName, AU.ApplicationUserFirstName)
                                             + '%'
        AND AU.UserName LIKE '%' + ISNULL(@UserName, AU.UserName) + '%'
        AND AU.Email LIKE '%' + ISNULL(@Email, AU.Email) + '%'
        AND AUAR.ApplicationRoleID = ISNULL(@ApplicationRoleID,
                                            AUAR.ApplicationRoleID)
        AND AR.ApplicationRoleName LIKE '%'
                                   + ISNULL(@ApplicationRoleName, AR.ApplicationRoleName)
                                   + '%'
      ORDER  BY AU.ApplicationUserLastName
                ,AU.ApplicationUserFirstName
	  OFFSET @OffsetRows ROWS FETCH NEXT @PageSize ROWS ONLY;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUserToApplicationRole_GetByID'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUserToApplicationRole_GetByID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC Security.usp_ApplicationUserToApplicationRole_GetByID @ApplicationUserToApplicationRoleID INT
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        AUAR.ApplicationUserToApplicationRoleID
        ,AUAR.ApplicationUserID
        ,AU.ApplicationUserLastName + ', '
         + AU.ApplicationUserFirstName AS ApplicationUserName
        ,AUAR.ApplicationRoleID
        ,AR.ApplicationRoleName
        ,AUAR.AddedBy
        ,AUAR.AddedDate
        ,AUAR.ModifiedBy
        ,AUAR.ModifiedDate
        ,AUAR.Modified
      FROM
        Security.ApplicationUserToApplicationRole AS AUAR
        JOIN Security.ApplicationUser AS AU
          ON AUAR.ApplicationUserID = AU.ApplicationUserID
        JOIN Security.ApplicationRole AS AR
          ON AUAR.ApplicationRoleID = AR.ApplicationRoleID;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUserToApplicationRole_GetAllList'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUserToApplicationRole_GetAllList
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [Security].[usp_ApplicationUserToApplicationRole_GetAllList]
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        AUAR.ApplicationUserToApplicationRoleID
        ,AUAR.ApplicationUserID
        ,AU.ApplicationUserLastName + ', '
         + AU.ApplicationUserFirstName AS ApplicationUserName
        ,AU.UserName
        ,AUAR.ApplicationRoleID
        ,AR.ApplicationRoleName
      FROM
        Security.ApplicationUserToApplicationRole AS AUAR
        JOIN Security.ApplicationUser AS AU
          ON AUAR.ApplicationUserID = AU.ApplicationUserID
        JOIN Security.ApplicationRole AS AR
          ON AUAR.ApplicationRoleID = AR.ApplicationRoleID
      ORDER  BY AU.ApplicationUserLastName
                ,AU.ApplicationUserFirstName
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUserToApplicationRole_GetByApplicationRoleID'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUserToApplicationRole_GetByApplicationRoleID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [Security].[usp_ApplicationUserToApplicationRole_GetByApplicationRoleID] @ApplicationRoleID INT = NULL
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        AUAR.ApplicationUserToApplicationRoleID
        ,AUAR.ApplicationUserID
        ,AU.ApplicationUserLastName + ', '
         + AU.ApplicationUserFirstName AS ApplicationUserName
        ,AU.UserName
        ,AUAR.ApplicationRoleID
        ,AR.ApplicationRoleName
        ,AUAR.AddedBy
        ,AUAR.AddedDate
        ,AUAR.ModifiedBy
        ,AUAR.ModifiedDate
        ,AUAR.Modified
      FROM
        Security.ApplicationUserToApplicationRole AS AUAR
        JOIN Security.ApplicationUser AS AU
          ON AUAR.ApplicationUserID = AU.ApplicationUserID
        JOIN Security.ApplicationRole AS AR
          ON AUAR.ApplicationRoleID = AR.ApplicationRoleID
      WHERE
        AR.ApplicationRoleID = @ApplicationRoleID
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO


IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUserToApplicationRole_GetByApplicationUserID'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUserToApplicationRole_GetByApplicationUserID
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [Security].[usp_ApplicationUserToApplicationRole_GetByApplicationUserID] @ApplicationUserID INT = NULL
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        AUAR.ApplicationUserToApplicationRoleID
        ,AUAR.ApplicationUserID
        ,AU.ApplicationUserLastName + ', '
         + AU.ApplicationUserFirstName AS ApplicationUserName
        ,AU.UserName
        ,AUAR.ApplicationRoleID
        ,AR.ApplicationRoleName
        ,AUAR.AddedBy
        ,AUAR.AddedDate
        ,AUAR.ModifiedBy
        ,AUAR.ModifiedDate
        ,AUAR.Modified
      FROM
        Security.ApplicationUserToApplicationRole AS AUAR
        JOIN Security.ApplicationUser AS AU
          ON AUAR.ApplicationUserID = AU.ApplicationUserID
        JOIN Security.ApplicationRole AS AR
          ON AUAR.ApplicationRoleID = AR.ApplicationRoleID
      WHERE
        AU.ApplicationUserID = @ApplicationUserID
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO

IF OBJECTPROPERTY(OBJECT_ID('Security.usp_ApplicationUserToApplicationRole_Update'),
                  N'IsProcedure') = 1
  DROP PROC Security.usp_ApplicationUserToApplicationRole_Update
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC Security.usp_ApplicationUserToApplicationRole_Update @ApplicationUserToApplicationRoleID INT
                                                                 ,@ApplicationRoleID                 INT
                                                                 ,@ApplicationUserID                 INT
                                                                 ,@IsActive                          BIT
                                                                 ,@ModifiedBy                        VARCHAR(20)
                                                                 ,@newModified                       TIMESTAMP OUTPUT
WITH EXEC AS CALLER
AS
  BEGIN
    BEGIN TRY
      UPDATE ApplicationUserToApplicationRole
      SET    ApplicationRoleID = @ApplicationRoleID
             ,ApplicationUserID = @ApplicationUserID
             ,IsActive = @IsActive
             ,ModifiedBy = @ModifiedBy
             ,ModifiedDate = CURRENT_TIMESTAMP
      FROM   Security.ApplicationUserToApplicationRole
      WHERE
        ApplicationUserToApplicationRoleID = @ApplicationUserToApplicationRoleID;

      SELECT
        @newModified = AUAR.Modified
      FROM
        Security.ApplicationUserToApplicationRole AS AUAR
      WHERE
        AUAR.ApplicationUserToApplicationRoleID = @ApplicationUserToApplicationRoleID;
    END TRY

    BEGIN CATCH
      EXECUTE dbo.usp_LogError;
    END CATCH;
  END;
GO 


