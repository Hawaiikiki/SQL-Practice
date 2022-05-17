use AdventureWorks2019
GO
--1
SELECT ProductID,Name,Color,ListPrice
FROM Production.Product

--2
SELECT ProductID,Name,Color,ListPrice
FROM Production.Product
WHERE ListPrice != 0

--3
SELECT ProductID,Name,Color,ListPrice
FROM Production.Product
WHERE Color IS NOT NULL

--4
SELECT ProductID,Name,Color,ListPrice
FROM Production.Product
WHERE Color IS NOT NULL AND ListPrice > 0

--5
SELECT Name +' ' +Color
FROM Production.Product
WHERE Color IS NOT NULL

--6
SELECT Name, Color
FROM Production.Product
WHERE Color in ('Black','Silver') AND Name LIKE 'Chainring%' OR Name LIKE '%Crankarm'

--7
SELECT ProductID,Name
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500

--8
SELECT ProductID,Name, Color
FROM Production.Product
WHERE Color IN ('Black','Blue')

--9
SELECT Name
FROM Production.Product
WHERE Name LIKE 'S%'

--10
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE '[AS]%'
ORDER BY Name

--11
SELECT Name
FROM Production.Product
WHERE Name LIKE 'SPO[^K]%'
ORDER BY Name

--12
SELECT DISTINCT ProductSubcategoryID, Color
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL AND Color IS NOT NULL
