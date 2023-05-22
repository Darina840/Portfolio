-- 1.1
DECLARE @orderdate DATETIME = GETDATE(), @duedate DATETIME = DATEADD(d, 7, GETDATE()) ,@customerid INT = 1, @salesorderid INT = NEXT VALUE FOR SalesLT.SalesOrderNumber
INSERT INTO SalesLT.SalesOrderHeader (SalesOrderID, OrderDate, DueDate, CustomerID, ShipMethod)
VALUES
(@salesorderid, @orderdate, @duedate, @customerid, 'CARGO TRANSPORT 5')

PRINT @salesorderid

-- 1.2
DECLARE @productid INT = 760, @quantity SMALLINT = 1, @unitprice MONEY = 782.99
IF (EXISTS(SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @salesorderid))
BEGIN
	INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, ProductID, OrderQty, UnitPrice)
	VALUES
	(@salesorderid, @productid, @quantity, @unitprice)
	PRINT @salesorderid
END
ELSE
	PRINT 'Заказ не существует'

DECLARE @salesorderid INT = 0, @productid INT = 760, @quantity SMALLINT = 1, @unitprice MONEY = 782.99
IF EXISTS(SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = 0)
BEGIN
	INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, ProductID, OrderQty, UnitPrice)
	VALUES
	(@salesorderid, @productid, @quantity, @unitprice)
	PRINT @salesorderid
END
ELSE
	PRINT 'Заказ не существует'

-- 2.1  
WHILE ((SELECT AVG(ListPrice) FROM SalesLT.Product p
		WHERE p.ProductCategoryID IN (SELECT ProductCategoryID FROM SalesLT.vGetAllCategories WHERE ParentProductCategoryName LIKE 'Bikes')) < 2000)
BEGIN
	UPDATE SalesLT.Product
	SET ListPrice = ListPrice * 1.1
	WHERE ProductCategoryID IN (SELECT ProductCategoryID 
								FROM SalesLT.vGetAllCategories 
								WHERE ParentProductCategoryName LIKE 'Bikes')
	IF((SELECT TOP 1 ListPrice FROM SalesLT.Product
		WHERE ProductCategoryID IN (SELECT ProductCategoryID 
									  FROM SalesLT.vGetAllCategories 
									  WHERE ParentProductCategoryName LIKE 'Bikes'))>=5000)
		BREAK
END

DECLARE @a INT = (SELECT AVG(ListPrice) FROM SalesLT.Product
WHERE ProductCategoryID IN (SELECT ProductCategoryID 
									  FROM SalesLT.vGetAllCategories 
									  WHERE ParentProductCategoryName LIKE 'Bikes')) 
	
DECLARE @b INT = (SELECT TOP 1 ListPrice FROM SalesLT.Product
WHERE ProductCategoryID IN (SELECT ProductCategoryID 
									  FROM SalesLT.vGetAllCategories 
									  WHERE ParentProductCategoryName LIKE 'Bikes')
ORDER BY ListPrice DESC)
									  
PRINT CONCAT(CAST(@a as varchar(16)))
PRINT @b