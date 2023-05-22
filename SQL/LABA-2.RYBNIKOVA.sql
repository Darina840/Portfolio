SELECT *  from SalesLT.Product
--1
SELECT distinct City, StateProvince FROM SalesLT.Address

SELECT TOP 10 PERCENT NAME FROM SalesLT.Product ORDER BY Weight DESC

SELECT NAME  FROM SalesLT.Product ORDER BY Weight DESC offset 10 ROWS FETCH NEXT 100 ROWS only
--2
SELECT NAME, Color, Size FROM SalesLT.Product WHERE ProductModelID = 1

SELECT ProductNumber FROM SalesLT.Product WHERE Color in ('Black', 'Red', 'White') and Size in ('S', 'M')

SELECT  ProductNumber, NAME, ListPrice  FROM SalesLT.Product WHERE ProductNumber like 'BK-%'

SELECT  ProductNumber, NAME, ListPrice FROM SalesLT.Product WHERE ProductNumber like 'BK-[^R]%-[0-9][0-9]'
