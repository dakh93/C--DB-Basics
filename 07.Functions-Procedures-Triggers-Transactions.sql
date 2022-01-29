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

--Problem 5. Salary Level Function

CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) 
RETURNS VARCHAR(10)
AS
BEGIN
DECLARE @result NVARCHAR(10);

  IF (@salary < 30000)
	SET @result = 'Low';
  IF (@salary >= 30000 AND @salary <= 50000)
	SET @result = 'Average';
  IF (@salary > 50000)
	SET @result = 'High';

  RETURN @result;
END

GO

SELECT e.Salary, dbo.ufn_GetSalaryLevel(e.Salary)
  FROM Employees AS e

GO

--Problem 6. Employees by Salary Level

CREATE OR ALTER PROCEDURE usp_EmployeesBySalaryLevel(@salaryLevel NVARCHAR(10))
AS
SELECT e.FirstName,
	   e.LastName
  FROM Employees AS e
 WHERE dbo.ufn_GetSalaryLevel(e.Salary) = @salaryLevel

EXEC usp_EmployeesBySalaryLevel 'Low'

GO

--Problem 7. Define Function

CREATE OR ALTER FUNCTION ufn_IsWordComprised
	(
		@setOfLetters NVARCHAR(MAX),
		@word NVARCHAR(MAX)
	)
RETURNS INT
AS
BEGIN

DECLARE @start INT = 1;
DECLARE @end INT = LEN(@word);

WHILE (@start <= @end)
	BEGIN

		DECLARE @currLetter NVARCHAR = SUBSTRING(@word, @start, 1);
		DECLARE @searchedLetterIndex INT = CHARINDEX(@currLetter, @setOfLetters,1)

		IF (@searchedLetterIndex = 0)
			RETURN 0;

		SET @start = @start + 1;
	END

RETURN 1;
END

GO

SELECT dbo.ufn_IsWordComprised('ppppp', 'Guy') AS Result

GO




