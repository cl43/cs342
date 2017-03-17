-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden
drop table HouseHold;
drop table Homegroup;
drop table Person;
drop table Team;
drop table PersonTeam;


create table HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

create table Homegroup(
	ID integer PRIMARY KEY,
	Name varchar(30),
	Topic varchar(500)
);

create table Person (
	ID integer PRIMARY KEY,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	role varchar(30) CHECK(role in ('Parent', 'Child')),
	houseID integer, 
	mentorID integer, 
	homeGroupID integer, 
	FOREIGN KEY (houseID) REFERENCES HouseHold(ID) ON DELETE CASCADE,
	FOREIGN KEY (mentorID) REFERENCES Person(ID) ON DELETE SET NULL,
	FOREIGN KEY (homeGroupID) REFERENCES Homegroup(ID) ON DELETE CASCADE
	);
	
create table Request(
	requestID integer,
	respondID integer,
	requestDate date PRIMARY KEY,
	text varchar(500),
	accessCode varchar(1),
	response varchar(500),
	FOREIGN KEY (requestID) REFERENCES HouseHold(ID) ON DELETE CASCADE,
	FOREIGN KEY (respondID) REFERENCES Person(ID) ON DELETE SET NULL
);
	
create table Team(
	ID integer PRIMARY KEY,
	Name varchar(30),
	mandate varchar(30)
);

create table PersonTeam(
	personID integer ,
	teamID integer,
	startDate date,
	endDate date,
	Role varchar(500),
	FOREIGN KEY (personID) REFERENCES Person(ID) ON DELETE SET NULL,
	FOREIGN KEY (teamID) REFERENCES Team(ID) ON DELETE CASCADE
);

INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');
INSERT INTO Household VALUES (1,'123 Fake St. SE','Fantasyville','DC','10101','123-456-7890');

INSERT INTO Homegroup VALUES (1,'Archaeology', 'Look for rocks, ancient relics, and other old stuff.');

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m', 'Parent',0,null,1);
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m', 'Parent',0,null,null);
INSERT INTO Person VALUES (2,'mr.','Bart','Simpson','a','Child',1,0,1);

INSERT INTO Request VALUES (1,0, '24/FEB/2017','Find me a world-destroying artifact please.','a','Sure.');

INSERT INTO Team VALUES (1,'Excavation Team', 'Lets do some digging!');

INSERT INTO PersonTeam VALUES (2,1, '10/Jan/2017','10/Jan/2018', 'Finds the magical, world-breaking, relics.');