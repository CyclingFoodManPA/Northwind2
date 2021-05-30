USE [Northwind2]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_BuildDateFromDateParts]
  (@intMonth INTEGER
   ,@intDay  INTEGER
   ,@intYear INTEGER)
RETURNS DATETIME2
AS
  BEGIN
    DECLARE @strYYYYMMDD CHAR (12)
    SET @strYYYYMMDD = CAST(@intYear AS CHAR(4)) + '/'
                       + RTRIM(CAST(@intMonth AS CHAR(2))) + '/'
                       + RTRIM(CAST(@intDay AS CHAR(2)))
    RETURN CAST(@strYYYYMMDD AS DATETIME2)
  END
GO

/*
http://www.codeproject.com/Tips/330787/LTRIM-RTRIM-doesn-t-always-work#
SQL 2000 Version
2/2/2012 CValenzuela
UDF to really trim the white spaces. 
When users copy and paste from Word, Excel, or some other application
into a text box, the special non printing whitespace characters 
like a line feed remain. This will replace all the non printing
whitespace characters with Character 32 which is the space bar then
perform an LTRIM and RTRIM
 
Declare 
@Seed as varchar(20),
@Test as varchar(50)
 
Set @Seed= ' CValenzuela';
Set @Test =  CHAR(0)+CHAR(9)+CHAR(10)+CHAR(11)+CHAR(12)+CHAR(13)+CHAR(14)+CHAR(160) + @Seed + CHAR(0)+CHAR(9)+CHAR(10)+CHAR(11)+CHAR(12)+CHAR(13)+CHAR(14)+CHAR(160)
 
Select
	@Seed as Seed,
	LTRIM(RTRIM(@SEED)) as Seed_Trimmed,	
	@Test as Test,
	LTRIM(RTRIM(@Test)) as Test_Trimmed,
	dbo.udfTrim(@Test) as Test_Trimmed2,
	
	Len(@Seed) as Seed_Length,
	DataLength(@Seed) as Seed_DataLength,
	LEN(LTRIM(RTRIM(@Seed))) as Seed_Trimmed_Length,
	DataLength(LTRIM(RTRIM(@Seed))) as Seed_Trimmed_DataLength,
 
	Len(@Test) as Test_Length,	
	LEN(LTRIM(RTRIM(@TEST))) as Test_Trimmed_Length,    	
	DataLength(LTRIM(RTRIM(@TEST))) as Test_Trimmed_DataLength,    	
	LEN(dbo.udfTrim(@Test)) as Test_UDFTrimmed_Length,
	DataLength(dbo.udfTrim(@Test)) as Test_UDFTrimmed_DataLength
	
 
*/
CREATE FUNCTION [dbo].[udf_Trim]
  (@StringToClean AS VARCHAR(8000))
RETURNS VARCHAR(8000)
AS
  BEGIN
    --Replace all non printing whitespace characers with Characer 32 whitespace
    --NULL
    SET @StringToClean = REPLACE(@StringToClean,
                                 CHAR(0),
                                 CHAR(32));
    --Horizontal Tab
    SET @StringToClean = REPLACE(@StringToClean,
                                 CHAR(9),
                                 CHAR(32));
    --Line Feed
    SET @StringToClean = REPLACE(@StringToClean,
                                 CHAR(10),
                                 CHAR(32));
    --Vertical Tab
    SET @StringToClean = REPLACE(@StringToClean,
                                 CHAR(11),
                                 CHAR(32));
    --Form Feed
    SET @StringToClean = REPLACE(@StringToClean,
                                 CHAR(12),
                                 CHAR(32));
    --Carriage Return
    SET @StringToClean = REPLACE(@StringToClean,
                                 CHAR(13),
                                 CHAR(32));
    --Column Break
    SET @StringToClean = REPLACE(@StringToClean,
                                 CHAR(14),
                                 CHAR(32));
    --Non-breaking space
    SET @StringToClean = REPLACE(@StringToClean,
                                 CHAR(160),
                                 CHAR(32));
    SET @StringToClean = LTRIM(RTRIM(@StringToClean));
    RETURN @StringToClean
  END
GO 
