USE Northwind2DW
GO


SET NOCOUNT ON
GO

--Populate Date dimension

TRUNCATE TABLE DimDate

--IF YOU ARE USING THE YYYYMMDD format for the primary key then you need to comment out this line.
--DBCC CHECKIDENT (DimDate, RESEED, 60000) --In case you need to add earlier dates later.

DECLARE @tmpDOW TABLE
(
   DOW   INT
   ,Cntr INT
)--Table for counting DOW occurance in a month
INSERT INTO @tmpDOW
            (DOW
             ,Cntr)
VALUES     (1
            ,0)--Used in the loop below
INSERT INTO @tmpDOW
            (DOW
             ,Cntr)
VALUES     (2
            ,0)
INSERT INTO @tmpDOW
            (DOW
             ,Cntr)
VALUES     (3
            ,0)
INSERT INTO @tmpDOW
            (DOW
             ,Cntr)
VALUES     (4
            ,0)
INSERT INTO @tmpDOW
            (DOW
             ,Cntr)
VALUES     (5
            ,0)
INSERT INTO @tmpDOW
            (DOW
             ,Cntr)
VALUES     (6
            ,0)
INSERT INTO @tmpDOW
            (DOW
             ,Cntr)
VALUES     (7
            ,0)

DECLARE
  @StartDate     DATETIME
  ,@EndDate      DATETIME
  ,@Date         DATETIME
  ,@WDofMonth    INT
  ,@CurrentMonth INT

SELECT
  @StartDate = '1/1/2000' -- Set The start and end date 
  ,@EndDate = '1/1/2020'--Non inclusive. Stops on the day before this.
  ,@CurrentMonth = 1 --Counter used in loop below.

SELECT
  @Date = @StartDate

WHILE @Date < @EndDate
  BEGIN
    IF DATEPART(MONTH,
                @Date) <> @CurrentMonth
      BEGIN
        SELECT
          @CurrentMonth = DATEPART(MONTH,
                                   @Date)
        UPDATE @tmpDOW
        SET    Cntr = 0
      END

    UPDATE @tmpDOW
    SET    Cntr = Cntr + 1
    WHERE
      DOW = DATEPART(DW,
                     @DATE)

    SELECT
      @WDofMonth = Cntr
    FROM
      @tmpDOW
    WHERE
      DOW = DATEPART(DW,
                     @DATE)

    INSERT INTO DimDate
                ([DateKey]
                 ,--TO MAKE THE DateKey THE YYYYMMDD FORMAT UNCOMMENT THIS LINE... Comment for autoincrementing.
                 [Date]
                 ,[Day]
                 ,[DaySuffix]
                 ,[DayOfWeek]
                 ,[DayOfWeekInMonth]
                 ,[DayOfYear]
                 ,[WeekOfYear]
                 ,[WeekOfMonth]
                 ,[Month]
                 ,[MonthName]
                 ,[Quarter]
                 ,[QuarterName]
                 ,[Year]
                 ,[StandardDate])
    SELECT
      CONVERT(VARCHAR, @Date, 112)
      ,--TO MAKE THE DateKey THE YYYYMMDD FORMAT UNCOMMENT THIS LINE COMMENT FOR AUTOINCREMENT
      @Date                                                                       [Date]
      ,DATEPART(DAY,
                @DATE)                                                            [Day]
      ,CASE
         WHEN DATEPART(DAY,
                       @DATE) IN ( 11, 12, 13 ) THEN CAST(DATEPART(DAY, @DATE) AS VARCHAR)
                                                     + 'th'
         WHEN RIGHT(DATEPART(DAY,
                             @DATE),
                    1) = 1 THEN CAST(DATEPART(DAY, @DATE) AS VARCHAR)
                                + 'st'
         WHEN RIGHT(DATEPART(DAY,
                             @DATE),
                    1) = 2 THEN CAST(DATEPART(DAY, @DATE) AS VARCHAR)
                                + 'nd'
         WHEN RIGHT(DATEPART(DAY,
                             @DATE),
                    1) = 3 THEN CAST(DATEPART(DAY, @DATE) AS VARCHAR)
                                + 'rd'
         ELSE CAST(DATEPART(DAY, @DATE) AS VARCHAR)
              + 'th'
       END                                                                        AS [DaySuffix]
      ,CASE DATEPART(DW,
                     @DATE)
         WHEN 1 THEN 'Sunday'
         WHEN 2 THEN 'Monday'
         WHEN 3 THEN 'Tuesday'
         WHEN 4 THEN 'Wednesday'
         WHEN 5 THEN 'Thursday'
         WHEN 6 THEN 'Friday'
         WHEN 7 THEN 'Saturday'
       END                                                                        AS [DayOfWeek]
      ,@WDofMonth                                                                 [DayOfWeekInMonth]--Occurance of this day in this month. If Third Monday then 3 and DOW would be Monday.
      ,DATEPART(dy,
                @Date)                                                            [DayOfYear]--Day of the year. 0 - 365/366
      ,DATEPART(ww,
                @Date)                                                            [WeekOfYear]--0-52/53
      ,DATEPART(ww, @Date) + 1 - DATEPART(ww,
                                          CAST(DATEPART(mm, @Date) AS VARCHAR)
                                          + '/1/'
                                          + CAST(DATEPART(yy, @Date) AS VARCHAR)) [WeekOfMonth]
      ,DATEPART(MONTH,
                @DATE)                                                            [Month]--To be converted with leading zero later. 
      ,DATENAME(MONTH,
                @DATE)                                                            [MonthName]
      ,DATEPART(qq,
                @DATE)                                                            [Quarter]--Calendar quarter
      ,CASE DATEPART(qq,
                     @DATE)
         WHEN 1 THEN 'First'
         WHEN 2 THEN 'Second'
         WHEN 3 THEN 'Third'
         WHEN 4 THEN 'Fourth'
       END                                                                        AS [QuarterName]
      ,DATEPART(YEAR,
                @Date)                                                            [Year]
      ,RIGHT('0' + CONVERT(VARCHAR(2), MONTH(@Date)), 2)
       + '/'
       + RIGHT('0' + CONVERT(VARCHAR(2), DAY(@Date)), 2)
       + '/' + CONVERT(VARCHAR(4), YEAR(@Date))

    SELECT
      @Date = DATEADD(dd,
                      1,
                      @Date)
  END


