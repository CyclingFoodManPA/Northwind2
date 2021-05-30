USE auditdb
go




CREATE PROC [dbo].[usp_DDLEvents_ReadAll] @PostTimeStart     DATETIME2 = NULL
                                          ,@PostTimeEnd      DATETIME2 = NULL
                                          ,@DatabaseUserName SYSNAME = NULL
                                          ,@EventType        SYSNAME = NULL
                                          ,@DatabaseName     NVARCHAR(255) = NULL
                                          ,@SchemaName       SYSNAME = NULL
                                          ,@ObjectName       SYSNAME = NULL
                                          ,@HostName         VARCHAR(64) = NULL
                                          ,@IPAddress        VARCHAR(32) = NULL
                                          ,@ProgramName      NVARCHAR(255) = NULL
                                          ,@LoginName        NVARCHAR(255) = NULL
WITH EXEC AS CALLER
AS
  BEGIN
    SET NOCOUNT ON

    BEGIN TRY
      SELECT
        DE.[DDLEventsID]
        ,DE.[PostTime]
        ,DE.[DatabaseUserName]
        ,DE.[EventType]
        ,DE.[TSQL]
        ,DE.[XmlEvent]
        ,DE.[DatabaseName]
        ,DE.[SchemaName]
        ,DE.[ObjectName]
        ,DE.[HostName]
        ,DE.[IPAddress]
        ,DE.[ProgramName]
        ,DE.[LoginName]
        ,DE.[Modified]
      FROM
        [dbo].[DDLEvents] AS DE
      WHERE
        DE.[PostTime] BETWEEN ISNULL(@PostTimeStart,
                                     DE.[PostTime]) AND ISNULL(@PostTimeEnd,
                                                               DE.[PostTime])
        AND DE.[DatabaseUserName] LIKE '%'
                                       + ISNULL(@DatabaseUserName, DE.[DatabaseUserName])
                                       + '%'
        AND DE.[EventType] LIKE '%' + ISNULL(@EventType, DE.[EventType]) + '%'
        AND DE.[DatabaseName] LIKE '%'
                                   + ISNULL(@DatabaseName, DE.[DatabaseName])
                                   + '%'
        AND DE.[SchemaName] LIKE '%' + ISNULL(@SchemaName, DE.[SchemaName])
                                 + '%'
        AND DE.[ObjectName] LIKE '%' + ISNULL(@ObjectName, DE.[ObjectName])
                                 + '%'
        AND DE.[HostName] LIKE '%' + ISNULL(@HostName, DE.[HostName]) + '%'
        AND DE.[IPAddress] LIKE '%' + ISNULL(@IPAddress, DE.[IPAddress]) + '%'
        AND DE.[ProgramName] LIKE '%' + ISNULL(@ProgramName, DE.[ProgramName])
                                  + '%'
        AND DE.[LoginName] LIKE '%' + ISNULL(@LoginName, DE.[LoginName]) + '%'

    END TRY

    BEGIN CATCH
      EXEC [dbo].[usp_LogError];
    END CATCH;
  END; 
