CREATE DATABASE [PolyCafeMau]
USE [PolyCafeMau]
CREATE TABLE Users (
    Username NVARCHAR(20) PRIMARY KEY,
    Password NVARCHAR(50) NOT NULL,
    Enabled BIT NOT NULL,
    Fullname NVARCHAR(50) NOT NULL,
    Photo NVARCHAR(50) NOT NULL,
    Manager BIT NOT NULL
);
INSERT INTO Users VALUES
('admin', '123456', 1, 'Quản trị viên', 'admin.jpg', 1),
('user1', '123456', 1, 'Nguyễn Văn A', 'a.jpg', 0);
CREATE TABLE Cards (
    Id INT PRIMARY KEY,
    Status INT NOT NULL
);
INSERT INTO Cards VALUES
(1, 1),
(2, 0);
CREATE TABLE Categories (
    Id NVARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);
INSERT INTO Categories VALUES
('CAF', 'Cà phê'),
('TEA', 'Trà'),
('MILK', 'Sữa');
CREATE TABLE Drinks (
    Id NVARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(5,2) NOT NULL,
    Image NVARCHAR(50) NOT NULL,
    Available BIT NOT NULL,
    CategoryId NVARCHAR(20) NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO Drinks VALUES
('CF1', 'Cà phê sữa', 25000, 0, 'cf1.jpg', 1, 'CAF'),
('TE1', 'Trà đào', 30000, 5, 'te1.jpg', 1, 'TEA'),
('MK1', 'Sữa tươi trân châu', 35000, 10, 'mk1.jpg', 1, 'MILK');
CREATE TABLE Bills (
    Id BIGINT IDENTITY(10000,1) PRIMARY KEY,
    Username NVARCHAR(20) NOT NULL,
    CardId INT NOT NULL,
    Checkin DATETIME NOT NULL,
    Checkout DATETIME NULL,
    Status INT NOT NULL,
    FOREIGN KEY (Username) REFERENCES Users(Username) ON UPDATE CASCADE,
    FOREIGN KEY (CardId) REFERENCES Cards(Id) ON UPDATE CASCADE
);
INSERT INTO Bills (Username, CardId, Checkin, Checkout, Status) VALUES
('user1', 1, GETDATE(), NULL, 0);

CREATE TABLE BillDetails (
    Id BIGINT IDENTITY(100000,1) PRIMARY KEY,
    BillId BIGINT NOT NULL,
    DrinkId NVARCHAR(20) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(5,2) NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (BillId) REFERENCES Bills(Id) ON DELETE CASCADE,
    FOREIGN KEY (DrinkId) REFERENCES Drinks(Id) ON UPDATE CASCADE
);
INSERT INTO BillDetails (BillId, DrinkId, UnitPrice, Discount, Quantity) VALUES
(10000, 'CF1', 25000, 0, 2),
(10000, 'TE1', 30000, 5, 1);