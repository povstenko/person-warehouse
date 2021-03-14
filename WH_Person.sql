CREATE DATABASE WH_Person
GO
USE WH_Person
GO

-- ************************************** [Person]

CREATE TABLE [PersonDim]
(
 [BussinessEntityID] int PRIMARY KEY IDENTITY NOT NULL,
 [PersonType]        nvarchar(2) NOT NULL,
 [Sex]               nvarchar(10) NOT NULL,
 [Name]              nvarchar(150) NOT NULL,
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
 [AddressLine]       nvarchar(120) NOT NULL,
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
 [ProductID]       int NOT NULL,
 [UnitPrice]       money NOT NULL,
 [SubTotal]        money NOT NULL,
 [TaxAmt]          money NOT NULL,
 [Freight]          money NOT NULL,
 [TotalDue]        AS isnull(([SubTotal]+[TaxAmt])+[Freight],(0)),
 [ShipMethod]      nvarchar(50) NOT NULL,
 [ShipBase]        money NOT NULL,
 [ShipRate]        money NOT NULL
);
GO

-- ************************************** [Date]

CREATE TABLE [DateDim]
(
 [DateID]    int PRIMARY KEY IDENTITY NOT NULL,
 [OrderDate] datetime NOT NULL,
 [DueDate]   datetime NOT NULL,
 [ShipDate]  datetime NOT NULL
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
 CONSTRAINT [FK_42] FOREIGN KEY ([PersonID])  REFERENCES [PersonDim]([BussinessEntityID]),
 CONSTRAINT [FK_59] FOREIGN KEY ([SalesOrderID])  REFERENCES [SalesOrderDim]([SalesOrderID]),
 CONSTRAINT [FK_68] FOREIGN KEY ([DateID])  REFERENCES [DateDim]([DateID])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_40] ON [Facts] 
 (
  [AddressID] ASC
 )
GO

CREATE NONCLUSTERED INDEX [fkIdx_43] ON [Facts] 
 (
  [PersonID] ASC
 )
GO

CREATE NONCLUSTERED INDEX [fkIdx_60] ON [Facts] 
 (
  [SalesOrderID] ASC
 )
GO

CREATE NONCLUSTERED INDEX [fkIdx_69] ON [Facts] 
 (
  [DateID] ASC
 )
GO