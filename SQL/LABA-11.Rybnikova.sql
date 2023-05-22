-- 1.1
DECLARE @SalesOrderID int = 7654321
IF EXISTS(SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
BEGIN
	DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
	DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
END
ELSE
BEGIN
	DECLARE @ErrorMsg varchar(64) = CONCAT('Заказ #', CAST(@SalesOrderID AS varchar(32)), ' не существует');
	THROW 50001, @ErrorMsg, 0
END

-- 1.2
BEGIN TRY
	DECLARE @SalesOrderID int = 7654321
	IF EXISTS(SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
	BEGIN	
		DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
		DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
	END
	ELSE
	BEGIN
		DECLARE @MyErrorMsg varchar(32) = CONCAT('Заказ #', CAST(@SalesOrderID AS varchar(32)), ' не существует ')
		RAISERROR(@MyErrorMsg, 0, 0)
	END
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
END CATCH

-- 2.1
BEGIN TRY
	BEGIN TRAN
	DECLARE @SalesOrderID int = 7654321
	IF EXISTS(SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
	BEGIN
		DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
		DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;		
	END
	ELSE
	BEGIN
		DECLARE @MyErrorMsg varchar(32) = CONCAT('Заказ #', CAST(@SalesOrderID AS varchar(32)), ' не существует')
		RAISERROR(@MyErrorMsg, 0, 0)
		ROLLBACK TRAN
	END
	COMMIT TRAN
END TRY
BEGIN CATCH
	DECLARE @ErrorMsg varchar(64) = ERROR_MESSAGE()
	PRINT @ErrorMsg
	ROLLBACK TRAN
END CATCH