--------------Stored Procedure to select customer summary based upon country filter--------------------------

Use SalesDB

CREATE PROCEDURE customersummary @Country NVARCHAR(20)

AS
BEGIN
	SELECT COUNT(*) TotalCustomer,
	AVG(Score) AverageScore
	FROM Sales.Customers
	WHERE Country = @Country
END
----Execute stored procedure
EXECUTE customersummary @Country = 'Germany'
--/==============================================================================================================================================/

--------------Stored Procedure to select customer summary based upon country filter with default value--------------------------


CREATE PROCEDURE customersummary @Country NVARCHAR(20)='USA'

AS
BEGIN
	SELECT COUNT(*) TotalCustomer,
	AVG(Score) AverageScore
	FROM Sales.Customers
	WHERE Country = @Country
END
----Execute stored procedure
EXECUTE customersummary 
