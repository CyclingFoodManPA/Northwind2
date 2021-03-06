/*
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/

SET NOCOUNT ON
GO

USE [Master]
GO
IF EXISTS
   (SELECT
      *
    FROM
      sysdatabases
    WHERE
     name = 'Northwind2')
  DROP DATABASE Northwind2
go

DECLARE @device_directory NVARCHAR(520)
SELECT
  @device_directory = SUBSTRING(filename,
                                1,
                                CHARINDEX(N'master.mdf',
                                          LOWER(filename)) - 1)
FROM
  master.dbo.sysaltfiles
WHERE
  dbid = 1
  AND fileid = 1

EXECUTE (N'CREATE DATABASE Northwind2
  ON PRIMARY (NAME = N''Northwind2_Data'', FILENAME = N''' + @device_directory + N'Northwind2_Data.mdf'')
  LOG ON (NAME = N''Northwind2_Log'',  FILENAME = N''' + @device_directory + N'Northwind2_Log.ldf'')')
go

-- Set database compatibility level to:
-- 120 - SQL Server 2014
-- 110 - SQL Server 2012
-- 100 - SQL Server 2008
--  90 - SQL Server 2005
EXEC dbo.Sp_dbcmptlevel
  @dbname       =N'Northwind2',
  @new_cmptlevel=110
GO

ALTER DATABASE [Northwind2]
SET ANSI_NULL_DEFAULT OFF
GO

ALTER DATABASE [Northwind2]
SET ANSI_NULLS OFF
GO

ALTER DATABASE [Northwind2]
SET ANSI_PADDING OFF
GO

ALTER DATABASE [Northwind2]
SET ANSI_WARNINGS OFF
GO

ALTER DATABASE [Northwind2]
SET ARITHABORT OFF
GO

ALTER DATABASE [Northwind2]
SET AUTO_CLOSE ON
GO

ALTER DATABASE [Northwind2]
SET AUTO_CREATE_STATISTICS ON
GO

ALTER DATABASE [Northwind2]
SET AUTO_SHRINK OFF
GO

ALTER DATABASE [Northwind2]
SET AUTO_UPDATE_STATISTICS ON
GO

ALTER DATABASE [Northwind2]
SET CURSOR_CLOSE_ON_COMMIT OFF
GO

ALTER DATABASE [Northwind2]
SET CURSOR_DEFAULT GLOBAL
GO

ALTER DATABASE [Northwind2]
SET CONCAT_NULL_YIELDS_NULL OFF
GO

ALTER DATABASE [Northwind2]
SET NUMERIC_ROUNDABORT OFF
GO

ALTER DATABASE [Northwind2]
SET QUOTED_IDENTIFIER OFF
GO

ALTER DATABASE [Northwind2]
SET RECURSIVE_TRIGGERS OFF
GO

ALTER DATABASE [Northwind2]
SET ENABLE_BROKER
GO

ALTER DATABASE [Northwind2]
SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO

ALTER DATABASE [Northwind2]
SET DATE_CORRELATION_OPTIMIZATION OFF
GO

ALTER DATABASE [Northwind2]
SET TRUSTWORTHY OFF
GO

ALTER DATABASE [Northwind2]
SET ALLOW_SNAPSHOT_ISOLATION OFF
GO

ALTER DATABASE [Northwind2]
SET PARAMETERIZATION SIMPLE
GO

ALTER DATABASE [Northwind2]
SET READ_COMMITTED_SNAPSHOT OFF
GO

ALTER DATABASE [Northwind2]
SET HONOR_BROKER_PRIORITY OFF
GO

ALTER DATABASE [Northwind2]
SET READ_WRITE
GO

ALTER DATABASE [Northwind2]
SET RECOVERY SIMPLE
GO

ALTER DATABASE [Northwind2]
SET MULTI_USER
GO

ALTER DATABASE [Northwind2]
SET PAGE_VERIFY CHECKSUM
GO

ALTER DATABASE [Northwind2]
SET DB_CHAINING OFF
GO 
