-- 1.1
GO
CREATE FUNCTION SalesLT.fn_GetOrdersTotalDueForCustomer(@customerid int)
RETURNS int
AS
BEGIN
	DECLARE @totaldue int = 0;
	IF EXISTS(SELECT * FROM SalesLT.Customer WHERE CustomerID = @customerid)
	BEGIN
		SET @totaldue = (SELECT SUM(TotalDue) FROM SalesLT.SalesOrderHeader WHERE CustomerID = @customerid)
	END
	RETURN @totaldue
END
GO
PRINT SalesLT.fn_GetOrdersTotalDueForCustomer(1)
PRINT SalesLT.fn_GetOrdersTotalDueForCustomer(30113)

-- 1.2
GO
ALTER VIEW SalesLT.vAllAddresses
WITH SCHEMABINDING
AS
	SELECT c.CustomerID, ca.AddressType, ca.AddressID, a.AddressLine1, a.AddressLine2, a.City, a.StateProvince, a.CountryRegion, a.PostalCode FROM SalesLT.Customer c
	JOIN SalesLT.CustomerAddress ca
	ON c.CustomerID = ca.CustomerID
	JOIN SalesLT.Address a
	ON ca.AddressID = a.AddressID

GO
SELECT * FROM SalesLT.vAllAddresses

-- 1.3
GO
CREATE FUNCTION SalesLT.fn_GetAddressesForCustomer(@customerid int)
RETURNS TABLE
AS
	RETURN (SELECT * FROM SalesLT.vAllAddresses WHERE CustomerID = @customerid)
GO
SELECT * FROM SalesLT.fn_GetAddressesForCustomer(0)
SELECT * FROM SalesLT.fn_GetAddressesForCustomer(29502)
SELECT * FROM SalesLT.fn_GetAddressesForCustomer(29503)

-- 1.4
GO
CREATE FUNCTION SalesLT.fn_GetMinMaxOrderPricesForProduct(@productid int)
RETURNS TABLE
AS
	RETURN (SELECT MIN(UnitPrice) MinUnitPrice, MAX(UnitPrice) MaxUnitPrice FROM SalesLT.SalesOrderDetail WHERE ProductID = @productid)
GO
SELECT * FROM SalesLT.fn_GetMinMaxOrderPricesForProduct(0)
SELECT * FROM SalesLT.fn_GetMinMaxOrderPricesForProduct(711)

-- 1.5
GO
ALTER FUNCTION SalesLT.fn_GetAllDescriptionsForProduct(@productid int)
RETURNS TABLE
AS
	RETURN 
	(
		SELECT pad.ProductID, pad.Name, prices.MinUnitPrice, prices.MaxUnitPrice, p.ListPrice, pad.ProductModel, pad.Culture, pad.Description FROM SalesLT.vProductAndDescription pad
		JOIN SalesLT.Product p
		ON pad.ProductID = p.ProductID
		OUTER APPLY SalesLT.fn_GetMinMaxOrderPricesForProduct(pad.ProductID) prices
		WHERE pad.ProductID = @productid
	)
GO
SELECT * FROM SalesLT.fn_GetAllDescriptionsForProduct(0)
SELECT * FROM SalesLT.fn_GetAllDescriptionsForProduct(711)

-- 2.1
GO
SELECT * FROM SalesLT.vAllAddresses
GO
CREATE UNIQUE CLUSTERED INDEX UIX_vAllAddresses ON SalesLT.vAllAddresses
(
	CustomerID ASC,
	AddressType ASC,
	AddressID ASC, 
	AddressLine1 ASC, 
	AddressLine2 ASC, 
	City ASC, 
	StateProvince ASC, 
	CountryRegion ASC, 
	PostalCode ASC
)

DROP INDEX UIX_vAllAddresses ON SalesLT.vAllAddresses
GO
SELECT * FROM SalesLT.vAllAddresses WITH (NOEXPAND)
