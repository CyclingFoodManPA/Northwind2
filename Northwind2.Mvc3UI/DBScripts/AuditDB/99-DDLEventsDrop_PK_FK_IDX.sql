/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v5.2.3                     */
/* Target DBMS:           MS SQL Server 2008                              */
/* Project file:          AuditDB.dez                                     */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database drop script                            */
/* Created on:            2015-03-24 11:50                                */
/* Model version:         Version 2015-03-24 6                            */
/* ---------------------------------------------------------------------- */


USE AuditDB
GO

/* ---------------------------------------------------------------------- */
/* Drop table "DDLEvents"                                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[DDLEvents] DROP CONSTRAINT [DEF_DDLEvents_PostTime]
GO

ALTER TABLE [dbo].[DDLEvents] DROP CONSTRAINT [PK_DDLEvents]
GO

/* Drop table */

DROP TABLE [dbo].[DDLEvents]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "ErrorLog"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [dbo].[ErrorLog] DROP CONSTRAINT [DEF_ErrorLog_ErrorTime]
GO

ALTER TABLE [dbo].[ErrorLog] DROP CONSTRAINT [PK_ErrorLog]
GO

/* Drop table */

DROP TABLE [dbo].[ErrorLog]
GO
