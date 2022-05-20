--1
USE AdventureWorks2019
GO
SELECT cr.Name AS Country, sp.Name AS Province
FROM person.CountryRegion cr JOIN person.StateProvince sp
ON cr.CountryRegionCode = sp.CountryRegionCode

--2
SELECT cr.Name AS Country, sp.Name AS Province
FROM person.CountryRegion cr JOIN person.StateProvince sp
ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE cr.Name IN ('Germany', 'Canada')

--3
USE Northwind
GO

-- Assuming that last 25 years simply mean it's in the order table
SELECT DISTINCT p.ProductName
FROM Orders o LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID

--4
SELECT TOP 5 ShipPostalCode
FROM Orders
GROUP BY ShipPostalCode
ORDER BY COUNT(ShipPostalCode) DESC

--5
SELECT City, COUNT(DISTINCT CustomerID) AS NumOfCustomers
FROM Customers
WHERE PostalCode IN (SELECT TOP 5 ShipPostalCode
FROM Orders
GROUP BY ShipPostalCode
ORDER BY COUNT(ShipPostalCode) DESC)
GROUP BY City

--6
SELECT City, COUNT(DISTINCT CustomerID) AS NumOfCustomers
FROM Customers
GROUP BY City
HAVING COUNT(DISTINCT CustomerID) >2

--7
SELECT c.ContactName, ISNULL(SUM(Quantity),0) AS NumOfProducts
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
LEFT JOIN [Order Details] od ON o.OrderID=od.OrderID
GROUP BY c.ContactName

--8
SELECT c.CustomerID, SUM(od.Quantity) AS NumOfProducts
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
LEFT JOIN [Order Details] od ON o.OrderID=od.OrderID
GROUP BY c.CustomerID
HAVING SUM(Quantity) > 100

--9
SELECT DISTINCT sh.CompanyName, su.CompanyName
FROM Orders o JOIN Shippers sh ON o.ShipVia=sh.ShipperID
JOIN [Order Details] od ON o.OrderID=od.OrderID
JOIN Products p ON od.ProductID=p.ProductID
JOIN Suppliers su ON p.SupplierID=su.SupplierID

--10
SELECT o.OrderDate, p.ProductName
FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID
JOIN Products p ON od.ProductID=p.ProductID
ORDER BY o.OrderDate

--11
SELECT e1.EmployeeID, e2.EmployeeID 
FROM Employees e1 JOIN Employees e2
ON e1.Title=e2.Title
WHERE e1.EmployeeID!=e2.EmployeeID  AND e1.EmployeeID<e2.EmployeeID
-- if we want name, we can do LastName + FirstName AS EmployeeName
SELECT e1.FirstName +' '+ e1.LastName AS EmployeeName1, e2.FirstName +' '+ e2.LastName AS EmployeeName2
FROM Employees e1 JOIN Employees e2
ON e1.Title=e2.Title
WHERE e1.EmployeeID!=e2.EmployeeID  AND e1.EmployeeID<e2.EmployeeID

--12
SELECT e2.EmployeeID
FROM Employees e1 JOIN Employees e2
ON e1.ReportsTo=e2.EmployeeID
GROUP BY e2.EmployeeID
HAVING COUNT(e2.EmployeeID)>2
-- if we want the name,
SELECT FirstName + ' ' +LastName AS Manager
FROM Employees
WHERE EmployeeID IN (
	SELECT e2.EmployeeID
	FROM Employees e1 JOIN Employees e2
	ON e1.ReportsTo=e2.EmployeeID
	GROUP BY e2.EmployeeID
	HAVING COUNT(e2.EmployeeID)>2
)

--13
SELECT City, CompanyName AS Name ,ContactName, 'Customer' AS Type
FROM Customers
UNION
SELECT City, CompanyName AS Name ,ContactName, 'Supplier' AS Type
FROM Suppliers

--14
SELECT DISTINCT e.City
FROM Employees e JOIN Customers c ON e.city=c.city

--15
--a
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN (
	SELECT City
	FROM Employees
)
--b
SELECT DISTINCT c.City
FROM Customers c LEFT JOIN Employees e
ON c.City = e.City
WHERE e.City IS NULL

--16
SELECT p.ProductName, SUM(od.Quantity) AS TotalOrderQty
FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID
JOIN Products p ON od.ProductID=p.ProductID
GROUP BY p.ProductName

--17
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID)>=2
-- not sure how to use UNION or Sub-Query to solve this one without complicating above query

--18
SELECT c.City
FROM Orders o JOIN [Order Details] od ON o.OrderID=od.OrderID 
JOIN Customers c ON o.CustomerID=c.CustomerID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >=2

--19

SELECT TOP 5 ProductName, AVG(od.UnitPrice) AS AvgPrice 
FROM Products p JOIN [Order Details] od ON p.ProductID=od.ProductID
JOIN Orders o ON od.OrderID=o.OrderID
JOIN Customers c ON o.CustomerID=c.CustomerID
GROUP BY ProductName
ORDER BY SUM(od.Quantity) DESC

--20

SELECT a.orderCity, b.qtyCity
FROM 
(SELECT TOP 1 o.ShipCity AS orderCity
FROM Orders o
GROUP BY o.ShipCity
ORDER BY COUNT(o.OrderID) DESC) AS a,
(SELECT TOP 1 o.ShipCity AS qtyCity
FROM Orders o JOIN [Order Details] od
ON o.OrderID=od.OrderID
GROUP BY o.ShipCity
ORDER BY SUM(Quantity) DESC) AS b

--21
/*
We can use DISTINCT or UNION to retrieve data without duplicates.
*/



