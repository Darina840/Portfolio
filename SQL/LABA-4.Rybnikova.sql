SELECT * FROM SalesLT.Customer
SELECT * FROM SalesLT.CustomerAddress
SELECT * FROM SalesLT.Address

SELECT a.CompanyName, b.AddressLine1, b.City, c.AddressType AS Billing
	FROM SalesLT.Customer AS a
	JOIN SalesLT.CustomerAddress AS c
	ON a.CustomerID = c.CustomerID 
	AND c.AddressType LIKE 'Main Office'
	JOIN SalesLT.Address AS b
	ON c.AddressID = b.AddressID

SELECT a.CompanyName, b.AddressLine1, b.City, c.AddressType AS Shipping
	FROM SalesLT.Customer AS a
	JOIN SalesLT.CustomerAddress AS c
	ON a.CustomerID = c.CustomerID 
	AND c.AddressType LIKE 'Shipping'
	JOIN SalesLT.Address AS b
	ON c.AddressID = b.AddressID

SELECT a.CompanyName, b.AddressLine1, b.City, c.AddressType
	FROM SalesLT.Customer AS a
	JOIN SalesLT.CustomerAddress AS c
	ON a.CustomerID = c.CustomerID AND c.AddressType LIKE 'Main Office'
	JOIN SalesLT.Address AS b
	ON c.AddressID = b.AddressID
UNION
SELECT a.CompanyName, b.AddressLine1, b.City, c.AddressType
	FROM SalesLT.Customer AS a
	JOIN SalesLT.CustomerAddress AS c
	ON a.CustomerID = c.CustomerID AND c.AddressType LIKE 'Shipping'
	JOIN SalesLT.Address AS b
	ON c.AddressID = b.AddressID
    ORDER BY a.CompanyName, c.AddressType 

SELECT a.CompanyName, a.CustomerID
	FROM SalesLT.Customer AS a
	JOIN SalesLT.CustomerAddress AS b
	ON a.CustomerID = b.CustomerID AND b.AddressType LIKE 'Main Office'
EXCEPT
SELECT a.CompanyName, a.CustomerID
	FROM SalesLT.Customer AS a
	JOIN SalesLT.CustomerAddress AS b
	ON a.CustomerID = b.CustomerID AND b.AddressType LIKE 'Shipping'

SELECT c.CompanyName
	FROM SalesLT.Customer AS c
	JOIN SalesLT.CustomerAddress AS ca
	ON c.CustomerID = ca.CustomerID AND ca.AddressType LIKE 'Main Office'
INTERSECT
SELECT c.CompanyName
	FROM SalesLT.Customer AS c
	JOIN SalesLT.CustomerAddress AS ca
	ON c.CustomerID = ca.CustomerID AND ca.AddressType LIKE 'Shipping'






































SELECT c.CustomerID
	FROM SalesLT.Customer AS c
EXCEPT
SELECT oh.CustomerID
	FROM SalesLT.SalesOrderHeader as oh
ORDER BY c.CustomerID