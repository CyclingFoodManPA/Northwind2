USE [Northwind2]
GO

SET NOCOUNT ON
DECLARE
  @schem     VARCHAR(100)
  ,@tbl      VARCHAR(100)
  ,@schemtbl VARCHAR(100)
  ,@sql      VARCHAR(4000)
  ,@recs     INT

CREATE TABLE #SchemaTableCount
(
   SchemaName   VARCHAR(100) NOT NULL
   ,TableName   VARCHAR(100) NOT NULL
   ,RecordCount INT NOT NULL DEFAULT 0
)

DECLARE db_cursor CURSOR FOR
  SELECT
    S.name  AS SchemaName
    ,T.name AS TableName
  FROM
    sys.tables AS T
    INNER JOIN sys.schemas AS S
            ON T.schema_id = S.schema_id
  ORDER  BY S.name
            ,T.name;
OPEN db_cursor

FETCH NEXT FROM db_cursor INTO @schem, @tbl

WHILE @@FETCH_STATUS = 0
  BEGIN
    IF EXISTS
       (SELECT
          *
        FROM
          tempdb.dbo.sysobjects
        WHERE
         ID = OBJECT_ID(N'tempdb..##RecCount'))
      BEGIN
        DROP TABLE ##RecCount
      END


    SET @schemtbl = '[' + @schem + '].[' + @tbl + ']'
    SET @sql = 'SELECT COUNT(*) AS RecCount INTO ##RecCount FROM '
               + @schemtbl
    EXEC(@sql)

    SELECT
      @recs = RC.RecCount
    FROM
      ##RecCount AS RC
    PRINT @schemtbl + ' = ' + CAST(@recs AS CHAR(10))
    INSERT INTO #SchemaTableCount
                (SchemaName
                 ,TableName
                 ,RecordCount)
    VALUES      (@schem
                 ,@tbl
                 ,@recs)

    FETCH NEXT FROM db_cursor INTO @schem, @tbl
  END

CLOSE db_cursor
DEALLOCATE db_cursor

SELECT
  SchemaName
  ,TableName
  ,RecordCount
FROM
  #SchemaTableCount
ORDER  BY RecordCount 
