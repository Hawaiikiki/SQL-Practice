--1
CREATE VIEW view_product_order_Suh
AS
SELECT ProductName, SUM(quantity) AS totalOrderQty
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY ProductName

SELECT *
FROM view_product_order_Suh

--2
CREATE PROC sp_product_order_quantity_Suh
@pId INT,
@totalQty SMALLINT OUT
AS
BEGIN
SELECT @totalQty = SUM(Quantity)
FROM [Order Details]
WHERE ProductID=@pId
END

BEGIN
DECLARE @qty SMALLINT
EXECUTE sp_product_order_quantity_Suh 11, @qty OUT
PRINT @qty
END

--3
--CREATE PROC sp_product_order_city_Suh
--@pName VARCHAR(100),
--@city NVARCHAR(100) OUT,
--@totalCityQty SMALLINT OUT
--AS
--BEGIN
--SELECT TOP 5 @city = o.ShipCity, @totalCityQty=SUM(od.Quantity)
--FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID
--JOIN Products p ON od.ProductID=p.ProductID
--WHERE p.ProductName=@pName
--GROUP BY o.ShipCity
--ORDER BY COUNT(o.OrderID) DESC
--END

CREATE PROC sp_product_order_city_Suh
@pName VARCHAR(100)
AS
BEGIN
SELECT TOP 5 o.ShipCity, SUM(od.Quantity) as TotalQty
FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID
JOIN Products p ON od.ProductID=p.ProductID
WHERE p.ProductName=@pName
GROUP BY o.ShipCity
ORDER BY COUNT(o.OrderID) DESC
END

BEGIN
DECLARE @cityName NVARCHAR(15), @totalQtyforCity SMALLINT
EXECUTE sp_product_order_city_Suh 'Alice Mutton'
END

--SELECT TOP 5 o.ShipCity, SUM(od.Quantity) AS totalQtyOfOrders
--FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID
--JOIN Products p ON od.ProductID=p.ProductID
--WHERE p.ProductName='Chai'
--GROUP BY o.ShipCity
--ORDER BY COUNT(o.OrderID) DESC

--4
CREATE TABLE people_Suh
(
id INT NOT NULL UNIQUE,
Name VARCHAR(20) NOT NULL,
City INT 
)
CREATE TABLE city_Suh
(
Id INT NOT NULL UNIQUE,
City VARCHAR(20) NOT NULL
)

INSERT INTO city_Suh
VALUES
(1,'Seattle'),
(2,'Green Bay')

INSERT INTO people_Suh
VALUES
(1,'Aaron Rodgers',2),
(2,'Russel Wilson',1),
(3,'Jody Nelson',2)

DELETE
FROM city_Suh
WHERE City = 'Seattle'

INSERT INTO city_Suh
VALUES
(1,'Madison')

CREATE VIEW Packers_Sean_Suh
AS
SELECT Name
FROM people_Suh p JOIN city_Suh c
ON p.City = c.id
WHERE c.City='Green Bay'

SELECT *
FROM Packers_Sean_Suh

DROP VIEW Packers_Sean_Suh
DROP TABLE city_Suh, people_Suh

--5
CREATE PROC sp_birthday_employees_Suh
AS
BEGIN
CREATE TABLE birthday_employees_Suh
(
NAME NVARCHAR(30) NOT NULL
)
INSERT INTO birthday_employees_Suh
SELECT LastName+' '+FirstName AS Name
FROM Employees
WHERE MONTH(BirthDate) = '02'
END

EXECUTE sp_birthday_employees_Suh

SELECT *
FROM birthday_employees_Suh

DROP TABLE birthday_employees_Suh

--6
/*
Assuming that both tables have same number of rows (records), we can use UNION to check if two tables are identical.
Since UNION gets rid of any duplicate values, if two tables are identical, resulting table should have same number of rows.
*/