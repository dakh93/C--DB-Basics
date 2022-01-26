CREATE DATABASE Minions
GO

USE Minions
GO

CREATE TABLE Minions(
	Id INT NOT NULL,
	[Name] NVARCHAR(50),
	Age INT 
)
GO

ALTER TABLE Minions
ADD CONSTRAINT PK_Minions_Id
PRIMARY KEY (Id)
GO

CREATE TABLE Towns(
	Id INT NOT NULL,
	[Name] NVARCHAR(50) 
)
GO

ALTER TABLE Towns
ADD CONSTRAINT PK_Towns_Id
PRIMARY KEY (Id)
GO

ALTER TABLE Minions
ADD TownId INT
GO

ALTER TABLE MINIONS
ADD CONSTRAINT FK_MinionTown_Id
FOREIGN KEY (TownId) REFERENCES Towns(Id) 
GO

--Problem 4
INSERT INTO Towns(Id, [Name]) VALUES
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna')
GO

INSERT INTO Minions(Id,[Name], Age, TownId) VALUES
(1,'Kevin', 22, 1),
(2,'Bob', 15, 3),
(3,'Steward', NULL,2)
GO


--Problem 5
TRUNCATE TABLE Minions
GO


--Problem 6
DROP TABLE Minions
GO

DROP TABLE Towns
GO

--Problem 7
CREATE TABLE People(
	Id INT IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX),
	Height DECIMAL(15,2),
	[Weight] DECIMAL (15,2),
	Gender NVARCHAR (10) NOT NULL,
	Birthdate NVARCHAR(10) NOT NULL,
	Biography NVARCHAR(MAX) NOT NULL
)
GO



ALTER TABLE People
ADD CONSTRAINT PK_People_Id
PRIMARY KEY (Id)
GO

ALTER TABLE People
ADD CONSTRAINT Check_Gender CHECK (Gender in ('m','f'))
GO

INSERT INTO People([Name], Picture, 
					Height, [Weight], Gender, 
					Birthdate, Biography)
VALUES
('Daniel',NULL, 1.70, 70,'m','15-04-2020', 'Daniel`s Description'),
('Ivana',NULL, 1.50, 60,'f','12-03-2022', 'Ivana`s Description'),
('Georgi',NULL, 1.40, 77,'m','10-08-2016', 'Georgi`s Description'),
('Misho',NULL, 1.80, 88,'m','27-11-2014', 'Misho`s Description'),
('Atanas',NULL, 1.75, 95,'m','05-06-1999', 'Atanas`s Description')
GO

--Problem 8
CREATE TABLE Users(
	Id INT IDENTITY,
	Username NVARCHAR(30) NOT NULL,
	[Password] NVARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(900),
	LastLoginTime DATETIME2,
	IsDeleted NVARCHAR(5)
)
GO



ALTER TABLE Users
ADD CONSTRAINT PK_Users_Id
PRIMARY KEY(Id)
GO

ALTER TABLE Users
ADD CONSTRAINT Check_If_Deleted CHECK (IsDeleted in ('true','false'))
GO

INSERT INTO Users(Username, [Password], ProfilePicture, 
								LastLoginTime,IsDeleted) 
VALUES
('gogata','gogata93', NULL, GETDATE(),'false'),
('babata','babushka', NULL, GETDATE(),'true'),
('borkata','borkaqdosaise', NULL, GETDATE(),'false'),
('dakata','dachkata', NULL, GETDATE(),'false'),
('gilata','gilauspokoise', NULL, GETDATE(),'false')
GO

--Problem 9
ALTER TABLE Users
DROP CONSTRAINT PK_Users_Id
GO

ALTER TABLE Users
ADD CONSTRAINT PK_Users_Id_Username
PRIMARY KEY (Id, Username)
GO

--Problem 10
ALTER TABLE Users
ADD CONSTRAINT Check_Password_Min_Chars CHECK(LEN([Password]) >= 5)
GO

