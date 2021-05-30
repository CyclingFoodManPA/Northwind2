CREATE PROCEDURE Products.usp_Supplier_GetSupplierNameListByContactTitle (@ContactTitleName VARCHAR(MAX))
AS
BEGIN
	SELECT ct.ContactTitleID
		,ct.ContactTitleName
		,CASE 
			WHEN s.SupplierID IS NULL
				THEN - 9
			ELSE s.SupplierID
			END AS SupplierID
		,CASE 
			WHEN s.SupplierName IS NULL
				THEN 'N/A'
			ELSE s.SupplierName
			END AS SupplierName
	FROM Administration.ContactTitle AS ct
	LEFT JOIN Products.Supplier AS s ON ct.ContactTitleID = s.ContactTitleID
	WHERE (ct.ContactTitleName IN (@ContactTitleName))
	ORDER BY ct.ContactTitleName
		,SupplierName;
END