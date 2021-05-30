--This script will add Fiscal columns to the DimDate Table
--This script will set the Start date and end below to the first and last date on your dim date table
--The following Colums wil be created: Fiscal Year, FiscalQuarter, FiscalQuarterName, FiscalMonth

--SET THE @DaysOffSet VARIABLE TO OFFSET THE DATE
Alter Table DimDate Add FiscalMonth int
Alter Table DimDate Add FiscalQuarter int
Alter Table DimDate Add FiscalQuarterName Varchar(6)
Alter Table DimDate Add FiscalYear char(10)
Go

Declare @MonthOffSet int
--If your Fiscal Year starts on October of the previous year then set this variable to 3 --------------------------
--If your Fiscal Year starts after the start of the calendar year set it to a negative number of months------------
Select @MonthOffSet = 3

--Declare all of the needed varables
DECLARE @StartDate datetime
 , @EndDate datetime
 , @Date datetime
 , @MonthNumber int
 , @QuarterName varchar(6)
 , @QuarterNumber int
 , @FirstFiscalDate date
 , @FiscalYear char(10)


--Get first and last date 
SELECT @StartDate = (Select Min([Date]) from [DimDate])
Select @EndDate = (Select Max([Date]) from [DimDate])
SELECT @Date = @StartDate

--set the first date of the fiscal year
SELECT @FirstFiscalDate = DATEADD(Month,-1*@MonthOffSet,@Date)

--Loop through each date
WHILE @Date <= @EndDate
 BEGIN
 --Set the number of months off set
 Select @MonthNumber = Month(@Date) + @MonthOffSet
 Select @MonthNumber =
 Case When @MonthNumber > 12 then @MonthNumber - 12 
	  When @MonthNumber < 1 then @MonthNumber + 12 
	  Else @MonthNumber End
	  
 -- Set the Quarter off set
 Select @QuarterNumber = 
 Case When @MonthNumber = 1 or @MonthNumber = 2 or @MonthNumber =3 Then 1
 When @MonthNumber = 4 or @MonthNumber = 5 or @MonthNumber = 6 Then 2
 When @MonthNumber = 7 or @MonthNumber = 8 or @MonthNumber = 9 Then 3
 Else 4 End
 
 Select @QuarterName =
 Case @QuarterNumber  
	  When 1
		 Then 'First'
	  When 2
		 Then 'Second'
	  When 3
		 Then 'Third'
	  When 4
		 Then 'Forth'
	  Else 'Error'
 End
 
 --Determine the fiscal year
 Select @FiscalYear = 
 Case When MONTH(@date) < MONTH(@FirstFiscalDate) Then  
	convert(varchar(2),right((DATEPART(YEAR,@Date)-1),2)) + '/' + convert(varchar(2),right(DATEPART(YEAR,@Date),2))
	  Else convert(varchar(2),right((DATEPART(YEAR,@Date)),2)) + '/' + convert(varchar(2),right(DATEPART(YEAR,@Date)+1,2)) 
 End

--Update the table with the fical numbers
Update DimDate
 Set 
 FiscalMonth = @MonthNumber,
 FiscalQuarter = @QuarterNumber,
 FiscalQuarterName = @QuarterName,
 FiscalYear = 'FY ' + @FiscalYear
 Where Date = @Date
 
 --Increment the date by one day
  SELECT @Date = DATEADD(dd,1,@Date)
 END

PRINT CONVERT(VARCHAR,GETDATE(),113)--USED FOR CHECKING RUN TIME.

--DimDate indexes---------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX [IDX_DimDate_FiscalMonth] ON [dbo].[DimDate] 
(
[FiscalMonth] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimDate_FiscalMonthName] ON [dbo].[DimDate] 
(
[MonthName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimDate_FiscalQuarter] ON [dbo].[DimDate] 
(
[FiscalQuarter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimDate_FiscalQuarterName] ON [dbo].[DimDate] 
(
[FiscalQuarterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimDate_FiscalYear] ON [dbo].[DimDate] 
(
[FiscalYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

PRINT convert(varchar,getdate(),113)--USED FOR CHECKING RUN TIME.