-- ===========================
-- CREATE LOG TABLE
-- =============================
CREATE TABLE Sales.EmployeeLogs (
	LogID INT IDENTITY(1,1) PRIMARY KEY, EmployeeID INT, 
	LogMessage NVARCHAR(255),
	LogDate DATETIME
	)

-- ===================================================
--	CREATE TRIGGER ON INSERT on sales.employees
-- ===================================================

CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT
AS
BEGIN
	INSERT INTO Sales.EmployeeLogs( EmployeeID,LogMessage,LogDate)
	SELECT
		EmployeeID,
		'New Employee Added : '+ CAST(EmployeeID as nvarchar),
		GETDATE()
	FROM inserted
END


-- ============================================================
-- Selecting data from employee table
-- =============================================================
SELECT * FROM Sales.Employees

-- =============================================================
-- Inserting data to employee table table to activate trigger
-- ==============================================================

INSERT INTO Sales.Employees
			Values (6,'Shakun','Vaid','Marketing','1988-04-14','F',80000,2)

-- ================================================================
-- Checking log table
-- ================================================================
Select * from sales.EmployeeLogs
