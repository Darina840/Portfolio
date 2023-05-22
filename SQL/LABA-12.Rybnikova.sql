-- 1.1
GO
DECLARE @schemaName nvarchar(64) = 'SalesLT'
DECLARE @tableName nvarchar(64) = 'Product'
SELECT COLUMN_NAME AS ColumnName, DATA_TYPE AS Type FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = @schemaName AND TABLE_NAME = @tableName AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext')

-- 1.2
GO
DECLARE @schemaName nvarchar(64) = 'SalesLT'
DECLARE @tableName nvarchar(64) = 'Product'
DECLARE @value nvarchar(max) = 'Bike'
DECLARE @script nvarchar(max) = 'SELECT * FROM ' + @schemaName + '.' + @tableName

DECLARE myCursor CURSOR FOR SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = @schemaName AND TABLE_NAME = @tableName AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext')
OPEN myCursor

DECLARE @columnName nvarchar(max) = ''
FETCH NEXT FROM myCursor INTO @columnName 
DECLARE @where nvarchar(max) = ' WHERE ' + @columnName + ' LIKE ''%' + @value + '%'''

WHILE(@@FETCH_STATUS = 0)
BEGIN
	FETCH NEXT FROM myCursor INTO @columnName
	SET @where = @where + ' OR ' + @columnName + ' LIKE ''%' + @value + '%'''
END
CLOSE myCursor
DEALLOCATE myCursor

SET @script = @script + @where
PRINT @script






-- 2.1
GO
CREATE PROCEDURE SalesLT.uspFindStringInTable
	@schema sysname,
	@table sysname,
	@stringToFind nvarchar(2048)
AS
	DECLARE @script nvarchar(max) = 'SELECT * FROM ' + @schema + '.' + @table
	DECLARE myCursor CURSOR FOR SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = @schema AND TABLE_NAME = @table AND DATA_TYPE IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext')
	OPEN myCursor
	DECLARE @condition nvarchar(max) = ''

	FETCH NEXT FROM myCursor INTO @condition
	DECLARE @where nvarchar(max) = ' WHERE ' + @condition + ' LIKE ''%' + @stringToFind + '%'''

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		FETCH NEXT FROM myCursor INTO @condition
		SET @where = @where + ' OR ' + @condition + ' LIKE ''%' + @stringToFind + '%'''
	END

	CLOSE myCursor
	DEALLOCATE myCursor

	SET @script = @script + @where
	EXECUTE(@script)
	RETURN @@ROWCOUNT
GO

DECLARE @result int 
EXECUTE @result = SalesLT.uspFindStringInTable SalesLT, Product, 'Bike'
PRINT @result

-- 2.2
GO

DECLARE @stringToFind nvarchar(max) = 'Bike'
DECLARE @schema nvarchar(64) = ''
DECLARE @table nvarchar(64) = ''
DECLARE @result int = 0

DECLARE STCursor CURSOR FOR SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
OPEN STCursor

FETCH NEXT FROM STCursor INTO @schema, @table

WHILE(@@FETCH_STATUS = 0)
BEGIN
	BEGIN TRY
		EXECUTE @result = SalesLT.uspFindStringInTable @schema, @table, @stringToFind
	END TRY
	BEGIN CATCH		
	END CATCH
	IF (@result = 0)
		PRINT 'В таблице ' + @schema + '.' + @table + ' не найдено строк совпадений'
	ELSE
		PRINT 'В таблице ' + @schema + '.' + @table + ' найдено строк: ' + CAST(@result AS nvarchar(32))
	FETCH NEXT FROM STCursor INTO @schema, @table
END
CLOSE STCursor
DEALLOCATE STCursor

