USE SalesDB
CREATE OR ALTER PROCEDURE customersummary @Country NVARCHAR(20)='USA'

AS
BEGIN
	SELECT COUNT(*) TotalCustomer,
	AVG(Score) AverageScore
	FROM Sales.Customers
	WHERE Country = @Country;

---Total Order and total sales-------------------------
	SELECT COUNT(O.OrderID) TotalOrders,
	Sum(O.Sales) TotalSales
	FROM Sales.Orders as O
	LEFT JOIN Sales.Customers as C
	ON O.CustomerID=C.CustomerID
	WHERE C.Country = @country;

END
----Execute stored procedure
EXECUTE customersummary 
