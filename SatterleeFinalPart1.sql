--Paul Satterlee
--ITDEV-150 Spring 2022
--Final Project Part 1


/********************************************************
* This script creates the database named AcmeFurniture 
*********************************************************/

USE master;
GO

IF  DB_ID('AcmeFurniture') IS NOT NULL
DROP DATABASE AcmeFurniture;
GO

CREATE DATABASE AcmeFurniture;
GO
		
USE AcmeFurniture;

--Create tables for AcmeFurniture database
CREATE TABLE Territory (
	TerritoryNumber		INT				PRIMARY KEY		IDENTITY, 
	TerritoryName		VARCHAR(255)	NOT NULL, 
	Region				VARCHAR(255)	NOT NULL, 
	Quota				INT				NOT NULL
);  

CREATE TABLE SalesRep (
	EmployeeID				INT			PRIMARY KEY		IDENTITY, 
	MTDSales				MONEY		NOT NULL, 
	YTDSales				MONEY		NOT NULL, 
	MTDCommission			MONEY		NOT NULL, 
	YTDCommission			MONEY		NOT NULL,  
	CommissionRate			MONEY		NOT NULL
);  

CREATE TABLE Employee (
	EmployeeID			INT				PRIMARY KEY		IDENTITY, 
	EmpName				VARCHAR(255)	NOT NULL,
	EmpAddress1			VARCHAR(255)	NOT NULL, 
	EmpAdress2			VARCHAR(255)	NOT NULL,  
	EmpCity				VARCHAR(60)		NOT NULL,
	EmpState			VARCHAR(2)		NOT NULL,
	EmpZip				VARCHAR(5)		NOT NULL,
	EmpPhone			VARCHAR(12)		NOT NULL
);

CREATE TABLE Customer (
	CustomerNumber			INT			PRIMARY KEY		IDENTITY, 
	FName					VARCHAR(60)		NOT NULL, 
	LName					VARCHAR(60)		NOT NULL, 
	Address1				VARCHAR(255)	NOT NULL, 
	Address2				VARCHAR(255)				DEFAULT NULL, 
	City					VARCHAR(60)		NOT NULL, 
	State					VARCHAR(2)		NOT NULL, 
	ZipCode					VARCHAR(5)		NOT NULL, 
	PhoneNum				VARCHAR(12)		NOT NULL, 
	MTDSales				MONEY			NOT NULL, 
	YTDSales				MONEY			NOT NULL, 
	CurrentBalance			MONEY			NOT NULL, 
	CreditLimit				MONEY			NOT NULL, 
	ShipName				VARCHAR(60)		NOT NULL, 
	ShipAddress1			VARCHAR(255)	NOT NULL,
	ShipAddress2			VARCHAR(255)				DEFAULT NULL, 
	ShipCity				VARCHAR(60)		NOT NULL, 
	ShipState				VARCHAR(2)		NOT NULL, 
	ShipZipCode				VARCHAR(5)		NOT NULL, 
	CurrentInvoiceTotal		MONEY			NOT NULL, 
	CurrentPaymentTotal		MONEY			NOT NULL, 
	CurrentAmount			MONEY			NOT NULL, 
	Over30					INT				NOT NULL, 
	Over60					INT				NOT NULL, 
	Over90					INT				NOT NULL,  
	PreviousBalance			MONEY			NOT NULL
);  

CREATE TABLE Part ( 		
	PartNumber				INT             NOT NULL		IDENTITY, 
	VendorNumber			INT				NOT NULL,
	PartDescription			TEXT			NOT NULL, 
	UnitPrice				MONEY			NOT NULL, 
	MTDSales				MONEY			NOT NULL, 
	YTDSales				MONEY			NOT NULL, 
	UnitsOnHand				INT				NOT NULL, 
	UnitsAllocated			INT				NOT NULL, 
	ReorderPoint			INT				NOT NULL, 
	VendorPrice				MONEY			NOT NULL, 
	MinimumOrder			INT				NOT NULL,  
	Quantity				INT				NOT NULL, 
	ExpectedLeadTime		INT,
	PRIMARY KEY (PartNumber, VendorNumber)
);  

CREATE TABLE Vendor (
	VendorNumber			INT            PRIMARY KEY   IDENTITY, 
	Name					VARCHAR(255)	NOT NULL, 
	Address					VARCHAR(255)	NOT NULL, 
	City					VARCHAR(60)		NOT NULL, 
	State					VARCHAR(2)		NOT NULL, 
	ZipCode					VARCHAR(5)		NOT NULL, 
	Phonenum				VARCHAR(12)		NOT NULL, 
	Credit_limit			MONEY			NOT NULL
);

