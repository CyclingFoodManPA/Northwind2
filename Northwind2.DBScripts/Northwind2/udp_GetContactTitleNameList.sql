CREATE PROCEDURE Administration.usp_ContactTitle_GetAllList
AS
BEGIN
	SELECT ct.ContactTitleName
	FROM Administration.ContactTitle AS ct
	ORDER BY ct.ContactTitleName;
END