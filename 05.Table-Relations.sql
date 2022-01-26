CREATE DATABASE TableRelations
GO

USE TableRelations
GO

--Problem 1.	One-To-One Relationship
CREATE TABLE Passports(
	PassportID INT NOT NULL IDENTITY(101, 1),
	PassportNumber NVARCHAR(64) NOT NULL,

	CONSTRAINT PK_Passport
	PRIMARY KEY(PassportID),

)
GO

CREATE TABLE Persons(
	PersonID INT NOT NULL IDENTITY,
	FirstName NVARCHAR(32) NOT NULL,
	Salary DECIMAL(15,2) NOT NULL,
	PassportID INT NOT NULL,

	CONSTRAINT PK_Persons
	PRIMARY KEY(PersonID),

	CONSTRAINT FK_Persons_Passports
	FOREIGN KEY(PassportID)
	REFERENCES Passports(PassportID)
)
GO

INSERT INTO Passports
VALUES
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2')
GO

INSERT INTO Persons
VALUES
('Roberto', 43300.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101)
GO

SELECT *
  FROM Passports

--Problem 2.	One-To-Many Relationship
CREATE TABLE Manufacturers(
	ManufacturerID INT NOT NULL IDENTITY,
	[Name] NVARCHAR(32) NOT NULL,
	EstablishedOn NVARCHAR(32),
	
	CONSTRAINT PK_Manufacturers
	PRIMARY KEY(ManufacturerID)
)

CREATE TABLE Models(
	ModelID INT NOT NULL IDENTITY(101, 1),
	[Name] NVARCHAR(32) NOT NULL,
	ManufacturerID INT NOT NULL,

	CONSTRAINT PK_Models
	PRIMARY KEY(ModelID),

	CONSTRAINT FK_Models_Manufacturers
	FOREIGN KEY(ManufacturerID)
	REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers
VALUES
('BMW' , '07/03/1916'),
('Tesla' , '01/01/2003'),
('Lada' , '01/05/1966')

INSERT INTO Models
VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3)


--Problem 3.	Many-To-Many Relationship
CREATE TABLE Students(
	StudentID INT NOT NULL IDENTITY,
	[Name] NVARCHAR(32) NOT NULL,

	CONSTRAINT PK_Students
	PRIMARY KEY(StudentID)
)

CREATE TABLE Exams(
	ExamID INT NOT NULL IDENTITY(101, 1),
	[Name] NVARCHAR(64) NOT NULL,

	CONSTRAINT PK_Exams
	PRIMARY KEY(ExamID)
)

CREATE TABLE StudentsExams(
	StudentID INT NOT NULL,
	ExamID INT NOT NULL,

	CONSTRAINT PK_StudentsExams
	PRIMARY KEY(StudentID, ExamID),

	CONSTRAINT FK_StudentsExams_Exams
	FOREIGN KEY (ExamID)
	REFERENCES Exams(ExamID),

	CONSTRAINT FK_StudentsExams_Students
	FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID)
)

INSERT INTO Students
VALUES
('Mila'),
('Toni'),
('Ron')

INSERT INTO Exams
VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g')


INSERT INTO StudentsExams
VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103)


--Problem 4.	Self-Referencing 
CREATE TABLE Teachers(
	TeacherID INT NOT NULL IDENTITY(101, 1),
	[Name] NVARCHAR(32) NOT NULL,
	ManagerID INT,

	CONSTRAINT PK_Teachers
	PRIMARY KEY(TeacherID),

	CONSTRAINT FK_Teachers
	FOREIGN KEY(ManagerID)
	REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers
VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101)

--Problem 5.	Online Store Database

CREATE DATABASE OnlineStore

USE OnlineStore

CREATE TABLE Cities(
	CityID INT NOT NULL IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_Cities
	PRIMARY KEY(CityID)
)

CREATE TABLE Customers(
	CustomerID INT NOT NULL IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	Birthday DATE NOT NULL,
	CityID INT NOT NULL,

	CONSTRAINT PK_Customers
	PRIMARY KEY(CustomerID),

	CONSTRAINT FK_Customers_Cities
	FOREIGN KEY (CityID)
	REFERENCES Cities(CityID)
)

CREATE TABLE Orders(
	OrderID INT NOT NULL IDENTITY,
	CustomerID INT NOT NULL,

	CONSTRAINT PK_Orders
	PRIMARY KEY(OrderID),

	CONSTRAINT FK_Orders_Customers
	FOREIGN KEY (CustomerID)
	REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes(
	ItemTypeID INT NOT NULL IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_ItemTypes
	PRIMARY KEY(ItemTypeID)
)

CREATE TABLE Items(
	ItemID INT NOT NULL IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	ItemTypeID INT NOT NULL,

	CONSTRAINT PK_Items
	PRIMARY KEY(ItemID),

	CONSTRAINT FK_Items_ItemTypes
	FOREIGN KEY (ItemTypeID)
	REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems(
	OrderID INT NOT NULL,
	ItemID INT NOT NULL,

	CONSTRAINT PK_OrderItems
	PRIMARY KEY(OrderID, ItemID),

	CONSTRAINT FK_OrderItems_Orders
	FOREIGN KEY (OrderID)
	REFERENCES Orders (OrderID),

	CONSTRAINT FK_OrderItems_Items
	FOREIGN KEY (ItemID)
	REFERENCES Items(ItemID)
)

--Problem 6.	University Database
CREATE DATABASE University

USE University

CREATE TABLE Majors(
	MajorID INT NOT NULL IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_MajorID
	PRIMARY KEY (MajorID)
)

CREATE TABLE Students(
	StudentID INT NOT NULL IDENTITY,
	StudentNumber INT NOT NULL, 
	StudentName NVARCHAR(50) NOT NULL,
	MajorID INT NOT NULL,

	CONSTRAINT PK_Students
	PRIMARY KEY (StudentID),

	CONSTRAINT FK_Students_Majors
	FOREIGN KEY (MajorID)
	REFERENCES Majors(MajorID)
)

CREATE TABLE Payments(
	PaymentID INT NOT NULL IDENTITY,
	PaymentDate DATE NOT NULL,
	PaymentAmount DECIMAL(15, 2) NOT NULL,
	StudentID INT NOT NULL,

	CONSTRAINT PK_Payments
	PRIMARY KEY (PaymentID),

	CONSTRAINT FK_Payments_Students
	FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID)

)

CREATE TABLE Subjects(
	SubjectID INT NOT NULL IDENTITY, 
	SubjectName NVARCHAR(50) NOT NULL,

	CONSTRAINT PK_Subjects
	PRIMARY KEY (SubjectID)
)

CREATE TABLE Agenda(
	StudentID INT NOT NULL,
	SubjectID INT NOT NULL,

	CONSTRAINT PK_Agenda_Students_Subjects
	PRIMARY KEY(StudentID, SubjectID),

	CONSTRAINT FK_Agenda_Students
	FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID),

	CONSTRAINT FK_Agenda_Subjects
	FOREIGN KEY (SubjectID)
	REFERENCES Subjects(SubjectID)
)

--Problem 7 & 8 are to create E/R Diagram of ready databases

--Problem 9.	*Peaks in Rila
USE Geography

SELECT m.MountainRange, p.PeakName, p.Elevation
  FROM Mountains AS m
  JOIN Peaks AS p
  ON p.MountainId = m.Id
  WHERE m.MountainRange = 'Rila'
  ORDER BY p.Elevation DESC

