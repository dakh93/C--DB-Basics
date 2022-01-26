USE Gringotts
GO

--Problem 1.	Records’ Count
SELECT COUNT(*) 
  FROM WizzardDeposits
  
  GO
--Poblem 2.	Longest Magic Wand
SELECT MAX(MagicWandSize) AS [LongestMagicWand]
  FROM WizzardDeposits

GO

--Problem 3.	Longest Magic Wand per Deposit Groups

SELECT w.DepositGroup, MAX(MagicWandSize) AS [LongestMagicWand]
  FROM WizzardDeposits AS w
GROUP BY w.DepositGroup

GO

--Problem 4.	* Smallest Deposit Group per Magic Wand Size
SELECT TOP(2) w.DepositGroup
  FROM WizzardDeposits AS w
GROUP BY w.DepositGroup 
ORDER BY AVG(w.MagicWandSize)

GO

--Problem 5.	Deposits Sum
SELECT w.DepositGroup, SUM(w.DepositAmount)
  FROM WizzardDeposits AS w
GROUP BY w.DepositGroup

GO

--Problem 6.	Deposits Sum for Ollivander Family
SELECT w.DepositGroup, SUM(w.DepositAmount)
  FROM WizzardDeposits AS w
 WHERE w.MagicWandCreator = 'Ollivander family'
GROUP BY w.DepositGroup

GO

--Problem 7.	Deposits Filter
SELECT w.DepositGroup, SUM(w.DepositAmount) AS [TotalSum]
  FROM WizzardDeposits AS w
 WHERE w.MagicWandCreator = 'Ollivander family'
GROUP BY w.DepositGroup
HAVING SUM(w.DepositAmount) < 150000
ORDER BY TotalSum DESC

GO

--Problem 8.	 Deposit Charge
SELECT w.DepositGroup, w.MagicWandCreator, MIN(DepositCharge) AS [MinDepositCharge]
  FROM WizzardDeposits AS w
GROUP BY w.DepositGroup, w.MagicWandCreator
ORDER BY w.MagicWandCreator ASC, w.DepositGroup ASC

GO

--Problem 9.	Age Groups
SELECT w.AgeGroup, COUNT(w.AgeGroup) AS [WizardCount]
  FROM (
		SELECT 
		CASE
	WHEN Age BETWEEN 0 AND 10 THEN  '[0-10]'
	WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
	ELSE '[61+]'
END AS [AgeGroup]
FROM WizzardDeposits ) AS w
GROUP BY w.AgeGroup

GO

--Problem 10.	First Letter
SELECT DISTINCT(LEFT(w.FirstName, 1)) AS [FirstLetter]
  FROM WizzardDeposits AS w
 WHERE w.DepositGroup = 'Troll Chest'
ORDER BY FirstLetter ASC

GO

--Problem 11.	Average Interest 
SELECT w.DepositGroup, 
	   w.IsDepositExpired,
	   AVG(w.DepositInterest) AS [AverageInterest]
  FROM WizzardDeposits AS w
  WHERE w.DepositStartDate > '01/01/1985'
GROUP BY w.DepositGroup, w.IsDepositExpired
ORDER BY w.DepositGroup DESC, w.IsDepositExpired ASC

GO

--Problem 12.	* Rich Wizard, Poor Wizard
SELECT SUM(Differ) AS [SumDifference]
  FROM ( SELECT
	     w.DepositAmount - LEAD(w.DepositAmount, 1) 
		 OVER ( ORDER BY w.Id) AS Differ
		 FROM WizzardDeposits AS w)
			  AS DIFF

GO

--Problem 13.	Departments Total Salaries
USE SoftUni
  
SELECT e.DepartmentID, SUM(e.Salary)
  FROM Employees AS e
GROUP BY e.DepartmentID

GO

--Problem 14.	Employees Minimum Salaries
SELECT e.DepartmentID ,MIN(e.Salary)
  FROM Employees AS e
 WHERE e.DepartmentID IN (2, 5, 7) AND e.HireDate > '01/01/2000'
GROUP BY e.DepartmentID

GO

--Problem 15.	Employees Average Salaries
SELECT * INTO FilteredEmployees
  FROM Employees AS e
 WHERE e.Salary > 30000

DELETE FROM FilteredEmployees
 WHERE ManagerID = 42

UPDATE FilteredEmployees
SET Salary += 5000
WHERE DepartmentID = 1

SELECT e.DepartmentID, AVG(e.Salary)
  FROM FilteredEmployees AS e
GROUP BY e.DepartmentID

GO

--Problem 16.	Employees Maximum Salaries
SELECT e.DepartmentID, MAX(e.Salary) AS [MaxSalary]
  FROM Employees AS e
GROUP BY e.DepartmentID
HAVING MAX(e.Salary) NOT BETWEEN 30000 AND 70000

GO

--Problem 17.	Employees Count Salaries
SELECT COUNT(e.Salary)
  FROM Employees AS e
 WHERE e.ManagerID IS NULL

GO

--Problem 18.	*3rd Highest Salary
SELECT DISTINCT n.DepartmentID, n.Salary
  FROM (SELECT e.Salary ,e.DepartmentID,
	   ROW_NUMBER() OVER(
						  PARTITION BY e.DepartmentID 
						  ORDER BY e.Salary DESC) AS RowNumber,
		DENSE_RANK() OVER ( 
							PARTITION BY e.DepartmentID
							ORDER BY e.Salary DESC) AS Sal
  FROM Employees AS e) AS n
 WHERE Sal = 3
 
 GO

 --Problem 19.	**Salary Challenge
 SELECT TOP(10) e.FirstName,
				e.LastName,
				e.DepartmentID
   FROM Employees AS e
 WHERE e.Salary > (
					SELECT AVG(e2.Salary)
					  FROM Employees AS e2
					GROUP BY e2.DepartmentID
					HAVING e2.DepartmentID = e.DepartmentID
				  )







SELECT * FROM Employees





