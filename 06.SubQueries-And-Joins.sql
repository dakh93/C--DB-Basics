USE SoftUni

--Problem 1.	Employee Address



SELECT TOP(5) 
	   e.EmployeeID,
	   e.JobTitle,
	   e.AddressID,
	   a.AddressText
  FROM Employees AS e
  JOIN Addresses as a
  ON a.AddressID = e.AddressID
  ORDER BY e.AddressID ASC

--Problem 2.	Addresses with Towns

SELECT TOP(50)
	   e.FirstName,
	   e.LastName,
	   t.Name,
	   a.AddressText
  FROM Employees AS e
  JOIN Addresses AS a
    ON a.AddressID = e.AddressID
  JOIN Towns AS t
    ON t.TownID = a.TownID
  ORDER BY e.FirstName ASC, e.LastName ASC

--Problem 3.	Sales Employee

SELECT e.EmployeeID,
	   e.FirstName,
	   e.LastName,
	   d.Name
  FROM Employees AS e
  JOIN Departments AS d
    ON d.DepartmentID = e.DepartmentID
 WHERE d.Name = 'Sales'
  ORDER BY e.EmployeeID ASC

--Problem 4.	Employee Departments

SELECT TOP(5)
	   e.EmployeeID,
	   e.FirstName,
	   e.Salary,
	   d.Name
  FROM Employees AS e
  JOIN Departments AS d
    ON d.DepartmentID = e.DepartmentID
 WHERE e.Salary > 15000
ORDER BY e.DepartmentID ASC

--Problem 5.	Employees Without Project

SELECT TOP(3)
	   e.EmployeeID,
	   e.FirstName
  FROM Employees AS e
FULL JOIN EmployeesProjects AS ep
    ON ep.EmployeeID = e.EmployeeID
 WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID ASC

--Problem 6.	Employees Hired After

SELECT e.FirstName,
	   e.LastName,
	   e.HireDate,
	   d.Name
  FROM Employees AS e
  JOIN Departments AS d
  ON d.DepartmentID = e.DepartmentID
 WHERE e.HireDate > '01/01/1999' AND
	   d.Name IN ('Sales', 'Finance')
ORDER BY e.HireDate ASC

--Problem 7.	Employees with Project

SELECT TOP(5)
	   e.EmployeeID,
	   e.FirstName,
	   p.Name
  FROM Employees AS e
  JOIN EmployeesProjects AS ep
  ON ep.EmployeeID = e.EmployeeID
  JOIN Projects AS p
    ON ep.ProjectID = p.ProjectID
 WHERE p.StartDate > '08/13/2002' AND
	  p.EndDate IS NULL
ORDER BY e.EmployeeID ASC

--Problem 8.	Employee 24

SELECT e.EmployeeID,
	   e.FirstName,
  CASE
	WHEN p.StartDate > '12/31/2004' THEN NULL
	ELSE p.Name
  END AS ProjectName
  FROM Employees AS e
  JOIN EmployeesProjects AS ep
    ON ep.EmployeeID = e.EmployeeID
  JOIN Projects AS p
    ON p.ProjectID = ep.ProjectID
 WHERE e.EmployeeID = 24

 --Problem 9.	Employee Manager

 SELECT e.EmployeeID,
	    e.FirstName,
		e.ManagerID,
		CASE
		WHEN e.ManagerID = 3 THEN 'Roberto'
		WHEN e.ManagerID = 7 THEN 'JoLynn'
		END AS [ManagerName]
   FROM Employees AS e
 WHERE e.ManagerID IN (3, 7)
ORDER BY e.EmployeeID ASC

--Problem 10.	Employee Summary

SELECT TOP(50)
	   e.EmployeeID,
	   e.FirstName + ' ' + e.LastName AS [EmployeeName],
	   (SELECT emp.FirstName + ' ' + emp.LastName
	      FROM Employees AS emp
	     WHERE emp.EmployeeID = e.ManagerID) AS [ManagerName],
		 d.Name AS [DepartmentName]
  FROM Employees AS e
  JOIN Departments AS d
    ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID ASC

