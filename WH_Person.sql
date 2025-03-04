CREATE DATABASE WH_Person
GO
USE WH_Person
GO

-- ************************************** [Person]

CREATE TABLE [PersonDim]
(
 [BusinessEntityID]  int PRIMARY KEY IDENTITY NOT NULL,
 [PersonType]        nvarchar(2) NOT NULL,
 [Sex]               nvarchar(10) NULL,
 [Name]              nvarchar(152) NULL,
 [EmailPromotion]    int NOT NULL,
 [EmailAddress]      nvarchar(50) NULL,
 [PhoneNumber]       nvarchar(25) NOT NULL,
 [PhoneNumberType]   nvarchar(50) NOT NULL,
 StartDate           datetime NOT NULL,
 EndDate             datetime NULL
);
GO

-- ************************************** [Address]

CREATE TABLE [AddressDim]
(
 [AddressID]         int PRIMARY KEY IDENTITY NOT NULL,
 [AddressLine]       nvarchar(121) NOT NULL,
 [City]              nvarchar(30) NOT NULL,
 [StateProvinceCode] nvarchar(3) NOT NULL,
 [StateProvinceName] nvarchar(50) NOT NULL,
 [CountryRegionCode] nvarchar(3) NOT NULL,
 [CountryRegionName] nvarchar(50) NOT NULL,
 [PostalCode]        nvarchar(15) NULL,
 StartDate           datetime NOT NULL,
 EndDate             datetime NULL
);
GO

-- ************************************** [SalesOrder]

CREATE TABLE [SalesOrderDim]
(
 [SalesOrderID]    int PRIMARY KEY IDENTITY NOT NULL,
 [OnlineOrderFlag] smallint NOT NULL,
 [OrderQty]        smallint NOT NULL,
 [UnitPrice]       money NOT NULL,
 [SubTotal]        money NOT NULL,
 [TaxAmt]          money NOT NULL,
 [Freight]         money NOT NULL,
 [TotalDue]        money NOT NULL,
 [ShipMethod]      nvarchar(50) NOT NULL,
 [ShipBase]        money NOT NULL,
 [ShipRate]        money NOT NULL
);
GO

-- ************************************** [Date]

CREATE TABLE [DateDim]
(
 [DateID]		  int PRIMARY KEY IDENTITY NOT NULL,
 [FullDate]	      datetime NOT NULL,
 [Year]           smallint NOT NULL,
 [HalfYear]       tinyint NOT NULL,
 [Quarter]        tinyint NOT NULL,
 [MonthNumOfYear] tinyint NOT NULL,
 [MonthName]      nvarchar(30) NOT NULL,
 [DayNumOfMonth]  tinyint NOT NULL,
 [DayNameOfWeek]  nvarchar(30) NOT NULL,
 [WeekNumOfMonth] tinyint NOT NULL
 );
GO

-- ************************************** [Facts]

CREATE TABLE [Facts]
(
 [FactID]       int PRIMARY KEY IDENTITY NOT NULL,
 [AddressID]    int NOT NULL,
 [PersonID]     int NOT NULL,
 [SalesOrderID] int NOT NULL,
 [DateID]       int NOT NULL,

 CONSTRAINT [FK_39] FOREIGN KEY ([AddressID])  REFERENCES [AddressDim]([AddressID]),
 CONSTRAINT [FK_42] FOREIGN KEY ([PersonID])  REFERENCES [PersonDim]([BusinessEntityID]),
 CONSTRAINT [FK_59] FOREIGN KEY ([SalesOrderID])  REFERENCES [SalesOrderDim]([SalesOrderID]),
 CONSTRAINT [FK_68] FOREIGN KEY ([DateID])  REFERENCES [DateDim]([DateID])
);
GO
