
create table Employee(
	ID integer PRIMARY KEY,
	FName varchar(30),
	LName varchar(30),
	position varchar(30) NOT NULL,
	paycheck Double,
	CHECK (paycheck < 8.90)
);

create table Loans(
	ID integer PRIMARY KEY,
	amount integer,
	createDate date NOT NULL,
	dueDate date NOT NULL,
	paid varchar(1) NOT NULL,
	employeeID integer,
	FOREIGN KEY (employeeID) REFERENCES Employee(ID),
	CHECK (amount < 0)
);

create table Customer(
	ID integer PRIMARY KEY,
	name varchar(30),
	address varchar(30) NOT NULL,
	city varchar(30) NOT NULL,
	zip integer NOT NULL
);

create table Vehicle(
	ID integer PRIMARY KEY,
	model varchar(30),
	condition varchar(30)
);

create table Order1(
	ID integer PRIMARY KEY,
	orderDate date NOT NULL,
	deliverDate date NOT NULL,
	dueDate date NOT NULL,
	status varchar(10),
	price integer,
	employeeID integer,
	customerID integer,
	vehicleID integer,
	FOREIGN KEY (employeeID) REFERENCES Employee(ID) ON DELETE SET NULL,
	FOREIGN KEY (customerID) REFERENCES Customer(ID) ON DELETE CASCADE,
	FOREIGN KEY (vehicleID) REFERENCES Vehicle(ID) ON DELETE SET NULL,
	CHECK (price < 0),
	CHECK (status in ('Complete', 'Incomplete'))
);

CREATE SEQUENCE Order1_sequence
start with 1
increment by 1
NOCACHE;

create table Item(
	ID integer PRIMARY KEY,
	name varchar(30),
	price integer,
	stock integer,
	CHECK (price < 0),
	CHECK (stock < 0)
);

create table OrderItem(
	orderID integer,
	itemID integer,
	quantity integer,
	FOREIGN KEY (OrderID) REFERENCES Order1(ID) ON DELETE CASCADE,
	FOREIGN KEY (ItemID) REFERENCES Item(ID) ON DELETE CASCADE,
	CHECK (quantity < 0)
);