--Problem 11.	Min Average Salary
SELECT MIN(AverageSalary)
FROM
	(SELECT AVG(e.Salary) AS AverageSalary
	  FROM Employees AS e
	GROUP BY e.DepartmentID) AS AverageTable

--Problem 12.	Highest Peaks in Bulgaria
USE Geography

SELECT mc.CountryCode,
	   m.MountainRange,
	   p.PeakName,
	   p.Elevation
  FROM Mountains AS m
  JOIN MountainsCountries AS mc
    ON m.Id = mc.MountainId
  JOIN Peaks AS p
    ON p.MountainId = mc.MountainId
 WHERE p.Elevation > 2835 AND
	   mc.CountryCode = 'BG'
ORDER BY p.Elevation DESC

--Problem 13.	Count Mountain Ranges
SELECT * FROM
   (SELECT mc.CountryCode,
		   COUNT(m.MountainRange) AS [Count] 
  FROM MountainsCountries AS mc
  JOIN Mountains AS m
    ON m.Id = mc.MountainId
 WHERE mc.CountryCode IN ('BG', 'US', 'RU')
GROUP BY mc.CountryCode) AS [MountainRanges]

--Problem 14.	Countries with Rivers
SELECT TOP(5)
	   c.CountryName,
	   r.RiverName
  FROM Countries AS c
FULL OUTER JOIN CountriesRivers AS cr
    ON cr.CountryCode = c.CountryCode
FULL OUTER  JOIN Rivers AS r
    ON r.Id = cr.RiverId
 WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName ASC

--Problem 15.	*Continents and Currencies

SELECT Ranked.ContinentCode, 
	   Ranked.CurrencyCode,
	   Ranked.CurrentUsage
  FROM (SELECT  c.ContinentCode, 
				c.CurrencyCode,
				COUNT(c.CurrencyCode) AS [CurrentUsage],
				DENSE_RANK() OVER (PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS [Rank]
		  FROM Countries AS c
		  GROUP BY c.CurrencyCode, c.ContinentCode
		  ) AS [Ranked] 
  WHERE Ranked.Rank = 1 AND Ranked.CurrentUsage > 1
  ORDER BY Ranked.ContinentCode ASC

--Problem 16.	Countries without any Mountains

SELECT COUNT(c.CountryCode) AS [CountryCode]
  FROM Countries AS c
  FULL OUTER JOIN MountainsCountries AS mc
    ON mc.CountryCode = c.CountryCode
 WHERE mc.MountainId IS NULL


 --Problem 17.	Highest Peak and Longest River by Country
 SELECT TOP(5)
		RankedPeaks.CountryName AS [CountryName],
   CASE
		WHEN RankedPeaks.PeakName IS NULL THEN '(no highest peak)'
   END AS [HighestPeakName],
   CASE
		WHEN RankedPeaks.PeakName IS NULL THEN 0
   END AS [HighestPeakElevation],
   CASE
		WHEN RankedPeaks.PeakName IS NULL THEN '(no mountain)'
   END AS [Mountain]
   FROM (SELECT c.CountryName,
				p.PeakName,
					DENSE_RANK() OVER 
					(PARTITION BY c.CountryName
				ORDER BY p.Elevation DESC) AS [RankedElevation],
				p.Elevation,
				m.MountainRange
			   FROM Countries AS c
			   LEFT JOIN MountainsCountries AS mc
				 ON mc.CountryCode = c.CountryCode
			   LEFT JOIN Peaks AS p
				 ON p.MountainId = mc.MountainId
			   LEFT JOIN Mountains AS m
			     ON m.Id = mc.MountainId
				 GROUP BY c.CountryName,
						  p.Elevation, 
						  p.PeakName,
						  m.MountainRange ) AS RankedPeaks
 WHERE RankedPeaks.RankedElevation = 1
ORDER BY RankedPeaks.CountryName ASC,
		 RankedPeaks.PeakName ASC
	 

  
