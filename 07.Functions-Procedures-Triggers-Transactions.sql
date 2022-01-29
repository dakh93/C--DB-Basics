--Problem 1. Employees with Salary Above 35000

CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
SELECT e.FirstName,
	   e.LastName
  FROM Employees AS e
 WHERE e.Salary > 35000

EXEC usp_GetEmployeesSalaryAbove35000
GO
--Problem 2. Employees with Salary Above Number

CREATE PROC usp_GetEmployeesSalaryAboveNumber @number DECIMAL(15,2)
AS
SELECT e.FirstName,
	   e.LastName
  FROM Employees AS e
 WHERE e.Salary >= @number

EXEC usp_GetEmployeesSalaryAboveNumber 100000
GO

--Problem 3. Town Names Starting With

CREATE OR ALTER PROC usp_GetTownsStartingWith @startString NVARCHAR(50)
AS
SELECT t.Name
  FROM Towns AS t
 WHERE (LOWER(t.Name) LIKE @startString + '%');

EXEC usp_GetTownsStartingWith 'b'

GO

--Problem 4. Employees from Town

CREATE OR ALTER PROC usp_GetEmployeesFromTown @townName NVARCHAR(50)
AS
SELECT e.FirstName,
	   e.LastName
  FROM Employees AS e
  JOIN Addresses AS a
    ON a.AddressID = e.AddressID
  JOIN Towns AS t
  ON t.TownID = a.TownID
 WHERE t.Name = @townName

EXEC usp_GetEmployeesFromTown 'Sofia'

GO


