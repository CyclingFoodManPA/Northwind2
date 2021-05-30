USE northwind2
go

SELECT
  'Customer'    AS EntityType
  ,c.CustomerID AS EntityID
  ,c.CustomerName
  ,a.AddressLine1
  ,a.City
  ,a.Region
  ,a.PostalCode
  ,co.CountryName
FROM
  CustomerAddress ca
  INNER JOIN Customer c
          ON ca.CustomerID = c.CustomerID
  INNER JOIN Address a
          ON ca.AddressID = a.AddressID
  INNER JOIN Country co
          ON a.CountryID = co.CountryID
UNION
SELECT
  'Employee'    AS EntityType
  ,e.EmployeeID AS EntityID
  ,e.LastName + ', ' + e.FirstName
  ,a.AddressLine1
  ,a.City
  ,a.Region
  ,a.PostalCode
  ,co.CountryName
FROM
  EmployeeAddress ea
  INNER JOIN Employee e
          ON ea.EmployeeID = e.EmployeeID
  INNER JOIN Address a
          ON ea.AddressID = a.AddressID
  INNER JOIN Country co
          ON a.CountryID = co.CountryID
UNION
SELECT
  'Supplier'    AS EntityType
  ,s.SupplierID AS EntityID
  ,s.SupplierName
  ,a.AddressLine1
  ,a.City
  ,a.Region
  ,a.PostalCode
  ,co.CountryName
FROM
  SupplierAddress sa
  INNER JOIN Supplier s
          ON sa.SupplierID = s.SupplierID
  INNER JOIN Address a
          ON sa.AddressID = a.AddressID
  INNER JOIN Country co
          ON a.CountryID = co.CountryID
ORDER  BY EntityType, EntityID
