ECHO OFF
				
REM     *************************************************************
REM                          Install.BAT.
REM     This file builds the Northwind2 database for use in my 
REM     C#.Net application
REM
REM     *************************************************************

CLS
TYPE Northwind2DW1.txt
PAUSE
ECHO ON

DEL Northwind2DW.log

REM Get the computer name from the Windows environment variable.
set CAU_ComputerName=%ComputerName%
set CAU_SQLConnection=%ComputerName%
set CAU_AccountName=%CAU_ComputerName%\ASPNET

REM Create the BelAir DB, tables, and all SP
SQLCMD -E -S %CAU_SQLConnection% -i 0-CurrentTimestamp.SQL				>> Northwind2DW.log
SQLCMD -E -S %CAU_SQLConnection% -i 1a-NW2DWCreateDB.SQL 				>> Northwind2DW.log
SQLCMD -E -S %CAU_SQLConnection% -i 1b-NW2DWDDLTriggerCreate.SQL		>> Northwind2DW.log
SQLCMD -E -S %CAU_SQLConnection% -i 1c-NW2DWUDFCreate.SQL				>> Northwind2DW.log
SQLCMD -E -S %CAU_SQLConnection% -i 2a-NW2DWCreateTables_PK_FK_IDX.SQL 	>> Northwind2DW.log
SQLCMD -E -S %CAU_SQLConnection% -i 3a-NW2DWPopulateDimFact.SQL 	    >> Northwind2DW.log
SQLCMD -E -S %CAU_SQLConnection% -i 3b-NW2DWPopulateDimDate.SQL 	    >> Northwind2DW.log
SQLCMD -E -S %CAU_SQLConnection% -i 88-RecordCounts.SQL					>> Northwind2DW.log
SQLCMD -E -S %CAU_SQLConnection% -i 0-CurrentTimestamp.SQL				>> Northwind2DW.log
REM SQLCMD -E -S %CAU_SQLConnection% -d Northwind2 -Q "sp_grantlogin '%CAU_ACCOUNTNAME%'"
REM SQLCMD -E -S %CAU_SQLConnection% -d Northwind2 -Q "sp_grantdbaccess '%CAU_ACCOUNTNAME%'"
REM SQLCMD -E -S %CAU_SQLConnection% -d Northwind2 -Q "sp_addrolemember 'db_owner', '%CAU_ACCOUNTNAME%'"
										
ECHO OFF
TYPE Northwind2DW2.txt
PAUSE
ECHO ON

                  