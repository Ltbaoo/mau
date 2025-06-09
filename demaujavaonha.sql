
USE master;
GO

CREATE DATABASE PolyCafeMau;
GO

USE PolyCafeMau;
GO

CREATE TABLE Users (
    Username NVARCHAR(20) PRIMARY KEY,
    Password NVARCHAR(50) NOT NULL,
    Enabled BIT NOT NULL,
    Fullname NVARCHAR(50) NOT NULL,
    Photo NVARCHAR(50) NOT NULL,
    Manager BIT NOT NULL
);

CREATE TABLE Cards (
    Id INT PRIMARY KEY,
    Status INT NOT NULL
);

-- 3. Tạo bảng Categories
CREATE TABLE Categories (
    Id NVARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);

-- 4. Tạo bảng Drinks
CREATE TABLE Drinks (
    Id NVARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(5,2) NOT NULL,
    Image NVARCHAR(50) NOT NULL,
    Available BIT NOT NULL,
    CategoryId NVARCHAR(20) NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. Tạo bảng Bills
CREATE TABLE Bills (
    Id BIGINT IDENTITY(10000,1) PRIMARY KEY,
    Username NVARCHAR(20) NOT NULL,
    CardId INT NOT NULL,
    Checkin DATETIME NOT NULL,
    Checkout DATETIME NULL,
    Status INT NOT NULL,
    FOREIGN KEY (Username) REFERENCES Users(Username)
        ON UPDATE CASCADE,
    FOREIGN KEY (CardId) REFERENCES Cards(Id)
        ON UPDATE CASCADE
);

-- 6. Tạo bảng BillDetails
CREATE TABLE BillDetails (
    Id BIGINT IDENTITY(100000,1) PRIMARY KEY,
    BillId BIGINT NOT NULL,
    DrinkId NVARCHAR(20) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(5,2) NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (BillId) REFERENCES Bills(Id)
        ON DELETE CASCADE,
    FOREIGN KEY (DrinkId) REFERENCES Drinks(Id)
        ON UPDATE CASCADE
);

-- 7. INSERT dữ liệu mẫu

-- Users
INSERT INTO Users VALUES 
('admin', 'admin123', 1, N'Nguyễn Văn A', 'admin.jpg', 1),
('user1', '123456', 1, N'Trần Thị B', 'user1.png', 0);

-- Cards
INSERT INTO Cards VALUES 
(1, 1),
(2, 0);

-- Categories
INSERT INTO Categories VALUES 
('cafe', N'Cà phê'),
('juice', N'Nước ép');

-- Drinks
INSERT INTO Drinks VALUES
('cf1', N'Cà phê đen', 20000, 0, 'cf1.jpg', 1, 'cafe'),
('cf2', N'Cà phê sữa', 25000, 10, 'cf2.jpg', 1, 'cafe'),
('js1', N'Nước cam', 30000, 5, 'js1.jpg', 1, 'juice');

-- Bills
INSERT INTO Bills (Username, CardId, Checkin, Checkout, Status) VALUES
('admin', 1, GETDATE(), NULL, 0),
('user1', 2, GETDATE(), NULL, 0);

-- BillDetails
INSERT INTO BillDetails (BillId, DrinkId, UnitPrice, Discount, Quantity) VALUES
(10000, 'cf1', 20000, 0, 2),
(10000, 'cf2', 25000, 10, 1),
(10001, 'js1', 30000, 5, 1);

