----- BEGIN TRY
        ----SQL STATEMENT THAT MIGHT BE CAUSING ERROR
------END TRY

------BEGIN CATCH
      ------SQL TATEMENT TO HANDEL ERROR
------END CATCH

CREATE OR ALTER PROCEDURE customersummary @Country NVARCHAR(20)='USA'
AS
BEGIN
-------Error Handeling with TRY and Catch, started try block-----------------
BEGIN TRY
		DECLARE @totalcustomer INT, @avgscore FLOAT;


		---PREPARE AND CLEAN DATA
		IF EXISTS (SELECT 1 FROM sales.Customers WHERE Score IS NULL AND Country = @Country)
		BEGIN
			PRINT('Updating NULL to 0');
			UPDATE Sales.Customers
			SET Score = 0	
			WHERE Score IS NULL AND Country = @Country
		END

		ELSE
		BEGIN
			PRINT('No null found');
		END;



		-----GENERATING REPORT
			SELECT 
			@totalcustomer = COUNT(*),
			@avgscore =	AVG(Score)
			FROM Sales.Customers
			WHERE Country = @Country;

			PRINT 'Total customer from ' + @Country + '=' + CAST(@totalcustomer AS NVARCHAR);
			PRINT 'Average Score  from ' + @Country + '=' + CAST(@avgscore AS NVARCHAR);


		---Total Order and total sales-------------------------
			SELECT COUNT(O.OrderID) TotalOrders,
			Sum(O.Sales) TotalSales,
			--1/0
			FROM Sales.Orders as O
			LEFT JOIN Sales.Customers as C
			ON O.CustomerID=C.CustomerID
			WHERE C.Country = @country;
END TRY
BEGIN CATCH
	PRINT('Error Occured');
	PRINT('Error Message :' + ERROR_MESSAGE());
	PRINT( 'Error Number :' + CAST(ERROR_NUMBER() AS NVARCHAR));
	PRINT ('Error Line :' + CAST(ERROR_LINE() AS NVARCHAR));
	PRINT('Error Procudere :' + ERROR_PROCEDURE());
END CATCH
END
GO
----Execute stored procedure
EXECUTE customersummary @Country ='Germany'
