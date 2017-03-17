drop table Employee;
drop table Customer;
drop table Part;
drop table Order1;
drop table OrderPart;

create table Employee(
	ID integer PRIMARY KEY,
	FName varchar(30),
	LName varchar(30),
	Zip integer
);

create table Customer(
	ID integer PRIMARY KEY,
	FName varchar(30),
	LName varchar(30),
	Zip integer
);

create table Part(
	ID integer PRIMARY KEY,
	Name varchar(30),
	Price integer,
	Quantity integer
);

create table Order1(
	ID integer PRIMARY KEY,
	receiptDate date,
	expectedDate date,
	actualDate date
);

create table OrderHandle(
	OrderID integer,
	EmployeeID integer,
	FOREIGN KEY (OrderID) REFERENCES Order1(ID) ON DELETE CASCADE,
	FOREIGN KEY (EmployeeID) REFERENCES Employee(ID) ON DELETE SET NULL
);

create table OrderMake(
	OrderID integer,
	CustomerID integer,
	FOREIGN KEY (OrderID) REFERENCES Order1(ID) ON DELETE CASCADE,
	FOREIGN KEY (CustomerID) REFERENCES Customer(ID) ON DELETE CASCADE
);

create table OrderPart(
	OrderID integer,
	PartID integer,
	Quantity integer,
	FOREIGN KEY (OrderID) REFERENCES Order1(ID) ON DELETE CASCADE,
	FOREIGN KEY (PartID) REFERENCES Part(ID) ON DELETE CASCADE
);

INSERT INTO Employee VALUES (0,'Joe','Smith',42352);
INSERT INTO Employee VALUES (1,'Jimmy','Johns',41022);

INSERT INTO Customer VALUES (2,'Fleece','Johnson',18204);
INSERT INTO Customer VALUES (3,'Leeroy','Jenkins',20042);

INSERT INTO Part VALUES (0,'Bar Soap',5,1);
INSERT INTO Part VALUES (1,'Devout Shoulders',60,1);

INSERT INTO Order1 VALUES (0,'24/FEB/2017','24/FEB/2017','24/FEB/2017');
INSERT INTO Order1 VALUES (1,'24/FEB/2017','24/FEB/2017','24/FEB/2017');

INSERT INTO OrderHandle VALUES (0,1);
INSERT INTO OrderHandle VALUES (1,0);

INSERT INTO OrderMake VALUES (0,2);
INSERT INTO OrderMake VALUES (1,3);

INSERT INTO OrderPart VALUES (0,0,1);
INSERT INTO OrderPart VALUES (1,1,1);