--Paul Satterlee
--ITDEV150 Spring2022
--Final Part 2


--1
SET IDENTITY_INSERT Customer ON;

INSERT INTO Customer (CustomerNumber, FName, LName, Address1, Address2, City, State, ZipCode, PhoneNum, MTDSales, 
	YTDSales, CurrentBalance, CreditLimit, ShipName, ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZipCode, 
	CurrentInvoiceTotal, CurrentPaymentTotal, CurrentAmount, Over30, Over60, Over90, PreviousBalance, EmployeeID)
VALUES (3, 'Mary', 'Stephenson', '2545 S 76th Street', '', 'Johnson Creek', 'WI', '54009', '835-555-9898', 
	'550.00', '3400.00', '0.00', '5000.00', 'Mary Stephenson', '2545 S 76th Street', '', 'Johson Creek', 'WI', 
	'54009', '750.00', '750.00', '750.00', 1, 1, 1, '225.00', 2);

SET IDENTITY_INSERT Customer OFF;

--2
UPDATE Customer
SET FName = 'Michelle'
WHERE FName = 'Mary';

--3
UPDATE Customer
SET City = 'Milwaukee', ZipCode = '53201'
WHERE FName = 'Michelle';

--4
DELETE FROM Customer
WHERE FName = 'Michelle';

--5
UPDATE SalesRep
SET CommissionRate = '17';

--6
ALTER TABLE Vendor
ADD Status int
CHECK (Status <= 0 AND Status >= 10);

--7
SELECT FName, LName, PhoneNum
FROM Customer
ORDER BY LName ASC;

--8
SELECT FName, LName, CreditLimit
FROM Customer
WHERE (CreditLimit <= 800);

--9
SELECT OrderNumber
FROM OrderO
WHERE CustomerNumber <= 124
AND OrderDate = '2000-12-01';

--10
SELECT PartNumber, PartDescription, UnitPrice, ReorderPoint
FROM Part
WHERE ReorderPoint >= 10;

--11
SELECT CustomerNumber, LName, FName, LName AS Name
FROM Customer
WHERE LName LIKE 'S%';

--12
SELECT PartNumber, PartDescription, UnitsOnHand
FROM Part
WHERE UnitsOnHand > (SELECT AVG(UnitsOnHand)
						FROM Part);

--13
SELECT MAX(UnitPrice) AS MaxPrice
From Part;

--14
SELECT COUNT(CustomerNumber) AS TotalCustomers
FROM Customer;

--15
SELECT EmployeeID,
SUM(CurrentBalance) AS TotalBalanceForEmployee
FROM Customer
GROUP BY EmployeeID;

--16
SELECT OrderO.OrderNumber, OrderO.OrderDate, Customer.CustomerNumber,
	Customer.LName, Customer.FName
FROM OrderO
INNER JOIN Customer ON OrderO.CustomerNumber = Customer.CustomerNumber
WHERE OrderDate = '12-22-2002';

--17
SELECT OrderO.OrderNumber, OrderO.OrderDate, OrderDetail.PartNumber, 
	OrderDetail.Comments, OrderDetail.NumberOrdered
FROM OrderO
INNER JOIN OrderDetail ON OrderO.OrderNumber = OrderDetail.OrderNumber
ORDER BY OrderNumber ASC;
						
--18
SELECT PartNumber, PartDescription, UnitPrice, Quantity
FROM Part
WHERE UnitPrice = (SELECT MAX(UnitPrice)
					FROM Part);

--19
SELECT Employee.EmployeeID, Employee.EmpName, Customer.CustomerNumber, 
Customer.CreditLimit
FROM Employee
INNER JOIN Customer ON Employee.EmployeeID = Customer.EmployeeID
WHERE Customer.CreditLimit >= '2000.00';