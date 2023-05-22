INSERT INTO SalesLT.Product(Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('LED Lights', 'LT-L123', 2.56, 12.99, 37, GETDATE())
SELECT IDENT_CURRENT('SalesLT.Product')





INSERT INTO SalesLT.ProductCategory(Name, ParentProductCategoryID)
VALUES
('Bells and Horns', 4)
INSERT INTO SalesLT.Product(Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('Bicycle Bell', 'BB-RING', 2.47, 4.99, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE()),
('Bicycle Horn', 'BB-PARP', 1.29, 3.75, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE())
SELECT * FROM SalesLT.Product
WHERE ProductCategoryID = IDENT_CURRENT('SalesLT.ProductCategory')






UPDATE SalesLT.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductCategoryID = (SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name LIKE 'Bells and Horns')
SELECT * FROM SalesLT.Product
WHERE ProductCategoryID = (SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name LIKE 'Bells and Horns')






UPDATE SalesLT.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductCategoryID = 37 AND ProductNumber NOT LIKE 'LT-L123'
SELECT * FROM SalesLT.Product
WHERE ProductCategoryID = 37





DELETE FROM SalesLT.Product
WHERE ProductCategoryID = (SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name LIKE 'Bells and Horns')
DELETE FROM SalesLT.ProductCategory
WHERE Name LIKE 'Bells and Horns'