CREATE TABLE OrderO (
	OrderNumber						INT            PRIMARY KEY   IDENTITY, 
	OrderDate						DATETIME		NOT NULL, 
	CustomerPONumber				INT				NOT NULL, 
	OrderTotal						MONEY			NOT NULL, 
	OrderStatus						VARCHAR(6)		NOT NULL, 
	OrderSpecialCharges				MONEY						DEFAULT 0.00, 
	OrderSpecialChargeDescription	TEXT, 
	ShipName						VARCHAR(255)	NOT NULL, 
	ShipAddress1					VARCHAR(255)	NOT NULL, 
	ShipAdress2						VARCHAR(255)				DEFAULT NULL, 
	ShipCity						VARCHAR(60)	    NOT NULL, 
	ShipState						VARCHAR(2)	    NOT NULL, 
	ShipZip							VARCHAR(5)	    NOT NULL
);

CREATE TABLE OrderDetail (
	OrderNumber						INT				NOT NULL		IDENTITY,
	SEQNumber						INT				NOT NULL,
	PartNumber						INT				NOT NULL, 
	VendorNumber					INT				NOT NULL,  
	NumberOrdered					INT				NOT NULL, 
	QuotedPrice						MONEY			NOT NULL, 
	LineTotal						MONEY			NOT NULL, 
	Comments						TEXT						DEFAULT NULL,
	PRIMARY KEY (OrderNumber, SEQNumber)
);  

CREATE TABLE Invoice (
	InvoiceNumber			INT            PRIMARY KEY   IDENTITY, 
	ShipDate				DATETIME		NOT NULL, 
	Freight					VARCHAR(60)		NOT NULL, 
	ShipStatus				VARCHAR(60)		NOT NULL
);

CREATE TABLE InvoiceDetail (
	InvoiceNumber					INT				NOT NULL		IDENTITY,
	OrderNumber						INT				NOT NULL,
	SEQNumber						INT				NOT NULL,
	QuantityShipped					INT				NOT NULL,
	PRIMARY KEY (InvoiceNumber, OrderNumber, SEQNumber)
);

CREATE TABLE Payment (
	PaymentNumber			INT				NOT NULL		IDENTITY,
	CustomerNumber			INT				NOT NULL,
	PaymentDate				DATETIME		NOT NULL, 
	Amount					MONEY			NOT NULL
);  


--SalesRep Table Foreign Key additions
ALTER TABLE SalesRep
ADD TerritoryNumber	INT	NOT NULL;

ALTER TABLE SalesRep
ADD FOREIGN KEY (TerritoryNumber) 
REFERENCES Territory(TerritoryNumber);

ALTER TABLE SalesRep
ADD FOREIGN KEY	(EmployeeID)
REFERENCES Employee(EmployeeID);

--Customer table Foreign Key additions
ALTER TABLE Customer
ADD EmployeeID	INT		NOT NULL;

ALTER TABLE Customer
ADD FOREIGN KEY (EmployeeID)
REFERENCES SalesRep(EmployeeID);

--Part table foreign key addition
ALTER TABLE Part
ADD FOREIGN KEY (VendorNumber)
REFERENCES Vendor(VendorNumber);

--OrderO table foreign key addition
ALTER TABLE OrderO
ADD CustomerNumber	INT		NOT NULL;

ALTER TABLE OrderO
ADD FOREIGN KEY (CustomerNumber)
REFERENCES Customer(CustomerNumber);

--OrderDetail table foreign key additions
ALTER TABLE OrderDetail
ADD FOREIGN KEY (OrderNumber) REFERENCES OrderO(OrderNumber),
FOREIGN KEY (PartNumber, VendorNumber) REFERENCES Part(PartNumber, VendorNumber)

--InvoiceDetail primary and foreign key additions
ALTER TABLE InvoiceDetail
ADD FOREIGN KEY (InvoiceNumber) REFERENCES Invoice(InvoiceNumber),
FOREIGN KEY (OrderNumber, SEQNumber) REFERENCES OrderDetail(OrderNumber, SEQNumber)

--Payment table foreign key additions
ALTER TABLE Payment
ADD PRIMARY KEY (PaymentNumber);

ALTER TABLE Payment
ADD FOREIGN KEY (CustomerNumber)
REFERENCES Customer(CustomerNumber);


--Insert data into tables

SET IDENTITY_INSERT Customer ON;

INSERT INTO Customer (CustomerNumber, FName, LName, Address1, Address2, City, State, ZipCode, PhoneNum, MTDSales, YTDSales, CurrentBalance, CreditLimit, ShipName, ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZipCode, CurrentInvoiceTotal, CurrentPaymentTotal, CurrentAmount, Over30, Over60, Over90, PreviousBalance, EmployeeID)  VALUES
(1, 'Michael', 'Gordon', '2345 Elm Street', '', 'Burlington', 'VT', '44576', '859-555-1233', '300.00', '900.00', '0.00', '5000.00',  'Michael Gordon', '2345 Elm Street', '', 'Burlington', 'VT', '44576', '250.00', '100.00', '150.00', 1, 2, 3, '400.00', 1),
(2, 'Jon', 'Fishman', '5598 Oak Street', '', 'New York', 'NY', '43321', '776-555-2929', '8000.00', '23500.00', '3000.00', '500,000.00', 'Jon Fishman', '5598 Oak Street', '', 'New York', 'NY', '43321', '2500.00', '1250.00', '1250.00', 1, 2, 3, '850.00', 2);

