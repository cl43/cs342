DROP TABLE Shipment; --1. Exercise 5.14
DROP TABLE Order_Item;
DROP TABLE Order1;
DROP TABLE Customer;
DROP TABLE Item;
DROP TABLE Warehouse;

CREATE TABLE Customer (
	ID integer,
	cName varchar(35),
	city varchar(35),
	PRIMARY KEY (ID),
	CHECK (city IS NOT NULL) --If the address is unknown then how will the delivery be made?
	);
	
CREATE TABLE Order1 ( --table is named Order1 to avoid confusion with commands.
	ID integer,
	orderDate date,
	custId integer,
	orderPrice integer,
	FOREIGN KEY (custID) REFERENCES Customer(ID) ON DELETE CASCADE, --Need to know who to deliver to, otherwise order is pointless.
	PRIMARY KEY (ID)
	);
	
CREATE TABLE Item (
	ID integer,
	iName varchar(35),
	itemPrice integer,
	PRIMARY KEY (ID)
	);
	
CREATE TABLE Warehouse (
	ID integer,
	city varchar(35),
	PRIMARY KEY (ID)
	);
	
CREATE TABLE Order_Item (
	orderID integer,
	itemID integer,
	quantity integer,
	FOREIGN KEY (orderID) REFERENCES Order1(ID) ON DELETE CASCADE, -- Need to know which order the item is assigned to.
	FOREIGN KEY (itemID) REFERENCES Item(ID) ON DELETE CASCADE, --Need to know what is being bought, otherwise cannot deliver the item.
	CHECK (quantity > 0) --If nothing is bought, then there is no need for an order.
	);
		
CREATE TABLE Shipment (
	orderID integer,
	warehouseID integer,
	shipDate date,
	FOREIGN KEY (orderID) REFERENCES Order1(ID) ON DELETE CASCADE, --Need to know what we are delivering, otherwise order cannot be done.
	FOREIGN KEY (warehouseID) REFERENCES Warehouse(ID) ON DELETE SET NULL --From where the order came from shouldn't be important enough to screw up the order.
	);
	

	
INSERT INTO Customer VALUES (1,'Chris Li','Grand Rapids');
INSERT INTO Customer VALUES (2,'Donald Trump','Washington DC');
INSERT INTO Customer VALUES (3,'Fleece Johnson','Kentucky State Penitentiary');
INSERT INTO Customer VALUES (4,'John Cena','WWE Superslam');

INSERT INTO Order1 VALUES (1,'12-JAN-12',1, 25);
INSERT INTO Order1 VALUES (2,'1-MAY-17',2, 1000000);
INSERT INTO Order1 VALUES (3,'8-MAR-15',3, 80017);
INSERT INTO Order1 VALUES (4,'12-FEB-16',1, 10);

INSERT INTO Order_Item VALUES (1,1,1);
INSERT INTO Order_Item VALUES (2,2,1);
INSERT INTO Order_Item VALUES (3,3,10);
INSERT INTO Order_Item VALUES (4,4,1);

INSERT INTO Item VALUES (1,'Textbook',25);
INSERT INTO Item VALUES (2,'Loan From Father',1000000);
INSERT INTO Item VALUES (3,'Textbook',80017);
INSERT INTO Item VALUES (4,'Calvin College Tuition',10);

INSERT INTO Shipment VALUES (1,1,'12-JAN-16');
INSERT INTO Shipment VALUES (2,2,'1-MAY-17');
INSERT INTO Shipment VALUES (3,3,'8-MAR-15');
INSERT INTO Shipment VALUES (4,4,'1-FEB-17');

INSERT INTO Warehouse VALUES (1,'Wyoming');
INSERT INTO Warehouse VALUES (2,'Trumpville');
INSERT INTO Warehouse VALUES (3,'Eddyville');
INSERT INTO Warehouse VALUES (4,'Grand Rapids');

SELECT orderDate, orderPrice --3.a
FROM Order1, Customer
WHERE Order1.custID = Customer.ID
AND Customer.cName = 'Chris Li'
ORDER BY orderDate asc;

SELECT DISTINCT Customer.ID --3.b
FROM Customer, Order1
WHERE Customer.ID = Order1.custID;

SELECT Customer.ID, cName --3.c
FROM Customer, Order1, Order_Item, Item
WHERE Customer.ID = Order1.custID 
AND Order1.ID = Order_Item.orderID
AND Order_Item.itemID = item.ID
AND item.iName = 'Textbook';

--2. Exercise 5.20. I believe Surrogate keys would still be acceptable to use. One of the biggest cons of a natural key is that if there are changes within the data, then it can cause much trouble with the foreign keys.
-- Surrogate keys on the other hand do not deal with that and are easily modified, which is useful for managing a database for Calvin Students; especially, when the data tables for a student is very susceptible to change such as majors.
