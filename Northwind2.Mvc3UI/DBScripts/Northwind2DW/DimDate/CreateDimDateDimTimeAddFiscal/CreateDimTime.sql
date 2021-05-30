SET ANSI_PADDING OFF
BEGIN TRY
  DROP TABLE [DimTime]
END TRY
BEGIN CATCH
--DO NOTHING
END CATCH

CREATE TABLE [dbo].[DimTime]
(
   [TimeSK]        [INT] IDENTITY(1, 1) NOT NULL
   ,[Time]         [CHAR](8) NOT NULL
   ,[Hour]         [CHAR](2) NOT NULL
   ,[MilitaryHour] [CHAR](2) NOT NULL
   ,[Minute]       [CHAR](2) NOT NULL
   ,[Second]       [CHAR](2) NOT NULL
   ,[AmPm]         [CHAR](2) NOT NULL
   ,[StandardTime] [CHAR](11) NULL,
   CONSTRAINT [PK_DimTime] PRIMARY KEY CLUSTERED ( [TimeSK] ASC )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]

GO
SET ANSI_PADDING OFF

PRINT CONVERT(VARCHAR, GETDATE(), 113)--USED FOR CHECKING RUN TIME.

--Load time data for every second of a day
DECLARE @Time DATETIME

SET @TIME = CONVERT(VARCHAR, '12:00:00 AM', 108)

TRUNCATE TABLE DimTime

WHILE @TIME <= '11:59:59 PM'
  BEGIN
    INSERT INTO dbo.DimTime
                ([Time]
                 ,[Hour]
                 ,[MilitaryHour]
                 ,[Minute]
                 ,[Second]
                 ,[AmPm])
    SELECT
      CONVERT(VARCHAR, @TIME, 108) [Time]
      ,CASE
         WHEN DATEPART(HOUR,
                       @Time) > 12 THEN DATEPART(HOUR,
                                                 @Time) - 12
         ELSE DATEPART(HOUR,
                       @Time)
       END                         AS [Hour]
      ,CAST(SUBSTRING(CONVERT(VARCHAR, @TIME, 108),
                      1,
                      2) AS INT)   [MilitaryHour]
      ,DATEPART(MINUTE,
                @Time)             [Minute]
      ,DATEPART(SECOND,
                @Time)             [Second]
      ,CASE
         WHEN DATEPART(HOUR,
                       @Time) >= 12 THEN 'PM'
         ELSE 'AM'
       END                         AS [AmPm]

    SELECT
      @TIME = DATEADD(second,
                      1,
                      @Time)
  END

UPDATE DimTime
SET    [HOUR] = '0' + [HOUR]
WHERE
  LEN([HOUR]) = 1

UPDATE DimTime
SET    [MINUTE] = '0' + [MINUTE]
WHERE
  LEN([MINUTE]) = 1

UPDATE DimTime
SET    [SECOND] = '0' + [SECOND]
WHERE
  LEN([SECOND]) = 1

UPDATE DimTime
SET    [MilitaryHour] = '0' + [MilitaryHour]
WHERE
  LEN([MilitaryHour]) = 1

UPDATE DimTime
SET    StandardTime = [Hour] + ':' + [Minute] + ':' + [Second] + ' ' + AmPm
WHERE
  StandardTime IS NULL
  AND HOUR <> '00'

UPDATE DimTime
SET    StandardTime = '12' + ':' + [Minute] + ':' + [Second] + ' ' + AmPm
WHERE
  [HOUR] = '00'


--DimTime indexes
CREATE UNIQUE NONCLUSTERED INDEX [IDX_DimTime_Time]
  ON [dbo].[DimTime] ( [Time] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimTime_Hour]
  ON [dbo].[DimTime] ( [Hour] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimTime_MilitaryHour]
  ON [dbo].[DimTime] ( [MilitaryHour] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimTime_Minute]
  ON [dbo].[DimTime] ( [Minute] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimTime_Second]
  ON [dbo].[DimTime] ( [Second] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimTime_AmPm]
  ON [dbo].[DimTime] ( [AmPm] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_DimTime_StandardTime]
  ON [dbo].[DimTime] ( [StandardTime] ASC )
  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]

PRINT CONVERT(VARCHAR, GETDATE(), 113)--USED FOR CHECKING RUN TIME.



