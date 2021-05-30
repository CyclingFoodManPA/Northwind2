USE [AuditDB]
GO

--http://www.codeproject.com/Articles/25600/Triggers-Sql-Server
--http://www.codeproject.com/Articles/38808/Overview-of-SQL-Server-database-Triggers
-- Lookup Statement Level Triggers for a table in SQLServer

SELECT
  *
FROM
  DDLEvents
WHERE
  DatabaseName = 'BelAir'
  AND CONVERT(CHAR(10), PostTime, 101) = '03/16/2015'
ORDER  BY DatabaseLogID;


SELECT
  *
FROM
  AuditDB.dbo.DDLEvents
WHERE
  DatabaseName = 'BelAir'
  AND EventType = 'ALTER_TABLE'
ORDER  BY DatabaseLogID;


WITH [EventsCTE]
     AS (SELECT
           PostTime
           ,DatabaseName
           ,SchemaName
           ,ObjectName
           ,XmlEvent
           ,rnLatest = ROW_NUMBER()
                         OVER (
                           PARTITION BY DatabaseName, SchemaName, ObjectName
                           ORDER BY PostTime DESC )
           ,rnEarliest = ROW_NUMBER()
                           OVER (
                             PARTITION BY DatabaseName, SchemaName, ObjectName
                             ORDER BY PostTime )
         FROM
           AuditDB.dbo.DDLEvents)
SELECT
  Original.DatabaseName
  ,Original.SchemaName
  ,Original.ObjectName
  ,OriginalCode = Original.XmlEvent
  ,NewestCode = COALESCE(Newest.XmlEvent,
                         '')
  ,LastModified = COALESCE(Newest.PostTime,
                           Original.PostTime)
FROM
  [EventsCTE] AS Original
  LEFT OUTER JOIN [EventsCTE] AS Newest
               ON Original.DatabaseName = Newest.DatabaseName
                  AND Original.SchemaName = Newest.SchemaName
                  AND Original.ObjectName = Newest.ObjectName
                  AND Newest.rnEarliest = Original.rnLatest
                  AND Newest.rnLatest = Original.rnEarliest
                  AND Newest.rnEarliest > 1
WHERE
  Original.rnEarliest = 1; 
