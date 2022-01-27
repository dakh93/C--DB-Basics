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



  SELECT *
    FROM Projects