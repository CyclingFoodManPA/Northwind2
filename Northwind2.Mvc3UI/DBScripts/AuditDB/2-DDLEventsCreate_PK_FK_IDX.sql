/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v5.2.3                     */
/* Target DBMS:           MS SQL Server 2008                              */
/* Project file:          AuditDB.dez                                     */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database creation script                        */
/* Created on:            2015-03-24 11:50                                */
/* Model version:         Version 2015-03-24 6                            */
/* ---------------------------------------------------------------------- */


USE [AuditDB]
GO

/* ---------------------------------------------------------------------- */
/* Tables                                                                 */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "DDLEvents"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[DDLEvents] (
    [DDLEventsID] INTEGER IDENTITY(1,1) NOT NULL,
    [PostTime] DATETIME2 CONSTRAINT [DEF_DDLEvents_PostTime] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [DatabaseUserName] SYSNAME NOT NULL,
    [EventType] SYSNAME NOT NULL,
    [TSQL] NVARCHAR(MAX) NOT NULL,
    [XmlEvent] XML NOT NULL,
    [DatabaseName] NVARCHAR(255) NOT NULL,
    [SchemaName] SYSNAME,
    [ObjectName] SYSNAME,
    [HostName] VARCHAR(64) NOT NULL,
    [IPAddress] VARCHAR(32) NOT NULL,
    [ProgramName] NVARCHAR(255) NOT NULL,
    [LoginName] NVARCHAR(255) NOT NULL,
    [Modified] TIMESTAMP NOT NULL,
    CONSTRAINT [PK_DDLEvents] PRIMARY KEY ([DDLEventsID])
)
GO

CREATE NONCLUSTERED INDEX [IDX_DDLEvents_1] ON [dbo].[DDLEvents] ([PostTime] DESC)
GO

CREATE NONCLUSTERED INDEX [IDX_DDLEvents_2] ON [dbo].[DDLEvents] ([DatabaseUserName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DDLEvents_3] ON [dbo].[DDLEvents] ([EventType] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DDLEvents_4] ON [dbo].[DDLEvents] ([DatabaseName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DDLEvents_5] ON [dbo].[DDLEvents] ([SchemaName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DDLEvents_6] ON [dbo].[DDLEvents] ([ObjectName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DDLEvents_7] ON [dbo].[DDLEvents] ([HostName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DDLEvents_8] ON [dbo].[DDLEvents] ([IPAddress] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DDLEvents_9] ON [dbo].[DDLEvents] ([ProgramName] ASC)
GO

CREATE NONCLUSTERED INDEX [IDX_DDLEvents_10] ON [dbo].[DDLEvents] ([LoginName] ASC)
GO

/* ---------------------------------------------------------------------- */
/* Add table "ErrorLog"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE [dbo].[ErrorLog] (
    [ErrorLogID] INTEGER IDENTITY(1,1) NOT NULL,
    [ErrorTime] DATETIME2 CONSTRAINT [DEF_ErrorLog_ErrorTime] DEFAULT CURRENT_TIMESTAMP NOT NULL,
    [UserName] SYSNAME NOT NULL,
    [ErrorNumber] INTEGER NOT NULL,
    [ErrorSeverity] INTEGER,
    [ErrorState] INTEGER,
    [ErrorProcedure] NVARCHAR(500),
    [ErrorLine] INTEGER,
    [ErrorMessage] NVARCHAR(4000) NOT NULL,
    CONSTRAINT [PK_ErrorLog] PRIMARY KEY ([ErrorLogID])
)
GO

CREATE NONCLUSTERED INDEX [IDX_ErrorLog_1] ON [dbo].[ErrorLog] ([ErrorTime] DESC)
GO

CREATE NONCLUSTERED INDEX [IDX_ErrorLog_2] ON [dbo].[ErrorLog] ([UserName] ASC)
GO
