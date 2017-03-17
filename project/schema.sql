
create table Employee(
	ID integer PRIMARY KEY,
	FName varchar(30),
	LName varchar(30),
	position varchar(30),
	paycheck Integer
);

create Loans(
	ID integer PRIMARY KEY,
	amount integer,
	createDate date,
	dueDate date,
	paid boolean,
	employeeID integer,
	FOREIGN KEY (employeeID) REFERENCES Employee(ID)
);

create Customer(
	ID integer PRIMARY KEY,
	name varchar(30),
	address varchar(30) NOT NULL,
	city varchar(30) NOT NULL,
	zip integer NOT NULL
);

create Vehicle(
	ID integer PRIMARY KEY,
	model varchar(30),
	condition varchar(30)
);

create Order1(
	ID integer PRIMARY KEY,
	orderDate date,
	deliverDate date,
	price integer,
	employeeID integer,
	customerID integer,
	vehicleID integer,
	FOREIGN KEY (employeeID) REFERENCES Employee(ID) ON DELETE SET NULL,
	FOREIGN KEY (customerID) REFERENCES Customer(ID) ON DELETE CASCADE,
	FOREIGN KEY (vehicleID) REFERENCES Vehicle(ID) ON DELETE SET NULL
);

CREATE SEQUENCE Order1_sequence
start with 0
increment by 1
NOCACHE;

create Item(
	ID integer PRIMARY KEY,
	name varchar(30),
	price integer,
	stock integer
);

create OrderItem(
	orderID integer,
	itemID integer,
	quantity integer,
	FOREIGN KEY (OrderID) REFERENCES Order1(ID) ON DELETE CASCADE,
	FOREIGN KEY (ItemID) REFERENCES Item(ID) ON DELETE SET CASCADE
);
