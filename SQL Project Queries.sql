--1.1
SELECT 
CustomerID, CompanyName, Address, City, Region, PostalCode, Country 
FROM Customers 
WHERE City ='Paris' OR City = 'London';

--1.2
SELECT * 
FROM Products 
WHERE QuantityPerUnit LIKE '%bottles';

--1.3
SELECT Suppliers.CompanyName, Suppliers.Country, Products.*
FROM Products 
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE QuantityPerUnit LIKE '%bottles';


--1.4
SELECT COUNT(Categories.CategoryID) 'CategoryID', Categories.CategoryName 
FROM Categories 
INNER JOIN Products ON Categories.CategoryID=Products.CategoryID
GROUP BY Categories.CategoryName
ORDER BY COUNT(Categories.CategoryID) DESC;


--1.5
SELECT 
CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) AS 'Full Name & Title', City 
FROM Employees;

--1.6

--1.7
SELECT COUNT(OrderID) 
FROM Orders 
WHERE Freight > 100.00 AND ShipCountry IN ('USA', 'UK');

--1.8
SELECT OrderID, Discount 
FROM [Order Details] 
WHERE Discount = (SELECT MAX(Discount) FROM [Order Details]);

--2.1
DROP TABLE spartansTable;
CREATE TABLE [spartansTable](
	[spartanID] [int] IDENTITY(1,1) NOT NULL,
	[title] [char](6) NULL,
	[firstName] [varchar](255) NULL,
	[lastName] [varchar](255) NULL,
	[universityAttended] [varchar](255) NULL,
	[courseTaken] [varchar](255) NULL,
	[gradeAchieved] [varchar](6) NULL);

--2.2
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Joyel', 'Shaju', 'Coventry', 'Computer Science', '1st');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Victor', 'Granados', 'Granada', 'Information and Documentation', '2nd');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Jack', 'Farmer', 'Leeds', 'Physics', '2:1');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Mohammad', 'Khwaja', 'Westminster', 'Electronic Engineering', '2:2');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Thomas', 'Briggs', 'Bournemouth', 'Exercise Science', '1st');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Shaqi', 'Abdullah', 'Brunel', 'Mechanical Engineering', '2:1');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Zaid', 'Iqbal', 'QMUL', 'Computer Science', '2:1');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Paul', 'Brewer', 'Hull', 'Computer Science', '1st');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MRS', 'Elizabeth', 'Nicholls', 'Canterbury Christ Church University', 'Sport and Exercise Science', '1st');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Daniel', 'Lippross', 'Hull', 'Chemistry', '2:1');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MRS', 'Ariadna', 'Gonzalez', 'London Metropolitan', 'Business Information Technology', '1st');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Ygor', 'Teixeira', 'University of Greenwich', 'Games Design and Development', '2:2');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Anjum', 'Ali', 'Queen Mary University', 'Mathematics', '2:2');
INSERT INTO spartansTable
(title, firstName, lastName,universityAttended, courseTaken, gradeAchieved)
VALUES
('MR', 'Hussain', 'Fiaz', 'University of East London', 'Computer Science', '2:2');


--3.1
SELECT 
CONCAT(e.Title , ': ' , e.FirstName , ' ' , e.LastName) AS "Employee",
CONCAT(m.Title , ': ' , m.FirstName , ' ' , m.LastName) AS "Employee Reports To"
FROM Employees e
LEFT JOIN Employees m ON m.EmployeeID = e.ReportsTo;

--3.2
SELECT 
s.CompanyName AS "Company Name", 
SUM((od.UnitPrice*od.Quantity)*(1-od.discount)) AS "Sales Total"
FROM Suppliers AS "s"
INNER JOIN Products AS "p" ON s.SupplierID = p.SupplierID
INNER JOIN [Order Details] AS "od" ON od.ProductID = p.ProductID
GROUP BY s.CompanyName
HAVING SUM((od.UnitPrice*od.Quantity)*(1-od.discount)) > 10000
ORDER BY "Sales Total" DESC;


--3.3
SELECT TOP 10
CustomerID AS "Customer",
SUM(UnitPrice * Quantity * (1 - Discount)) AS "Total Sales"
FROM Orders AS "o"
JOIN [Order Details] AS "od"
ON o.OrderID = od.OrderID
GROUP BY CustomerID, OrderDate
HAVING YEAR(OrderDate) = 1998
ORDER BY "Total Sales" DESC;


--3.4
SELECT 
CONCAT(MONTH(OrderDate), ' ', YEAR(OrderDate)) AS "Order Date",
AVG(DATEDIFF(DAY, OrderDate, ShippedDate)) AS "Average Shipping Time"
FROM Orders
GROUP BY CONCAT(MONTH(OrderDate), ' ', YEAR(OrderDate));
