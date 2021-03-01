CREATE DATABASE PersonWH
USE PersonWH

-- ************************************** [Person]

CREATE TABLE [Person]
(
 [BussinessEntityID] int NOT NULL ,
 [PersonType]        nvarchar(2) NOT NULL ,
 [Sex]               nvarchar(10) NOT NULL ,
 [Name]              nvarchar(150) NOT NULL ,
 [EmailPromotion]    int NOT NULL ,
 [EmailAddress]      nvarchar(50) NULL ,
 [PhoneNumber]       nvarchar(25) NOT NULL ,
 [PhoneNumberType]   nvarchar(50) NOT NULL ,


 CONSTRAINT [PK_person] PRIMARY KEY CLUSTERED ([BussinessEntityID] ASC)
);
GO

-- ************************************** [Address]

CREATE TABLE [Address]
(
 [AddressID]         int NOT NULL ,
 [AddressLine]       nvarchar(120) NOT NULL ,
 [City]              nvarchar(30) NOT NULL ,
 [StateProvinceCode] nvarchar(3) NOT NULL ,
 [StateProvinceName] nvarchar(50) NOT NULL ,
 [CountryRegionCode] nvarchar(3) NOT NULL ,
 [CountryRegionName] nvarchar(50) NOT NULL ,
 [PostalCode]        nvarchar(15) NULL ,


 CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED ([AddressID] ASC)
);
GO

-- ************************************** [SalesOrder]

CREATE TABLE [SalesOrder]
(
 [SalesOrderID]    int NOT NULL ,
 [OnlineOrderFlag] smallint NOT NULL ,
 [OrderQty]        smallint NOT NULL ,
 [ProductID]       int NOT NULL ,
 [UnitPrice]       money NOT NULL ,
 [SubTotal]        money NOT NULL ,
 [TaxAmt]          money NOT NULL ,
 [Freight]          money NOT NULL ,
 [TotalDue]        AS isnull(([SubTotal]+[TaxAmt])+[Freight],(0)) ,
 [ShipMethod]      nvarchar(50) NOT NULL ,
 [ShipBase]        money NOT NULL ,
 [ShipRate]        money NOT NULL ,


 CONSTRAINT [PK_salesorder] PRIMARY KEY CLUSTERED ([SalesOrderID] ASC)
);
GO

-- ************************************** [Date]

CREATE TABLE [Date]
(
 [DateID]    int NOT NULL ,
 [OrderDate] datetime NOT NULL ,
 [DueDate]   datetime NOT NULL ,
 [ShipDate]  datetime NOT NULL ,


 CONSTRAINT [PK_date] PRIMARY KEY CLUSTERED ([DateID] ASC)
);
GO

-- ************************************** [Facts]

CREATE TABLE [Facts]
(
 [FactID]       int NOT NULL ,
 [AddressID]    int NOT NULL ,
 [PersonID]     int NOT NULL ,
 [SalesOrderID] int NOT NULL ,
 [DateID]       int NOT NULL ,


 CONSTRAINT [PK_facts] PRIMARY KEY CLUSTERED ([FactID] ASC, [AddressID] ASC, [PersonID] ASC, [SalesOrderID] ASC, [DateID] ASC),
 CONSTRAINT [FK_39] FOREIGN KEY ([AddressID])  REFERENCES [Address]([AddressID]),
 CONSTRAINT [FK_42] FOREIGN KEY ([PersonID])  REFERENCES [Person]([BussinessEntityID]),
 CONSTRAINT [FK_59] FOREIGN KEY ([SalesOrderID])  REFERENCES [SalesOrder]([SalesOrderID]),
 CONSTRAINT [FK_68] FOREIGN KEY ([DateID])  REFERENCES [Date]([DateID])
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
