SELECT a.CompanyName, b.SalesOrderID, b.TotalDue FROM SalesLT.Customer AS a JOIN SalesLT.SalesOrderHeader AS b ON a.CustomerID = b.CustomerID

SELECT a.CompanyName, b.SalesOrderID, b.TotalDue, c.AddressLine1, c.AddressLine2, c.City, c.StateProvince, c.PostalCode, c.CountryRegion FROM SalesLT.Customer AS a
	INNER JOIN SalesLT.CustomerAddress AS ac ON a.CustomerID = ac.CustomerID	
	INNER JOIN SalesLT.Address AS c ON ac.AddressID = c.AddressID
	INNER JOIN SalesLT.SalesOrderHeader AS b ON a.CustomerID = b.CustomerID AND ac.AddressType LIKE 'Main Office'


SELECT * from SalesLT.Customer
SELECT * from SalesLT.SalesOrderHeader
SELECT * from SalesLT.CustomerAddress

SELECT a.CompanyName, a.FirstName, a.LastName, b.SalesOrderID, b.TotalDue FROM SalesLT.Customer AS a left JOIN SalesLT.SalesOrderHeader AS b
	ON a.CustomerID = b.CustomerID
	ORDER BY SalesOrderID DESC

SELECT a.CustomerID, a.CompanyName, a.FirstName, a.LastName, a.Phone FROM SalesLT.Customer AS a LEFT JOIN SalesLT.CustomerAddress AS ab
	ON a.CustomerID = ab.CustomerID
	WHERE ab.AddressID IS NULL

SELECT a.CustomerID, b.ProductID FROM SalesLT.Customer AS a FULL JOIN SalesLT.SalesOrderHeader AS frst ON a.CustomerID = frst.CustomerID
    LEFT JOIN SalesLT.SalesOrderDetail AS scnd ON frst.SalesOrderID = scnd.SalesOrderID
	FULL JOIN SalesLT.Product AS b ON scnd.ProductID = b.ProductID
	WHERE frst.SalesOrderID IS NULL AND scnd.SalesOrderID IS NULL
	ORDER BY b.ProductID, a.CustomerID