--Problem 11
ALTER TABLE Users
ADD CONSTRAINT DefaultValue_LastLoginTime
DEFAULT GETDATE() FOR LastLoginTime
GO

--Problem 12
ALTER TABLE Users
DROP CONSTRAINT PK_Users_Id_Username
GO

ALTER TABLE Users
ADD CONSTRAINT PK_Users_Id
PRIMARY KEY (Id)
GO

ALTER TABLE Users
ADD CONSTRAINT Unique_Users_Username UNIQUE(Username)
GO

ALTER TABLE Users
ADD CONSTRAINT Check_Username_Min_Password CHECK(LEN(Username) >= 3)
GO
--------------------------------------------------------------
--Problem 13
CREATE DATABASE Movies
GO

USE Movies
GO

--DIRECTORS
CREATE TABLE Directors(
	Id INT IDENTITY,
	DirectorName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE Directors
ADD CONSTRAINT PK_Directors_Id
PRIMARY KEY(Id)

--GENRES
CREATE TABLE Genres(
	Id INT IDENTITY,
	GenreName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE Genres
ADD CONSTRAINT PK_Genres_Id
PRIMARY KEY(Id)

--CATEGORIES
CREATE TABLE Categories(
	Id INT IDENTITY,
	CategoryName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE Categories
ADD CONSTRAINT PK_Categories_Id
PRIMARY KEY(Id)

--MOVIES
CREATE TABLE Movies(
	Id INT IDENTITY,
	Title NVARCHAR(50) NOT NULL,
	DirectorId INT NOT NULL,
	CopyrightYear NVARCHAR(4) NOT NULL,
	[Length] INT NOT NULL,
	GenreId INT NOT NULL,
	CategoryId INT NOT NULL,
	Rating INT,
	Notes NVARCHAR(MAX)
)

ALTER TABLE Movies
ADD CONSTRAINT FK_MoviesDirectors_ID
FOREIGN KEY (DirectorId) REFERENCES Directors(Id) 

ALTER TABLE Movies
ADD CONSTRAINT FK_MoviesGenres_Id
FOREIGN KEY (GenreId) REFERENCES Genres(Id)

ALTER TABLE Movies
ADD CONSTRAINT FK_MoviesCategories_Id
FOREIGN KEY (CategoryId) REFERENCES Categories(Id)

--POPULATING TABLES
INSERT INTO Directors(DirectorName, Notes) VALUES
('John', 'Started in 1995'),
('Patrick', 'Started in 2006'),
('Bob', 'Started in 2017'),
('Gary', 'Started in 2001'),
('Melinda', 'Started in 2000')

INSERT INTO Genres(GenreName, Notes) VALUES
('Horror','Very scary genre'),
('Comedy','Very funny genre'),
('Adventure','Very interesting genre'),
('Biography','Very infromative genre'),
('DIY','If you want to learn doing things this is your gendre')

INSERT INTO Categories(CategoryName, Notes) VALUES
('Adults', 'This category is just for ADULTS'),
('Teenagers', 'This category is for TEENAGERS and ADULTS'),
('Kids', 'This category is for KIDS, TEENAGERS and ADULTS'),
('Elder', 'This category is for Old people'),
('No restriction', 'This category is for everybody')

INSERT INTO Movies(Title, DirectorId, CopyrightYear, [Length],
					GenreId, CategoryId, Rating, Notes)
VALUES
('Wrong Turn',1, '1995', 120, 1, 1, 100, 'Adrenalin is scaling...'),
('Recep Ivedik',2, '2013', 100, 2, 2, 100, 'Funny as HELL.. :)'),
('Aladin',3, '1993', 80, 3, 3, 100, 'Kids will love it...'),
('Animals',4, '1989', 60, 4, 4, 80, 'Elder will love it...'),
('How its made',5, '1975', 80, 5, 5, 45, 'Everybody will love it...')

-----------------------------------------------------------------

--Problem 14

CREATE DATABASE CarRental
GO

USE CarRental
GO

--CATEGORIES
CREATE TABLE Categories(
	Id INT IDENTITY,
	CategoryName NVARCHAR(50) NOT NULL,
	DailyRate INT NOT NULL,
	WeeklyRate INT NOT NULL,
	MonthlyRate INT NOT NULL,
	WeekendRate INT NOT NULL,
)

ALTER TABLE Categories
ADD CONSTRAINT PK_Categories_Id
PRIMARY KEY(Id)

--CARS
CREATE TABLE Cars(
	Id INT IDENTITY,
	PlateNumber NVARCHAR(50) NOT NULL,
	Manufacturer NVARCHAR(50) NOT NULL,
	Model NVARCHAR(50) NOT NULL,
	CarYear NVARCHAR(4) NOT NULL,
	CategoryId INT NOT NULL,
	Doors INT NOT NULL,
	Picture VARBINARY,
	Condition NVARCHAR(50),
	Available NVARCHAR(3) NOT NULL
)

ALTER TABLE Cars
ADD CONSTRAINT PK_Cars_Id
PRIMARY KEY(Id)

ALTER TABLE Cars
ADD CONSTRAINT FK_CarsCategories_Id
FOREIGN KEY (CategoryId) REFERENCES Categories(Id)

ALTER TABLE Cars
ADD CONSTRAINT Check_If_Available CHECK(Available in ('yes','no'))

--EMPLOYEES
CREATE TABLE Employees(
	Id INT IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE Employees
ADD CONSTRAINT PK_Employees_Id
PRIMARY KEY(Id)

--CUSTOMERS
CREATE TABLE Customers(
	Id INT IDENTITY,
	DriverLicenceNumber INT NOT NULL,
	FullName NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(50) NOT NULL,
	City NVARCHAR(50) NOT NULL,
	ZIPCode NVARCHAR(50),
	Notes NVARCHAR(MAX)
)

ALTER TABLE Customers
ADD CONSTRAINT PK_Customers_Id
PRIMARY KEY(Id)

--RENTAL ORDERS
CREATE TABLE RentalOrders(
	Id INT IDENTITY,
	EmployeeId INT NOT NULL,
	CustomerId INT NOT NULL,
	CarId INT NOT NULL,
	TankLevel INT NOT NULL,
	KilometrageStart INT NOT NULL,
	KilometrageEnd INT NOT NULL,
	TotalKilometrage AS KilometrageEnd - KilometrageStart,
	StartDate DATETIME2 NOT NULL,
	EndDate DATETIME2 NOT NULL,
	TotalDays AS DATEDIFF(day, StartDate, EndDate),
	RateApplied INT NOT NULL,
	TaxRate DECIMAL(15,2) NOT NULL,
	OrderStatus NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)



ALTER TABLE RentalOrders
ADD CONSTRAINT PK_RentalOrders_Id
PRIMARY KEY(Id)

ALTER TABLE RentalOrders
ADD CONSTRAINT FK_RentalOrdersEmployees_Id
FOREIGN KEY (EmployeeId) REFERENCES Employees(Id)

ALTER TABLE RentalOrders
ADD CONSTRAINT FK_RentalOrdersCustomers_Id
FOREIGN KEY (CustomerId) REFERENCES Customers(Id)


--POPULATE TABLES

INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, 
						MonthlyRate, WeekendRate)
VALUES
('New', 100, 100, 100, 100),
('Used', 70, 80, 75, 100),
('For-parts', 20, 20, 50, 40)

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, CategoryId,
				Doors, Picture, Condition, Available)
VALUES
('aa11aa','Honda', 'Prelude', '1997', 1, 2, NULL, 'New', 'yes'),
('aa11aa','Mazda', 'Model 3', '2001', 2, 4, NULL, 'Used', 'yes'),
('aa11aa','Toyota', 'Avensis', '2008', 3, 5, NULL, 'for parts', 'no')


INSERT INTO Employees(FirstName, LastName, Title, Notes)
VALUES
('Daniel', 'Atanasov','IT-Intern', 'Very motivated'),
('Delyan', 'Damyanov','IT-FullStack', 'Very smart blyat'),
('Rosi', 'Damyanova','IT-Mid', 'Very smart')

INSERT INTO Customers(DriverLicenceNumber, FullName, 
						[Address], City, ZIPCode, Notes)
VALUES
(1111, 'Bai Hristo', 'Tri ushi', 'Haskovo', NULL, NULL),
(2222, 'Bai Ivan', 'Tri ushi', 'Plovdiv', NULL, NULL),
(3333, 'Bai Shile', 'Tri ushi', 'Sofia', NULL, NULL)


INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, 
						TankLevel, KilometrageStart, KilometrageEnd,
						StartDate, EndDate,
						RateApplied, TaxRate, 
						OrderStatus, Notes)
VALUES
(1, 1, 1, 100, 0, 500,'2021-05-20', '2021-05-25',10, 2,'Rented',NULL),
(2, 2, 2, 80, 120, 250,'2021-06-15', '2021-09-25',20, 5,'Rented',NULL),
(3, 3, 3, 60, 435, 500,'2021-01-20', '2021-05-25',3, 7,'InProgress',NULL)

---------------------------------------------------------------

--Problem 15. Hotel Database

CREATE DATABASE Hotel

USE Hotel

--Employees
CREATE TABLE Employees(
	Id INT IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE Employees
ADD CONSTRAINT PK_Employees_Id
PRIMARY KEY(Id)

--Customers
CREATE TABLE Customers(
	AccountNumber INT IDENTITY, 
	FirstName NVARCHAR(50) NOT NULL, 
	LastName NVARCHAR(50) NOT NULL, 
	PhoneNumber NVARCHAR(50) NOT NULL, 
	EmergencyName NVARCHAR(50) NOT NULL,  
	EmergencyNumber NVARCHAR(50) NOT NULL, 
	Notes NVARCHAR(MAX) 
)

ALTER TABLE Customers
ADD CONSTRAINT PK_Customers_AccountNumber
PRIMARY KEY(AccountNumber)

--RoomStatus
CREATE TABLE RoomStatus(
	Id INT IDENTITY NOT NULL,
	RoomStatus NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE RoomStatus
ADD CONSTRAINT PK_RoomStatus_Id
PRIMARY KEY(Id)



--RoomType
CREATE TABLE RoomTypes(
	Id INT IDENTITY NOT NULL,
	RoomType NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)


ALTER TABLE RoomTypes
ADD CONSTRAINT PK_RoomTypes_Id
PRIMARY KEY(Id)


--BedType
CREATE TABLE BedTypes(
	Id INT IDENTITY NOT NULL,
	BedType NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)



ALTER TABLE BedTypes
ADD CONSTRAINT PK_BedTypes_Id
PRIMARY KEY(Id)

--Rooms
CREATE TABLE Rooms(
	RoomNumber INT IDENTITY,
	RoomType INT NOT NULL,
	BedType INT NOT NULL,
	Rate INT,
	RoomStatus INT NOT NULL,
	Notes NVARCHAR(MAX)
)

ALTER TABLE Rooms
ADD CONSTRAINT PK_Rooms_RoomNumber
PRIMARY KEY(RoomNumber)

ALTER TABLE Rooms
ADD CONSTRAINT FK_RoomsRoomType_Id
FOREIGN KEY(RoomType) REFERENCES RoomTypes(Id)

ALTER TABLE Rooms
ADD CONSTRAINT FK_RoomsBedType_Id
FOREIGN KEY(BedType) REFERENCES BedTypes(Id)

ALTER TABLE Rooms
ADD CONSTRAINT FK_RoomsRoomStatus_Id
FOREIGN KEY(RoomStatus) REFERENCES RoomStatus(Id)

--Payments
CREATE TABLE Payments(
	Id INT IDENTITY,
	EmployeeId INT NOT NULL,
	PaymentDate DATETIME2 NOT NULL,
	AccountNumber INT NOT NULL,
	FirstDateOccupied DATETIME2 NOT NULL,
	LastDateOccupied DATETIME2 NOT NULL,
	TotalDays AS DATEDIFF(day,LastDateOccupied,FirstDateOccupied),
	AmountCharged DECIMAL(15,2) NOT NULL,
	TaxRate DECIMAL(15,2) NOT NULL,
	TaxAmount AS AmountCharged * TaxRate / 100,
	PaymentTotal AS AmountCharged + (AmountCharged * TaxRate / 100),
	Notes NVARCHAR(MAX),
)

--Occupancies
CREATE TABLE Occupancies(
	Id INT IDENTITY, 
	EmployeeId INT NOT NULL, 
	DateOccupied DATETIME2 NOT NULL, 
	AccountNumber INT NOT NULL, 
	RoomNumber INT NOT NULL, 
	RateApplied DECIMAL (15,2) NOT NULL, 
	PhoneCharge DECIMAL(15,2) NOT NULL, 
	Notes NVARCHAR(MAX)
)

ALTER TABLE Occupancies
ADD CONSTRAINT FK_OccupanciesEmployees_Id
FOREIGN KEY(EmployeeId) REFERENCES Employees(Id)

ALTER TABLE Occupancies
ADD CONSTRAINT FK_OccupanciesCustomers_AccountNumber
FOREIGN KEY(AccountNumber) REFERENCES Customers(AccountNumber)

ALTER TABLE Occupancies
ADD CONSTRAINT FK_OccupanciesRooms_RoomNumber
FOREIGN KEY(RoomNumber) REFERENCES Rooms(RoomNumber)

--POPULATE TABLES
INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES
('Daniel', 'Atanasov','WSWCF', NULL),
('Bai', 'Ivan','Yamamoto', NULL),
('Borkata', 'Balukov','Marathon', NULL)

INSERT INTO Customers (FirstName, LastName, 
						PhoneNumber, EmergencyName, 
						EmergencyNumber, Notes)
VALUES
('Georgi', 'Georgiev','0888987877', 'Tosho', '0887774458', NULL),
('Plamen', 'Ivanov','0888926877', 'Ivan', '0889966458', NULL),
('Rusi', 'Kostov','0879852215', 'Lucho', '0899653545', NULL)

INSERT INTO RoomStatus(RoomStatus)
VALUES
('Occupied'),
('Reserved'),
('Free')

INSERT INTO RoomTypes(RoomType)
VALUES
('Single'),
('Double'),
('Thriple')

INSERT INTO BedTypes(BedType)
VALUES
('SingleBed'),
('DoubleBed'),
('QueenBed')

INSERT INTO Rooms(RoomType, BedType, Rate, RoomStatus)
VALUES
(1, 1, 20, 1),
(2, 2, 30, 2),
(3, 3, 40, 3)

INSERT INTO Payments(EmployeeId, PaymentDate, AccountNumber, 
					FirstDateOccupied, LastDateOccupied, 
					AmountCharged, TaxRate, Notes)
VALUES
(1, '2021-12-03', 1, '2021-12-10', '2021-12-15', 215.70, 9, NULL),
(2, '2021-12-05', 2, '2021-12-12', '2021-12-19', 275.90, 6, NULL),
(3, '2021-12-22', 3, '2021-12-24', '2021-12-27', 400.99, 3, NULL)

INSERT INTO Occupancies(EmployeeId, DateOccupied, AccountNumber, 
						RoomNumber, RateApplied, PhoneCharge, Notes)
VALUES
(1, '2021-12-03', 1, 1, 9, 10, NULL),
(2, '2021-12-07', 3, 2, 6, 20, NULL),
(3, '2021-12-09', 3, 3, 3, 30, NULL)

------------------------------------------------------------------

--Problem 16. Create SoftUni Database
CREATE DATABASE SoftUni

USE SoftUni

--TOWNS
CREATE TABLE Towns(
	Id INT IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

ALTER TABLE Towns
ADD CONSTRAINT PK_Towns_Id
PRIMARY KEY(Id)

--ADDRESSES
CREATE TABLE Addresses(
	Id INT IDENTITY,
	AddressText NVARCHAR(50) NOT NULL,
	TownId INT NOT NULL
)

ALTER TABLE Addresses
ADD CONSTRAINT PK_Addresses_Id
PRIMARY KEY(Id)

ALTER TABLE Addresses
ADD CONSTRAINT FK_AddressesTowns_Id
FOREIGN KEY(TownId) REFERENCES Towns(Id)


--DEPARTMENTS
CREATE TABLE Departments(
	Id INT IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

ALTER TABLE Departments
ADD CONSTRAINT PK_Departments_Id
PRIMARY KEY(Id)

--EMPLOYEES
CREATE TABLE Employees(
	Id INT IDENTITY, 
	FirstName NVARCHAR(50) NOT NULL, 
	MiddleName NVARCHAR(50) NOT NULL,  
	LastName NVARCHAR(50) NOT NULL, 
	JobTitle NVARCHAR(50) NOT NULL, 
	DepartmentId INT NOT NULL,
	HireDate DATETIME2,
	Salary DECIMAL(15,2) NOT NULL, 
	AddressId INT
)



ALTER TABLE Employees
ADD CONSTRAINT PK_Employees_Id
PRIMARY KEY (Id)

ALTER TABLE Employees
ADD CONSTRAINT FK_EmployeesDepartments_Id
FOREIGN KEY(DepartmentId) REFERENCES Departments(Id)

ALTER TABLE Employees
ADD CONSTRAINT FK_EmployeesAddresses_Id
FOREIGN KEY(AddressId) REFERENCES Addresses(Id)

--Problem 17. Backup Database
BACKUP DATABASE SoftUni
TO DISK = 'D:\SoftUni-ComeBack\C#-DB-Basics\softuni-backup.bak'; 

DROP DATABASE SoftUni

RESTORE DATABASE SoftUni FROM DISK = 'D:\SoftUni-ComeBack\C#-DB-Basics\softuni-backup.bak'

--Problem 18. Basic Insert

INSERT INTO Towns([Name]) VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO Departments([Name]) VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

INSERT INTO Employees(FirstName, MiddleName, LastName, JobTitle,
						DepartmentId, HireDate, Salary)
VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Delevoper', 4, '2013-02-01', 3500),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000),
('Petar', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88)

-------------------------------------------------------------------
--Problem 19. Basic Select All Fields
SELECT * FROM Towns

SELECT * FROM Departments

SELECT * FROM Employees

--Problem.20 Basic Select All Fields and Order Them
SELECT * FROM Towns
ORDER BY [Name]

SELECT * FROM Departments
ORDER BY [Name]

SELECT * FROM Employees
ORDER BY Salary DESC

--Problem 21.Basic Select Some Fields
SELECT [Name]
FROM Towns
ORDER BY [Name]

SELECT [Name]
FROM Departments
ORDER BY [Name]

SELECT FirstName, LastName, JobTitle, Salary
FROM Employees
ORDER BY Salary DESC

--Problem 22. Increase Employees Salary
UPDATE Employees
SET Salary = Salary * 1.1

SELECT Salary
FROM Employees

--Problem 23.Decrease Tax Rate
USE Hotel

UPDATE Payments
SET TaxRate = TaxRate / 1.03

SELECT TaxRate
FROM Payments

--Problem 24. Delete All Records
DELETE FROM Occupancies


