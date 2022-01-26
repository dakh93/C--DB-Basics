USE SoftUni
GO

--Problem 1.	Find Names of All Employees by First Name
SELECT FirstName, LastName
  FROM Employees
 WHERE FirstName LIKE 'SA%'
GO

--Problem 2.	Find Names of All employees by Last Name 
SELECT FirstName, LastName
  FROM Employees
 WHERE LastName LIKE '%ei%'
GO

--Problem 3.	Find First Names of All Employees
SELECT FirstName
  FROM Employees
 WHERE DepartmentID IN (3, 10) 
                    AND Year(HireDate) BETWEEN 1995 AND 2005

--Problem 4.	Find All Employees Except Engineers
SELECT FirstName, LastName
FROM Employees AS e
WHERE e.JobTitle NOT LIKE '%engineer%'
GO

--Problem 5.	Find Towns with Name Length
SELECT t.Name
  FROM Towns AS t
  WHERE LEN(t.Name) in (5, 6)
  ORDER BY t.Name

--Problem 6.	 Find Towns Starting With
SELECT * 
FROM Towns AS t
WHERE t.[Name] LIKE 'M%' 
   OR t.[Name] LIKE 'K%'
   OR t.[Name] LIKE 'B%'
   OR t.[Name] LIKE 'E%'
ORDER BY t.[Name]
GO

--Problem 7.	 Find Towns Not Starting With
SELECT * 
FROM Towns AS t
WHERE t.[Name] NOT LIKE 'R%' 
   AND t.[Name] NOT LIKE 'B%'
   AND t.[Name] NOT LIKE 'D%'
ORDER BY t.[Name] ASC
GO

--Problem 8.	Create View Employees Hired After 2000 Year
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees AS e
WHERE YEAR(e.HireDate) > 2000
GO

--Problem 9.	Length of Last Name
SELECT FirstName, LastName
FROM Employees AS e
WHERE LEN(e.LastName) = 5
GO

--10. Rank Employees by Salary 
SELECT EmployeeID, FirstName, LastName, Salary,
	   DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
  FROM Employees
 WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC

--Problem 11.	Find All Employees with Rank 2 *
SELECT *
  FROM (
			SELECT EmployeeID, FirstName, LastName, Salary,
				   DENSE_RANK() 
				   OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
			  FROM Employees
			  WHERE Salary BETWEEN 10000 AND 50000
			) AS T
WHERE T.[Rank] = 2
ORDER BY Salary DESC

--Problem 12.	Countries Holding СAТ 3 or More Times
USE Geography

SELECT c.CountryName, c.IsoCode
  FROM Countries AS c
 WHERE c.CountryName LIKE '%A%A%A%'
ORDER BY c.IsoCode
GO

--Problem 13.	 Mix of Peak and River Names
--¬ условието не пише,че при конкатенаци€,
--тр€бва да премахнем повтар€щата се буква
--пример : Galan - Nile - очаквано - galanile
SELECT p.PeakName, r.RiverName , 
		LOWER(SUBSTRING(p.PeakName,1,LEN(p.PeakName) - 1) + r.RiverName) AS Mix
  FROM Peaks AS p, Rivers AS r
 WHERE RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
ORDER BY Mix ASC
GO

--Problem 14.	Games from 2011 and 2012 year
USE Diablo

SELECT TOP (50) [Name], FORMAT([Start],'yyyy-MM-dd') AS [Start]
  FROM Games
 WHERE YEAR([Start]) IN(2011, 2012)
ORDER BY [Start] ASC, [Name] ASC
GO

--Problem 15.	 User Email Providers
SELECT Username, SUBSTRING(Email,CHARINDEX('@',Email) + 1,LEN(Email)) AS [Email Provider]
  FROM Users
ORDER BY [Email Provider] ASC, Username ASC
GO

--Problem 16.	 Get Users with IPAdress Like Pattern
SELECT Username, IpAddress AS [IP Address]
  FROM Users
 WHERE IpAddress LIKE '___.1%.%.___'
 ORDER BY Username ASC
 GO

 --Problem 17.	 Show All Games with Duration and Part of the Day3
SELECT [Name] AS Game,
	CASE
		WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 18 AND 23 THEN 'Evening'
	END AS [Part of the Day],
	CASE
		WHEN Duration <=3 THEN 'Extra Short'
		WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		WHEN Duration IS NULL THEN 'Extra Long'
	END AS [Duration]
  FROM Games
  ORDER BY Name ASC, [Duration] ASC, [Part of the Day] ASC
  GO

  --Problem 18	 Orders Table
 USE Orders

 SELECT ProductName, OrderDate,
		DATEADD(DAY, 3, OrderDate) AS [Pay Due],
		DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
   FROM Orders


 SELECT * 
   FROM Orders
