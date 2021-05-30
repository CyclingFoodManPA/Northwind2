USE northwind2
go


CREATE PROCEDURE Security.usp_Users_UpdateDateLastActivity @Username          VARCHAR(20)
                                                           ,@DateLastActivity DATETIME2
AS
  BEGIN
    UPDATE SystemUser
    SET    LastActivityDate = @DateLastActivity
    FROM   Security.SystemUser
    WHERE  Username = @Username
  END
GO 
