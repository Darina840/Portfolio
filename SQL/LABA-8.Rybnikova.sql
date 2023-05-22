SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) Revenue
FROM SalesLT.Address a
JOIN SalesLT.CustomerAddress ca 
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer c 
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader soh 
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP (a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;




SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) Revenue, 
	IIF(GROUPING_ID(a.CountryRegion, a.StateProvince) = 3, 
	'Total', 
	(IIF(GROUPING_ID(a.CountryRegion, a.StateProvince) = 1, 
		CONCAT(CountryRegion, ' Total'), 
		CONCAT(StateProvince, ' Subtotal')))) Level
FROM SalesLT.Address a
JOIN SalesLT.CustomerAddress ca 
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer c 
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader soh 
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP (a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;





SELECT a.CountryRegion, a.StateProvince, a.City, SUM(soh.TotalDue) Revenue,
	CASE
	WHEN GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 7 THEN 'Total'
	WHEN GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 3 THEN CONCAT(CountryRegion, ' Total')
	WHEN GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 1 THEN CONCAT(StateProvince, ' Subtotal')
	WHEN GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 0 THEN CONCAT(City, ' Subtotal')
	END Level
FROM SalesLT.Address a
JOIN SalesLT.CustomerAddress ca 
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer c 
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader soh 
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP (a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince;





SELECT * FROM
	(SELECT c.CompanyName, a.ParentProductCategoryName ParentCategory, SUM(sod.LineTotal) Total
	FROM SalesLT.Customer c
	JOIN SalesLT.SalesOrderHeader soh
	ON c.CustomerID = soh.CustomerID
	JOIN SalesLT.SalesOrderDetail sod
	ON soh.SalesOrderID = sod.SalesOrderID
	JOIN SalesLT.Product b
	ON sod.ProductID = b.ProductID
	JOIN SalesLT.vGetAllCategories a
	ON b.ProductCategoryID = a.ProductCategoryID
	GROUP BY c.CompanyName, a.ParentProductCategoryName
	) qr
PIVOT
(
	SUM(Total) FOR ParentCategory IN (Accessories, Bikes, Clothing, Components)
) pvt
ORDER BY CompanyName