
-- ================================================================================
-- Create table for testing Indexes
-- ================================================================================

SELECT *
	INTO Sales.DBCustomer 
FROM Sales.Customers
-- ================================================================================
-- Create clustered index on customerID
-- ================================================================================


CREATE  CLUSTERED INDEX idx_DBCustomer_CustomerID ON Sales.DBCustomer (CustomerID)

CREATE  CLUSTERED INDEX idx_DBCustomer_FirstName ON Sales.DBCustomer (FirstName)

-- ================================================================================
-- Drop Index
-- ================================================================================
DROP INDEX idx_DBCustomer_CustomerID ON Sales.DBCustomer

-- ================================================================================
-- SElect statement
-- ================================================================================
Select * 
	FROM Sales.DBCustomer
	WHERE
	FirstName ='Anna'

-- ================================================================================
-- Non clustered Index
-- ================================================================================
Create NONCLUSTERED INDEX idx_DBCustomer_lastName ON Sales.DBCustomer (LastName)
Create  INDEX idx_DBCustomer_FirstName ON Sales.DBCustomer (FirstName)


-- ================================================================================
-- Create Composite Index, column sequence in query should match column sequence in Index
-- Index works only if query filter start from first column in Index and follows its order
-- A,B,C,D
-- Index will be used
-- A,B
-- A
-- A,B,C
-- A,B,C,C
--Index not used
-- B
-- A,B,D
-- A,C,D
-- ================================================================================

Create  INDEX idx_DBCustomer_CountryScore ON Sales.DBCustomer (Country, Score)

Select * 
	FROM Sales.DBCustomer
	WHERE
	Country ='USA' AND Score > 300
