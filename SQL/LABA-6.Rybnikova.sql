SELECT a.ProductID, a.Name, a.ListPrice
	FROM SalesLT.Product AS a
	WHERE 
		CAST(ListPrice AS int) >
		(SELECT AVG(UnitPrice)
			FROM SalesLT.SalesOrderDetail AS b
			WHERE a.ProductID = b.ProductID)
	ORDER BY a.ProductID



SELECT a.ProductID, a.Name, a.ListPrice
	FROM SalesLT.Product AS a
	WHERE 
		CAST(a.ListPrice AS int) > 100 
		AND 
		(SELECT TOP 1 UnitPrice
			FROM SalesLT.SalesOrderDetail AS b
			WHERE b.ProductID = a.ProductID
			ORDER BY UnitPrice) < 100
	ORDER BY a.ProductID




SELECT a.ProductID, a.Name, a.StandardCost, a.ListPrice, 
	(SELECT AVG(UnitPrice) 
		FROM SalesLT.SalesOrderDetail AS b 
		WHERE b.ProductID = a.ProductID) AS AvgSellingPrice
	FROM SalesLT.Product AS a
	WHERE 
		(SELECT AVG(UnitPrice) 
			FROM SalesLT.SalesOrderDetail AS b 
			WHERE b.ProductID = a.ProductID) IS NOT NULL
	ORDER BY 
		(SELECT AVG(UnitPrice) 
			FROM SalesLT.SalesOrderDetail AS b
			WHERE b.ProductID = a.ProductID)
		DESC



SELECT a.ProductID, a.Name, a.StandardCost, a.ListPrice, 
	(SELECT AVG(UnitPrice) 
		FROM SalesLT.SalesOrderDetail AS b 
		WHERE b.ProductID = a.ProductID) AS AvgSellingPrice
	FROM SalesLT.Product AS a
	WHERE 
		(SELECT AVG(UnitPrice) 
			FROM SalesLT.SalesOrderDetail AS b
			WHERE b.ProductID = a.ProductID) IS NOT NULL
		AND a.StandardCost < 
			(SELECT AVG(UnitPrice) 
				FROM SalesLT.SalesOrderDetail AS b
				WHERE b.ProductID = a.ProductID)
	ORDER BY 
		(SELECT AVG(UnitPrice) 
			FROM SalesLT.SalesOrderDetail AS b
			WHERE b.ProductID = a.ProductID)
		DESC



SELECT a.CustomerID, a.FirstName, a.LastName, b.TotalDue
	FROM SalesLT.SalesOrderHeader AS b
	CROSS APPLY dbo.ufnGetCustomerInformation(b.CustomerID) AS a
	ORDER BY a.CustomerID




SELECT a.CustomerID, a.FirstName, a.LastName, b.AddressLine1, b.City
	FROM SalesLT.CustomerAddress AS c
	JOIN SalesLT.Address AS b
	ON c.AddressID = b.AddressID
	CROSS APPLY dbo.ufnGetCustomerInformation(c.CustomerID) AS a
	ORDER BY a.CustomerID

