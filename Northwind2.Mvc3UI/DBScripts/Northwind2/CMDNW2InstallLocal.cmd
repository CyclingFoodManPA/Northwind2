ECHO OFF
				
REM     *************************************************************
REM                          Install.BAT.
REM     This file builds the Northwind2 database for use in my 
REM     C#.Net application
REM
REM     *************************************************************

CLS
TYPE Northwind2_1.txt
PAUSE
ECHO ON

DEL Northwind2.log

REM Get the computer name from the Windows environment variable.
set CAU_ComputerName=%ComputerName%
set CAU_SQLConnection=%ComputerName%
set CAU_AccountName=%CAU_ComputerName%\ASPNET

REM Create the BelAir DB, tables, and all SP
SQLCMD -E -S %CAU_SQLConnection% -i 0-CurrentTimestamp.SQL			    >> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 1a-NW2CreateDB.SQL 					>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 1b-NW2DDLTrigger.SQL				>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 1c-NW2UDFCreate.SQL					>> Northwind2.log

SQLCMD -E -S %CAU_SQLConnection% -i 2a-NW2CreateSchema.SQL 				>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 2b-NW2CreateTables_PK_FK_IDX.SQL    >> Northwind2.log

SQLCMD -E -S %CAU_SQLConnection% -i 3a-NW2SPROCSdbo.SQL					>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 3a-NW2SPROCSSecurity.SQL			>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 3b-NW2SPROCSAdministration.SQL		>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 3c-NW2SPROCSCustomers.SQL			>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 3d-NW2SPROCSHumanResources.SQL		>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 3e-NW2SPROCSProducts.SQL			>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 3f-NW2SPROCSSales.SQL				>> Northwind2.log

SQLCMD -E -S %CAU_SQLConnection% -i 4a-NW2AdministrationInserts.SQL		>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 4a-NW2SecurityInserts.SQL			>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 4b-NW2ProductInserts.SQL			>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 4c-NW2CustomerInserts.SQL			>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 4d-NW2EmployeeInserts.SQL			>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 4e-NW2SalesInserts.SQL				>> Northwind2.log

SQLCMD -E -S %CAU_SQLConnection% -i 88-RecordCounts.SQL					>> Northwind2.log
SQLCMD -E -S %CAU_SQLConnection% -i 0-CurrentTimestamp.SQL			    >> Northwind2.log
REM SQLCMD -E -S %CAU_SQLConnection% -d Northwind2 -Q "sp_grantlogin '%CAU_ACCOUNTNAME%'"
REM SQLCMD -E -S %CAU_SQLConnection% -d Northwind2 -Q "sp_grantdbaccess '%CAU_ACCOUNTNAME%'"
REM SQLCMD -E -S %CAU_SQLConnection% -d Northwind2 -Q "sp_addrolemember 'db_owner', '%CAU_ACCOUNTNAME%'"
										
ECHO OFF
TYPE Northwind2_2.txt
PAUSE
ECHO ON

                  