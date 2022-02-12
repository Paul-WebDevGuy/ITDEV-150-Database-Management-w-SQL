--Assignment 2 
--ITDEV150 Spring2022
--Paul Satterlee

--1
SELECT ProductName, ListPrice, DateAdded
FROM Products
ORDER BY ProductName ASC

--2
SELECT *
FROM Categories
ORDER BY CategoryID DESC

--3
SELECT CustomerID, Line1, Line2, City, State, ZipCode
FROM Addresses
WHERE (State = 'NY')

--4
SELECT OrderID, ShipAmount, CardType, CardNumber, CardExpires
FROM Orders
WHERE (CardType = 'Visa')
ORDER BY OrderDate ASC

--5
SELECT ProductName, ListPrice
FROM Products

--6
SELECT *
FROM OrderItems
WHERE (DiscountAmount > 1000)

--7
SELECT *
FROM Administrators
ORDER BY LastName

--8
SELECT FirstName, LastName, EmailAddress 
FROM Customers
WHERE (LastName >= 'M' AND LastName <= 'Zurcher')
ORDER BY LastName 

--9
SELECT *
FROM OrderItems
WHERE (ItemID > 30)
