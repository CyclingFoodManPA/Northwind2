USE Northwind2DW
GO
--
--http://www.mssqltips.com/sqlservertip/2085/sql-server-ddl-triggers-to-track-all-database-changes/
--

PRINT '**********************'
PRINT ' CREATE trg_DDLTrigger'
PRINT '**********************'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER trg_DDLTrigger
ON DATABASE
FOR DDL_DATABASE_LEVEL_EVENTS
AS
  BEGIN
    SET NOCOUNT ON;

    DECLARE
      @data       XML
      ,@schema    SYSNAME
      ,@object    SYSNAME
      ,@eventType SYSNAME
      ,@sql       NVARCHAR(MAX)
      ,@ip        VARCHAR(32);

    SET @data = EVENTDATA();
    SET @eventType = @data.value('(/EVENT_INSTANCE/EventType)[1]',
                                 'sysname');
    SET @schema = @data.value('(/EVENT_INSTANCE/SchemaName)[1]',
                              'sysname');
    SET @object = @data.value('(/EVENT_INSTANCE/ObjectName)[1]',
                              'sysname')
    SET @sql = @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]',
                           'nvarchar(max)')
    SELECT
      @ip = client_net_address
    FROM
      sys.dm_exec_connections
    WHERE
      session_id = @@SPID;

    IF @object IS NOT NULL
      PRINT '  ' + @eventType + ' - ' + @schema + '.' + @object;
    ELSE
      PRINT '  ' + @eventType + ' - ' + @schema;

    IF @eventType IS NULL
      PRINT CONVERT(NVARCHAR(max), @data);


    INSERT [AuditDB].[dbo].[DDLEvents]
           ([DatabaseUserName]
            ,[EventType]
            ,[TSQL]
            ,[XmlEvent]
            ,[DatabaseName]
            ,[SchemaName]
            ,[ObjectName]
            ,[HostName]
            ,[IPAddress]
            ,[ProgramName]
            ,[LoginName])
    SELECT
      CONVERT(SYSNAME, CURRENT_USER)
      ,@eventType
      ,@sql
      ,@data
      ,DB_NAME()
      ,CONVERT(SYSNAME, @schema)
      ,CONVERT(SYSNAME, @object)
      ,HOST_NAME()
      ,@ip
      ,PROGRAM_NAME()
      ,SUSER_NAME();
  END;
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO 