SET IDENTITY_INSERT Customer OFF;

SET IDENTITY_INSERT SalesRep ON;

INSERT INTO SalesRep (EmployeeID, MTDSales, YTDSales, MTDCommission, YTDCommission, CommissionRate, TerritoryNumber) VALUES
(1, '4500.00', '12450.00', '900.00', '2490.00', '20', 1),
(2, '6000.00', '18000.00', '1200.00', '3600.00', '20', 2);

SET IDENTITY_INSERT SalesRep OFF;

SET IDENTITY_INSERT Territory ON;

INSERT INTO Territory (TerritoryNumber, TerritoryName, Region, Quota) VALUES
(1, 'Aztec', 'Southwest', 5000),
(2, 'Tundra', 'Midwest', 3500);

SET IDENTITY_INSERT Territory OFF;

SET IDENTITY_INSERT Employee ON;

INSERT INTO Employee (EmployeeID, EmpName, EmpAddress1, EmpAdress2, EmpCity, EmpState, EmpZip, EmpPhone) VALUES
(1, 'John Smith', '1234 Johnson Lane', '', 'Milwaukee', 'WI', '53212', '262-555-4432'),
(2, 'Terry Boston', '333 77th Street', '', 'West Allis', 'WI', '54432', '414-995-9955');

SET IDENTITY_INSERT Employee OFF;

SET IDENTITY_INSERT Invoice ON;

INSERT INTO Invoice (InvoiceNumber, ShipDate, Freight, ShipStatus) VALUES 
(1, '2021-11-21 05:22:55', 'UPS', 'Delayed'),
(2, '2022-05-01 09:00:35', 'FedEx', 'On-Time');

SET IDENTITY_INSERT Invoice OFF;

SET IDENTITY_INSERT InvoiceDetail ON;

INSERT INTO InvoiceDetail (InvoiceNumber, OrderNumber, SEQNumber, QuantityShipped) VALUES
(1, 1, 123, 50),
(2, 2, 456, 75);

SET IDENTITY_INSERT InvoiceDetail OFF;

SET IDENTITY_INSERT OrderDetail ON;

INSERT INTO OrderDetail (OrderNumber, SEQNumber, PartNumber, VendorNumber, NumberOrdered, QuotedPrice, LineTotal, Comments) VALUES
(1, 123, 1, 1, 25, '250.00', '250.00', ''),
(2, 456, 2, 2, 45, '600.00', '600.00', '');

SET IDENTITY_INSERT OrderDetail OFF;

SET IDENTITY_INSERT OrderO ON;

INSERT INTO OrderO (OrderNumber, OrderDate, CustomerPONumber, OrderTotal, OrderStatus, OrderSpecialCharges, OrderSpecialChargeDescription, ShipName, ShipAddress1, ShipAdress2, ShipCity, ShipState, ShipZip, CustomerNumber) VALUES
(1, '2021-12-12 09:30:00', 11, '50.00', 'ontime', '0.00', '', 'John Anderson', '2001 76th Street', '', 'Green Bay', 'WI', '54323', 1),
(2, '2022-03-25 11:15:00', 22, '250.00', 'ontime', '0.00', '', 'Terry Johnson', '2345 101st Street', '', 'Madison', 'WI', '56543', 2);

SET IDENTITY_INSERT OrderO OFF;

SET IDENTITY_INSERT Part ON;

INSERT INTO Part (PartNumber, VendorNumber, PartDescription, UnitPrice, MTDSales, YTDSales, UnitsOnHand, UnitsAllocated, ReorderPoint, VendorPrice, MinimumOrder, Quantity, ExpectedLeadTime) VALUES
(1, 1, '', '25.00', '500.00', '2500.00', 750, 225, 100, '15.00', 3, 50, 1),
(2, 2, '', '12.50', '325.00', '1600.00', 500, 125, 55, '6.75', 1, 25, 1);

SET IDENTITY_INSERT Part OFF;

SET IDENTITY_INSERT Vendor ON;

INSERT INTO Vendor (VendorNumber, Name, Address, City, State, ZipCode, Phonenum, Credit_limit) VALUES
(1, 'Derrick Rose', '145 Chicago Ave', 'Chicago', 'IL', '55609', '212-555-9934', '10,000.00'),
(2, 'Luka Doncic', '4533 Dallas Street', 'Dallas', 'TX', '88755', '333-555-9443', '15,000.00');

SET IDENTITY_INSERT Vendor OFF;

SET IDENTITY_INSERT Payment ON;

INSERT INTO Payment (PaymentNumber, CustomerNumber, PaymentDate, Amount) VALUES
(1, 1, '2021-11-21 08:30:00', '4500.00'),
(2, 2, '2022-01-12 12:15:00', '1250.00');

SET IDENTITY_INSERT Payment OFF;