---ADDING VARIABLES  TO SP----------------------------------use DECLARE statement for declaring variables


CREATE OR ALTER PROCEDURE customersummary @Country NVARCHAR(20)='USA'
AS
BEGIN
DECLARE @totalcustomer INT, @avgscore FLOAT;
	SELECT 
	@totalcustomer = COUNT(*),
	@avgscore =	AVG(Score)
	FROM Sales.Customers
	WHERE Country = @Country;
--------Statement output will be printed in message tab----------------------
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
EXECUTE customersummary @Country ='Germany'
