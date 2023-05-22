SELECT a.ProductID, a.Name ProductName, b.Name ProductModel, b.Summary 
FROM SalesLT.Product as a
JOIN SalesLT.vProductModelCatalogDescription as b
ON a.ProductModelID = b.ProductModelID
ORDER BY a.ProductID



DECLARE @Colors TABLE (Color nvarchar(16))
INSERT INTO @Colors
SELECT DISTINCT Color
FROM SalesLT.Product

SELECT ProductID, Name ProductName, Color
FROM SalesLT.Product
WHERE Color IN (SELECT * FROM @Colors)
ORDER BY Color



CREATE TABLE #Sizes (Size nvarchar(2))
INSERT INTO #Sizes
SELECT DISTINCT Size
FROM SalesLT.Product

SELECT ProductID, Name  ProductName, Size
FROM SalesLT.Product
WHERE Size IN (SELECT * FROM #Sizes)
ORDER BY Size DESC




SELECT a.ProductID, a.Name ProductName, b.ParentProductCategoryName ParentCategory, b.ProductCategoryName Category
FROM SalesLT.Product a
JOIN dbo.ufnGetAllCategories() b
ON a.ProductCategoryID = b.ProductCategoryID
ORDER BY b.ParentProductCategoryName, b.ProductCategoryName, a.Name





SELECT CompanyContact, SUM(TotalDue) Revenue
FROM
	(SELECT CONCAT(a.CompanyName, ' (', a.FirstName, ' ', a.LastName, ')') CompanyContact, b.TotalDue
	FROM SalesLT.Customer a
	JOIN SalesLT.SalesOrderHeader b 
	ON a.CustomerID = b.CustomerID) c
GROUP BY CompanyContact
ORDER BY CompanyContact




WITH RevenuePerCustomer
AS
(
	SELECT CONCAT(a.CompanyName, ' (', a.FirstName, ' ', a.LastName, ')') CompanyContact, b.TotalDue
	FROM SalesLT.Customer a
	JOIN SalesLT.SalesOrderHeader  b
	ON a.CustomerID = b.CustomerID
)
SELECT CompanyContact, SUM(TotalDue) Revenue
FROM RevenuePerCustomer
GROUP BY CompanyContact
ORDER BY CompanyContact