--Add HOLIDAYS --------------------------------------------------------------------------------------------------------------
--THANKSGIVING --------------------------------------------------------------------------------------------------------------
--Fourth THURSDAY in November.
UPDATE DimDate
SET    HolidayText = 'Thanksgiving Day'
WHERE
  [MONTH] = 11
  AND [DAYOFWEEK] = 'Thursday'
  AND [DayOfWeekInMonth] = 4
GO

--CHRISTMAS -------------------------------------------------------------------------------------------
UPDATE dbo.DimDate
SET    HolidayText = 'Christmas Day'
WHERE
  [MONTH] = 12
  AND [DAY] = 25

--4th of July ---------------------------------------------------------------------------------------------
UPDATE dbo.DimDate
SET    HolidayText = 'Independance Day'
WHERE
  [MONTH] = 7
  AND [DAY] = 4

-- New Years Day ---------------------------------------------------------------------------------------------
UPDATE dbo.DimDate
SET    HolidayText = 'New Year''s Day'
WHERE
  [MONTH] = 1
  AND [DAY] = 1

--Memorial Day ----------------------------------------------------------------------------------------
--Last Monday in May
UPDATE dbo.DimDate
SET    HolidayText = 'Memorial Day'
FROM   DimDate
WHERE
  DateKey IN
  (SELECT
     MAX([DateKey])
   FROM
     dbo.DimDate
   WHERE
    [MonthName] = 'May'
    AND [DayOfWeek] = 'Monday'
   GROUP  BY [YEAR]
             ,[MONTH])
--Labor Day -------------------------------------------------------------------------------------------
--First Monday in September
UPDATE dbo.DimDate
SET    HolidayText = 'Labor Day'
FROM   DimDate
WHERE
  DateKey IN
  (SELECT
     MIN([DateKey])
   FROM
     dbo.DimDate
   WHERE
    [MonthName] = 'September'
    AND [DayOfWeek] = 'Monday'
   GROUP  BY [YEAR]
             ,[MONTH])

-- Valentine's Day ---------------------------------------------------------------------------------------------
UPDATE dbo.DimDate
SET    HolidayText = 'Valentine''s Day'
WHERE
  [MONTH] = 2
  AND [DAY] = 14

