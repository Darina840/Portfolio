SELECT * FROM SalesLT.Product
SELECT * FROM SalesLT.SalesOrderDetail

SELECT ProductID, UPPER(Name) AS ProductName, 
    ROUND(CAST(Weight AS float), 0) AS ApproxWeight
	FROM SalesLT.Product

SELECT ProductID, UPPER(Name) AS ProductName,
    ROUND(CAST(Weight AS float), 0) AS ApproxWeight,
	YEAR(SellStartDate) AS SellStartYear, 
	DATENAME(mm, SellStartDate) AS SellStartMonth
	FROM SalesLT.Product

SELECT ProductID, UPPER(Name) AS ProductName,
    ROUND(CAST(Weight AS float), 0) AS ApproxWeight,
	YEAR(SellStartDate) AS SellStartYear,
	DATENAME(mm, SellStartDate) AS SellStartMonth,
	LEFT(ProductNumber, 2) AS ProductType 
	FROM SalesLT.Product

SELECT ProductID, UPPER(Name) AS ProductName,
    ROUND(CAST(Weight AS float), 0) AS ApproxWeight,
	YEAR(SellStartDate) AS SellStartYear, 
	DATENAME(mm, SellStartDate) AS SellStartMonth, 
	LEFT(ProductNumber, 2) AS ProductType 
	FROM SalesLT.Product
	WHERE ISNUMERIC(Size) = 1

SELECT a.CompanyName, b.TotalDue AS Revenue,
	RANK() OVER(ORDER BY TotalDue DESC) AS RankByRevenue
	FROM SalesLT.SalesOrderHeader as b
	JOIN SalesLT.Customer as a
	ON b.CustomerID = a.CustomerID

SELECT a.Name, SUM(b.LineTotal) AS TotalRevenue
	FROM SalesLT.SalesOrderDetail AS b
	JOIN SalesLT.Product AS a
	ON b.ProductID = a.ProductID
	GROUP BY a.Name
	ORDER BY TotalRevenue DESC

SELECT a.Name, SUM(b.LineTotal) AS TotalRevenue
	FROM SalesLT.SalesOrderDetail AS b
	JOIN SalesLT.Product AS a
	ON b.ProductID = a.ProductID
	WHERE a.ListPrice > 1000
	GROUP BY a.Name
	ORDER BY TotalRevenue DESC

SELECT p.Name, SUM(od.LineTotal) AS TotalRevenue
	FROM SalesLT.SalesOrderDetail AS od
	JOIN SalesLT.Product AS p
	ON od.ProductID = p.ProductID
	WHERE p.ListPrice > 1000
	GROUP BY p.Name
	HAVING SUM(od.LineTotal) > 20000
	ORDER BY TotalRevenue DESC

SELECT  NAME AS NAME FROM SalesLT.Product  WHERE LEN(NAME)