-- 1.1
GO
DECLARE myCursor CURSOR FOR SELECT MAX(ListPrice), MIN(ListPrice) FROM SalesLT.Product GROUP BY ProductCategoryID
OPEN myCursor
DECLARE @max int, @min int, @sum int = 0
FETCH NEXT FROM myCursor INTO @max, @min
WHILE(@@FETCH_STATUS = 0)
BEGIN
	IF(@max / @min > 20)
	BEGIN
		SET @sum = @sum + 1
	END
	FETCH NEXT FROM myCursor INTO @max, @min
END
CLOSE myCursor
DEALLOCATE myCursor
IF (@sum > 0)
	PRINT(CONCAT('Правило 20-кратной разницы в цене нарушено у ', @sum, ' товаров'))
ELSE
	PRINT('Правило 20-кратной разницы в цене соблюдено')

-- 1.2
GO
CREATE TRIGGER SalesLT.TriggerProductListPriceRules ON SalesLT.Product
AFTER INSERT, UPDATE
AS
BEGIN
	IF EXISTS(SELECT * FROM inserted i WHERE (SELECT MAX(ListPrice) FROM SalesLT.Product p WHERE p.ProductCategoryID = i.ProductCategoryID) / i.ListPrice > 20)
	BEGIN
		ROLLBACK;
		THROW 50001, 'Вносимые изменения нарушают правило 20-кратной разницы в цене товаров из одной рубрики (слишком дешево)', 0
	END
	IF EXISTS(SELECT * FROM inserted i WHERE i.ListPrice / (SELECT MIN(ListPrice) FROM SalesLT.Product p WHERE p.ProductCategoryID = i.ProductCategoryID) > 20)
	BEGIN
		ROLLBACK;
		THROW 50001, 'Вносимые изменения нарушают правило 20-кратной разницы в цене товаров из одной рубрики (слишком дорого)', 0
	END
END
GO
ALTER TABLE SalesLT.Product ENABLE TRIGGER TriggerProductListPriceRules

-- 1.3
GO
DECLARE @category int = (SELECT p.ProductCategoryID FROM SalesLT.Product p JOIN SalesLT.vGetAllCategories gac ON p.ProductCategoryID = gac.ProductCategoryID WHERE gac.ProductCategoryName LIKE 'Mountain Bikes' GROUP BY p.ProductCategoryID)
DECLARE @max int = (SELECT MAX(ListPrice) FROM SalesLT.Product WHERE ProductCategoryID = @category)
DECLARE @min int = (SELECT MIN(ListPrice) FROM SalesLT.Product WHERE ProductCategoryID = @category)

PRINT(CONCAT('Минимальная цена: ', @min, ', максимальная цена: ', @max))

BEGIN TRY
INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, SellStartDate, ListPrice, ProductCategoryID)
VALUES
('Very Expensive Product', 'generic-number-1', 1, GETDATE(), @min * 21, @category)
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
END CATCH

BEGIN TRY
INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, SellStartDate, ListPrice, ProductCategoryID)
VALUES
('Very Cheap Product', 'generic-number-2', 1, GETDATE(), @max / 21, @category)
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
END CATCH

SELECT * FROM SalesLT.Product p
WHERE ProductCategoryID = @category
ORDER BY ListPrice DESC

-- 2.1
GO
CREATE TRIGGER SalesLT.TriggerProduct ON SalesLT.Product
AFTER INSERT, UPDATE
AS
BEGIN
	IF EXISTS(SELECT * FROM inserted WHERE ProductCategoryID NOT IN (SELECT ProductCategoryID FROM SalesLT.ProductCategory))
	BEGIN
		ROLLBACK;
		THROW 50002, 'Ошибка: попытка нарушения ссылочной целостности между таблицами Product и ProductCategory, транзакция отменена', 0
	END
END
GO
ALTER TABLE SalesLT.Product ENABLE TRIGGER TriggerProduct

GO
CREATE TRIGGER SalesLT.TriggerProductCategory ON SalesLT.ProductCategory
AFTER UPDATE, DELETE
AS
BEGIN
	IF EXISTS(SELECT * FROM deleted WHERE ProductCategoryID IN (SELECT ProductCategoryID FROM SalesLT.Product))
	BEGIN
		ROLLBACK;
		THROW 50002, 'Ошибка: попытка нарушения ссылочной целостности между таблицами Product и ProductCategory, транзакция отменена', 1
	END
END
GO
ALTER TABLE SalesLT.ProductCategory ENABLE TRIGGER TriggerProductCategory

-- 2.2
ALTER TABLE SalesLT.Product NOCHECK CONSTRAINT FK_Product_ProductCategory_ProductCategoryID;

INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, SellStartDate, ListPrice, ProductCategoryID)
VALUES
('Delete me', 'DEL-ME', 10, GETDATE(), 10, -1)

DELETE FROM SalesLT.ProductCategory
WHERE ProductCategoryID = 5

-- 2.3
ALTER TABLE SalesLT.Product CHECK CONSTRAINT FK_Product_ProductCategory_ProductCategoryID;
DISABLE TRIGGER SalesLT.TriggerProduct ON SalesLT.Product; 
DISABLE TRIGGER SalesLT.TriggerProductCategory ON SalesLT.ProductCategory;