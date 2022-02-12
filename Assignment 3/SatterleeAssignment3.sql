/**
Paul Satterlee
ITDEV150-Spring2022
Assignment 2
**/

--2
SELECT ProductCode, ProductName, ListPrice, DiscountPercent
FROM Products
ORDER BY ListPrice desc

--3
SELECT CONCAT(LastName, ', ', FirstName) AS FullName
FROM Customers
WHERE LastName > 'M'
ORDER BY LastName ASC;

--4
SELECT ProductName, ListPrice, DateAdded
FROM Products
WHERE ListPrice > 500 AND ListPrice < 2000
ORDER BY DateAdded DESC;

--5
SELECT ProductName, ListPrice, DiscountPercent, (ListPrice * (DiscountPercent * .01)) AS DiscountAmount, (ListPrice - (ListPrice * (DiscountPercent * .01))) AS DiscountPrice
FROM Products
ORDER BY DiscountPrice DESC;

--6
SELECT ItemID, ItemPrice, DiscountAmount, Quantity,(ItemPrice * Quantity) AS PriceTotal, (DiscountAmount * Quantity) AS DiscountTotal, ((ItemPrice - DiscountAmount) * Quantity) AS ItemTotal
FROM OrderItems
WHERE (ItemPrice - DiscountAmount) * Quantity > 500
ORDER BY ItemTotal DESC;

--7
SELECT OrderID, OrderDate, ShipDate
FROM Orders
WHERE ShipDate IS NULL;