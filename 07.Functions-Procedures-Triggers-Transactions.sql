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

--Problem 8. * Delete Employees and Departments

CREATE OR ALTER PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT) 
AS 
BEGIN
	
	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT

	ALTER TABLE Departments
	NOCHECK CONSTRAINT ALL

	ALTER TABLE Employees
	NOCHECK CONSTRAINT ALL

	ALTER TABLE EmployeesProjects
	NOCHECK CONSTRAINT ALL

	ALTER TABLE EmployeesProjects
	NOCHECK CONSTRAINT ALL

	DELETE 
	  FROM Employees
	 WHERE DepartmentID = @departmentId

	DELETE 
	  FROM Departments
	 WHERE DepartmentID = @departmentId

	SELECT COUNT(*)
	  FROM Employees AS e
	 WHERE e.DepartmentID = @departmentId

END

GO

USE Bank

--Problem 9. Find Full Name

CREATE OR ALTER PROCEDURE usp_GetHoldersFullName
AS
BEGIN

SELECT ah.FirstName + ' ' + ah.LastName AS [Full Name]
  FROM AccountHolders AS ah

END

GO

--Problem 10. People with Balance Higher Than

CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan(@money DECIMAL(15,2))
AS
BEGIN

--SELECT ac.FirstName,
--	   ac.LastName,
--	   Filtered.TotalBalance
--  FROM	(
--			SELECT a.AccountHolderId,
--				SUM(a.Balance) AS [TotalBalance]
--			FROM Accounts AS a
--			JOIN AccountHolders AS ac
--				ON ac.Id = a.AccountHolderId
--			GROUP BY a.AccountHolderId
--			HAVING SUM(a.Balance) > @money
--		) AS Filtered
--  JOIN AccountHolders AS ac
--    ON ac.Id = Filtered.AccountHolderId
------------------------------------------------------------------
--SECOND SOLUTION

SELECT ah.FirstName,
	       ah.LastName 
	  FROM Accounts AS a
INNER JOIN AccountHolders AS ah
        ON ah.Id = a.AccountHolderId
  GROUP BY ah.FirstName,
           ah.LastName
	HAVING SUM(a.Balance) > @money
END

GO

--Problem 11. Future Value Function

CREATE OR ALTER FUNCTION ufn_CalculateFutureValue
(
		@sum DECIMAL(15,2),
		@yearlyInterestRate FLOAT,
		@numberOfYears INT
)
RETURNS DECIMAL(15,4)
AS
BEGIN

DECLARE @result DECIMAL(15,4) =
			@sum * (POWER(1 + @yearlyInterestRate, @numberOfYears));

RETURN @result;

END

GO

--Problem 12. Calculating Interest(with function of previous task)

CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount
(
	@accID INT,
	@interestRate FLOAT
)
AS
BEGIN

SELECT TOP(1)
	   ah.Id,
	   ah.FirstName,
	   ah.LastName,
	   acc.Balance AS [CurrentBalance],
	   dbo.ufn_CalculateFutureValue(acc.Balance, @interestRate, 5) AS [Balance in 5 years]
  FROM AccountHolders AS ah
  JOIN Accounts AS acc
    ON acc.AccountHolderId = ah.Id
 WHERE ah.Id = @accID

END

EXEC usp_CalculateFutureValueForAccount 1, 0.1
GO

USE Diablo
GO
--Problem 13. *Scalar Function: Cash in User Games Odd Rows

CREATE OR ALTER FUNCTION ufn_CashInUsersGames(@gameName NVARCHAR(50))
RETURNS @ResultTable TABLE(SumCash DECIMAL(15,4))
AS
BEGIN

DECLARE @result DECIMAL(15, 4) = (
					SELECT SUM(Filtered.Cash)
					  FROM (
							SELECT 
									ROW_NUMBER() OVER(
									ORDER BY ug.Cash DESC) AS [RowNumber],
									ug.Cash
							  FROM UsersGames AS ug
							  JOIN Users AS u
								ON u.Id = ug.UserId
							  JOIN Games AS g
								ON g.Id = ug.GameId
							 WHERE g.Name = @gameName
							 
							 ) AS Filtered
					WHERE Filtered.RowNumber % 2 <> 0
				  );

	INSERT INTO @ResultTable 
	VALUES (@result)

	RETURN

END

GO