-- Saint Patrick's Day -----------------------------------------------------------------------------------------
UPDATE dbo.DimDate
SET    HolidayText = 'Saint Patrick''s Day'
WHERE
  [MONTH] = 3
  AND [DAY] = 17
GO
--Martin Luthor King Day ---------------------------------------------------------------------------------------
--Third Monday in January starting in 1983
UPDATE DimDate
SET    HolidayText = 'Martin Luthor King Jr Day'
WHERE
  [MONTH] = 1--January
  AND [Dayofweek] = 'Monday'
  AND [YEAR] >= 1983--When holiday was official
  AND [DayOfWeekInMonth] = 3--Third X day of current month.
GO
--President's Day ---------------------------------------------------------------------------------------
--Third Monday in February.
UPDATE DimDate
SET    HolidayText = 'President''s Day'--select * from DimDate
WHERE
  [MONTH] = 2--February
  AND [Dayofweek] = 'Monday'
  AND [DayOfWeekInMonth] = 3--Third occurance of a monday in this month.
GO
--Mother's Day ---------------------------------------------------------------------------------------
--Second Sunday of May
UPDATE DimDate
SET    HolidayText = 'Mother''s Day'--select * from DimDate
WHERE
  [MONTH] = 5--May
  AND [Dayofweek] = 'Sunday'
  AND [DayOfWeekInMonth] = 2--Second occurance of a monday in this month.
GO
--Father's Day ---------------------------------------------------------------------------------------
--Third Sunday of June
UPDATE DimDate
SET    HolidayText = 'Father''s Day'--select * from DimDate
WHERE
  [MONTH] = 6--June
  AND [Dayofweek] = 'Sunday'
  AND [DayOfWeekInMonth] = 3--Third occurance of a monday in this month.
GO
--Halloween 10/31 ----------------------------------------------------------------------------------
UPDATE dbo.DimDate
SET    HolidayText = 'Halloween'
WHERE
  [MONTH] = 10
  AND [DAY] = 31
--Election Day--------------------------------------------------------------------------------------
--The first Tuesday after the first Monday in November.
BEGIN TRY
  DROP TABLE #tmpHoliday
END TRY
BEGIN CATCH
--do nothing
END CATCH

CREATE TABLE #tmpHoliday
(
   ID      INT IDENTITY(1, 1)
   ,DateID INT
   ,Week   TINYINT
   ,YEAR   CHAR(4)
   ,DAY    CHAR(2)
)

INSERT INTO #tmpHoliday
            (DateID
             ,[YEAR]
             ,[DAY])
SELECT
  [DateKey]
  ,[YEAR]
  ,[DAY]
FROM
  dbo.DimDate
WHERE
  [MONTH] = 11
  AND [Dayofweek] = 'Monday'
ORDER  BY YEAR
          ,DAY

DECLARE
  @CNTR         INT
  ,@POS         INT
  ,@STARTYEAR   INT
  ,@ENDYEAR     INT
  ,@CURRENTYEAR INT
  ,@MINDAY      INT

SELECT
  @CURRENTYEAR = MIN([YEAR])
  ,@STARTYEAR = MIN([YEAR])
  ,@ENDYEAR = MAX([YEAR])
FROM
  #tmpHoliday

WHILE @CURRENTYEAR <= @ENDYEAR
  BEGIN
    SELECT
      @CNTR = COUNT([YEAR])
    FROM
      #tmpHoliday
    WHERE
      [YEAR] = @CURRENTYEAR

    SET @POS = 1

    WHILE @POS <= @CNTR
      BEGIN
        SELECT
          @MINDAY = MIN(DAY)
        FROM
          #tmpHoliday
        WHERE
          [YEAR] = @CURRENTYEAR
          AND [WEEK] IS NULL

        UPDATE #tmpHoliday
        SET    [WEEK] = @POS
        WHERE
          [YEAR] = @CURRENTYEAR
          AND [DAY] = @MINDAY

        SELECT
          @POS = @POS + 1
      END

    SELECT
      @CURRENTYEAR = @CURRENTYEAR + 1
  END

UPDATE DT
SET    HolidayText = 'Election Day'
FROM   dbo.DimDate DT
       JOIN #tmpHoliday HL
         ON ( HL.DateID + 1 ) = DT.DateKey
WHERE
  [WEEK] = 1

DROP TABLE #tmpHoliday
GO