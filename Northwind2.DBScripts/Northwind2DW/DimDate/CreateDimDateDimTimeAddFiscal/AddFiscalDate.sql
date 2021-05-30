--This script will add Fiscal columns to the DimDate Table
--This script will set the Start date and end below to the first and last date on your dim date table
--The following Colums wil be created: Fiscal Year, FiscalQuarter, FiscalQuarterName, FiscalMonth

--SET THE @DaysOffSet VARIABLE TO OFFSET THE DATE
ALTER TABLE DimDate
  ADD FiscalMonth INT
ALTER TABLE DimDate
  ADD FiscalQuarter INT
ALTER TABLE DimDate
  ADD FiscalQuarterName VARCHAR(6)
ALTER TABLE DimDate
  ADD FiscalYear CHAR(10)
Go

DECLARE @MonthOffSet INT
--If your Fiscal Year starts on October of the previous year then set this variable to 3 --------------------------
--If your Fiscal Year starts after the start of the calendar year set it to a negative number of months------------
SELECT
  @MonthOffSet = 3

--Declare all of the needed varables
DECLARE
  @StartDate        DATETIME
  ,@EndDate         DATETIME
  ,@Date            DATETIME
  ,@MonthNumber     INT
  ,@QuarterName     VARCHAR(6)
  ,@QuarterNumber   INT
  ,@FirstFiscalDate DATE
  ,@FiscalYear      CHAR(10)


--Get first and last date 
SELECT
  @StartDate = (SELECT
                  MIN([Date])
                FROM
                  [DimDate])
SELECT
  @EndDate = (SELECT
                MAX([Date])
              FROM
                [DimDate])
SELECT
  @Date = @StartDate

--set the first date of the fiscal year
SELECT
  @FirstFiscalDate = DATEADD(Month,
                             -1 * @MonthOffSet,
                             @Date)

--Loop through each date
WHILE @Date <= @EndDate
  BEGIN
    --Set the number of months off set
    SELECT
      @MonthNumber = MONTH(@Date) + @MonthOffSet
    SELECT
      @MonthNumber = CASE
                       WHEN @MonthNumber > 12 THEN @MonthNumber - 12
                       WHEN @MonthNumber < 1 THEN @MonthNumber + 12
                       ELSE @MonthNumber
                     END

    -- Set the Quarter off set
    SELECT
      @QuarterNumber = CASE
                         WHEN @MonthNumber = 1
                               OR @MonthNumber = 2
                               OR @MonthNumber = 3 THEN 1
                         WHEN @MonthNumber = 4
                               OR @MonthNumber = 5
                               OR @MonthNumber = 6 THEN 2
                         WHEN @MonthNumber = 7
                               OR @MonthNumber = 8
                               OR @MonthNumber = 9 THEN 3
                         ELSE 4
                       END

    SELECT
      @QuarterName = CASE @QuarterNumber
                       WHEN 1 THEN 'First'
                       WHEN 2 THEN 'Second'
                       WHEN 3 THEN 'Third'
                       WHEN 4 THEN 'Forth'
                       ELSE 'Error'
                     END

    --Determine the fiscal year
    SELECT
      @FiscalYear = CASE
                      WHEN MONTH(@date) < MONTH(@FirstFiscalDate) THEN CONVERT(VARCHAR(2), RIGHT((DATEPART(YEAR, @Date)-1), 2))
                                                                       + '/'
                                                                       + CONVERT(VARCHAR(2), RIGHT(DATEPART(YEAR, @Date), 2))
                      ELSE CONVERT(VARCHAR(2), RIGHT((DATEPART(YEAR, @Date)), 2))
                           + '/'
                           + CONVERT(VARCHAR(2), RIGHT(DATEPART(YEAR, @Date)+1, 2))
                    END

    --Update the table with the fical numbers
    UPDATE DimDate
    SET    FiscalMonth = @MonthNumber
           ,FiscalQuarter = @QuarterNumber
           ,FiscalQuarterName = @QuarterName
           ,FiscalYear = 'FY ' + @FiscalYear
    WHERE
      Date = @Date

    --Increment the date by one day
    SELECT
      @Date = DATEADD(dd,
                      1,
                      @Date)
  END

PRINT CONVERT(VARCHAR, GETDATE(), 113)--USED FOR CHECKING RUN TIME.

--DimDate indexes---------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX [IDX_DimDate_FiscalMonth]
  ON [dbo].[DimDate] ( [FiscalMonth] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimDate_FiscalMonthName]
  ON [dbo].[DimDate] ( [MonthName] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimDate_FiscalQuarter]
  ON [dbo].[DimDate] ( [FiscalQuarter] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimDate_FiscalQuarterName]
  ON [dbo].[DimDate] ( [FiscalQuarterName] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimDate_FiscalYear]
  ON [dbo].[DimDate] ( [FiscalYear] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

PRINT CONVERT(VARCHAR, GETDATE(), 113)--USED FOR CHECKING RUN TIME.
