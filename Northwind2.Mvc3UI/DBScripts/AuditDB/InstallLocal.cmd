ECHO OFF
				
REM     *************************************************************
REM                          Install.BAT.
REM     This file builds the AuditDB database for use in my C#.Net 
REM     application
REM
REM     *************************************************************

CLS
TYPE AuditDB.txt
PAUSE
ECHO ON

DEL AuditDB.log

REM Get the computer name from the Windows environment variable.
set CAU_ComputerName=%ComputerName%
set CAU_SQLConnection=%ComputerName%
set CAU_AccountName=%CAU_ComputerName%\ASPNET

REM Create the BelAir DB, tables, and all SP
SQLCMD -E -S %CAU_SQLConnection% -i 0-CurrentTimestamp.SQL				>> AuditDB.log
SQLCMD -E -S %CAU_SQLConnection% -i 1-CreateDB.SQL 						>> AuditDB.log
SQLCMD -E -S %CAU_SQLConnection% -i 2-DDLEventsCreate_PK_FK_IDX.SQL 	>> AuditDB.log
SQLCMD -E -S %CAU_SQLConnection% -i 3-UDFCreate.SQL 					>> AuditDB.log
SQLCMD -E -S %CAU_SQLConnection% -i 4-SPROCSdbo.SQL						>> AuditDB.log
SQLCMD -E -S %CAU_SQLConnection% -i 0-CurrentTimestamp.SQL				>> AuditDB.log
REM SQLCMD -E -S %CAU_SQLConnection% -d Northwind2 -Q "sp_grantlogin '%CAU_ACCOUNTNAME%'"
REM SQLCMD -E -S %CAU_SQLConnection% -d Northwind2 -Q "sp_grantdbaccess '%CAU_ACCOUNTNAME%'"
REM SQLCMD -E -S %CAU_SQLConnection% -d Northwind2 -Q "sp_addrolemember 'db_owner', '%CAU_ACCOUNTNAME%'"
										
ECHO OFF
TYPE AuditDB2.txt
PAUSE
ECHO ON

                  