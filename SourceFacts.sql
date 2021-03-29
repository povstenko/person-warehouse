SELECT * FROM Person.Person AS p
INNER JOIN Person.BusinessEntity AS be
ON p.BusinessEntityID = be.BusinessEntityID
INNER JOIN Person.BusinessEntityAddress AS bea
ON be.BusinessEntityID = bea.BusinessEntityID
INNER JOIN Person.Address AS a
ON bea.AddressID = a.AddressID

--Person, Address keys
SELECT p.BusinessEntityID, a.AddressID
FROM Person.Person AS p
INNER JOIN Person.BusinessEntityAddress AS bea
ON p.BusinessEntityID = bea.BusinessEntityID
INNER JOIN Person.Address AS a
ON bea.AddressID = a.AddressID

SELECT *
FROM Person.Person AS p
INNER JOIN Person.BusinessEntityAddress AS bea
ON p.BusinessEntityID = bea.BusinessEntityID
INNER JOIN Person.Address AS a
ON bea.AddressID = a.AddressID
INNER JOIN Sales.Customer AS c
ON p.BusinessEntityID = c.CustomerID
INNER JOIN Sales.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID


--Person, Address, SalesOrder keys + OrderDate
SELECT p.BusinessEntityID, a.AddressID, soh.SalesOrderID, soh.OrderDate
FROM Person.Person AS p
INNER JOIN Person.BusinessEntityAddress AS bea
ON p.BusinessEntityID = bea.BusinessEntityID
INNER JOIN Person.Address AS a
ON bea.AddressID = a.AddressID
INNER JOIN Sales.Customer AS c
ON p.BusinessEntityID = c.CustomerID
INNER JOIN Sales.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
ORDER BY p.BusinessEntityID, a.AddressID, soh.SalesOrderID