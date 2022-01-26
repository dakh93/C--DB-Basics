CREATE DATABASE Bank

USE Bank

CREATE TABLE Clients(
	Id INT IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
)
GO

ALTER TABLE Clients
ADD CONSTRAINT PK_Clients_Id
PRIMARY KEY (Id)
GO

CREATE TABLE AccountTypes(
	Id INT IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)
GO

ALTER TABLE AccountTypes
ADD CONSTRAINT PK_AccountTypes_Id
PRIMARY KEY(Id)
GO

CREATE TABLE Accounts(
	Id INT IDENTITY,
	AccountTypeId INT,
	Balance DECIMAL(15, 2) NOT NULL DEFAULT(0),
	ClientId INT
)
GO

ALTER TABLE Accounts
ADD CONSTRAINT PK_Accounts_Id
PRIMARY KEY (Id)

ALTER TABLE Accounts
ADD CONSTRAINT FK_AccountType_Id
FOREIGN KEY (AccountTypeId) REFERENCES AccountTypes(Id)
GO

ALTER TABLE Accounts
ADD CONSTRAINT FK_Client_Id
FOREIGN KEY (ClientId) REFERENCES Clients(Id)
GO

INSERT INTO Clients (FirstName, LastName) VALUES
('Gosho', 'Ivanov'),
('Pesho', 'Petrov'),
('Ivan', 'Iliev'),
('Merry', 'Ivanova')

INSERT INTO AccountTypes (Name) VALUES
('Checking'),
('Savings')

INSERT INTO Accounts (ClientId, AccountTypeId, Balance) VALUES
(1, 1, 175),
(2, 1, 275.56),
(3, 1, 138.01),
(4, 1, 40.30),
(4, 2, 375.50)
GO


CREATE FUNCTION f_CalculateTotalBalance(@ClientID INT)
RETURNS DECIMAL(15, 2)
BEGIN
	DECLARE @result as DECIMAL(15, 2) = (
		SELECT SUM(Balance)
		FROM Accounts WHERE Id = @ClientID
	)
	RETURN @result
END
GO

--SELECT dbo.f_CalculateTotalBalance(4) AS Balance
--GO

CREATE PROC p_AddAccount @ClinetId INT, @AccountTypeId INT AS
INSERT INTO Accounts(ClientId, AccountTypeId)
VALUES(@ClinetId, @AccountTypeId)
GO

p_AddAccount 2, 2
GO

--SELECT * FROM Accounts

CREATE PROC p_Deposit @AccountId INT, @Amount DECIMAL(15, 2) AS
UPDATE Accounts
SET Balance += @Amount
WHERE Id = @AccountId
GO

CREATE PROC p_Withdraw @AccountId INT, @Amount DECIMAL(15, 2) AS
BEGIN
	DECLARE @OldBalance DECIMAL(15, 2)
	SELECT @OldBalance = Balance FROM Accounts WHERE Id = @AccountId
	IF(@OldBalance - @Amount >=0)
	BEGIN
		UPDATE Accounts
		SET Balance -= @Amount
		WHERE Id = @AccountId
	END
	ELSE
	BEGIN
		RAISERROR('Insufficient funds', 10, 1)
	END
END
GO

CREATE TABLE Transactions(
	Id INT IDENTITY,
	AccountId INT,
	OldBalance DECIMAL(15, 2) NOT NULL,
	NewBalance Decimal(15, 2) NOT NULL,
	Amount AS NewBalance - OldBalance,
	[DateTime] DATETIME2
)
GO


ALTER TABLE Transactions
ADD CONSTRAINT FK_Accounts_Id
FOREIGN KEY (AccountId) REFERENCES Accounts(Id)
GO

CREATE TRIGGER tr_Transaction ON Accounts
AFTER UPDATE
AS
	INSERT INTO Transactions (AccountId, OldBalance, NewBalance, [DateTime])
	SELECT inserted.Id, deleted.Balance, inserted.Balance, GETDATE() FROM inserted
	JOIN deleted ON inserted.Id = deleted.Id
GO

p_Deposit 1, 25.00
GO

p_Deposit 1, 40.00
GO

p_Withdraw 2, 200.00
GO

p_Deposit 4, 180.00
GO

SELECT * FROM Transactions


