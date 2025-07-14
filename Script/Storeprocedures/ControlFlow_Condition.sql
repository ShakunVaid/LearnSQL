----CONTROL FLOW USING IF ELSE TO CLEAN DATA AND EXECUTE SP------------------------

USE SalesDB
CREATE OR ALTER PROCEDURE customersummary @Country NVARCHAR(20)='USA'
AS
BEGIN
DECLARE @totalcustomer INT, @avgscore FLOAT;


-----PREPARE AND CLEAN DATA checking if null is there for scoreand updating it by 0
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
	Sum(O.Sales) TotalSales
	FROM Sales.Orders as O
	LEFT JOIN Sales.Customers as C
	ON O.CustomerID=C.CustomerID
	WHERE C.Country = @country;

END
GO
----Execute stored procedure
EXECUTE customersummary
EXECUTE customersummary @Country ='Germany'
