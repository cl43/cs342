-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team names are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden

drop table AltPerson;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);

INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');

--4.1.a. The schema has all of its attributes clumped up into one table and as no foreign keys to reference other attributes. This results in many duplicate tables to be made. Take for example
-- Shamkant, he is part of two teams and in order for the schema to recognize that, a duplicate has to be made which wastes data space and is very redundant.
--We already know Shamkant's membership, mentorship, etc.
--Functional dependencies:
--personId -> name, status, mentorID, mentorName, mentorStatus
--mentorID -> mentorName, mentorStatus
--teamName -> teamTime
--teamName, personID -> teamRole

--4.1.b. Create a separate table for team and another table to join team and person together.
-- Person(ID, name, status, mentorID, mentorID, mentorStatus)
-- Team(ID, Name, Time)
-- PersonTeam(personID, teamID, Role)

--4.1.c
drop table Person;
drop table Team;
drop table PersonTeam;

CREATE TABLE Person(
	personID integer PRIMARY KEY,
	name varchar (10),
	status char(1),
	mentorID integer,
	FOREIGN KEY (mentorID) REFERENCES Person(personID) ON DELETE SET NULL
);

CREATE TABLE Team(
	teamName varchar(10) PRIMARY KEY,
	teamTime varchar (10)
);

CREATE TABLE PersonTeam(
	personID integer,
	teamName varchar(10),
	teamRole varchar(10),
	FOREIGN KEY (personID) REFERENCES Person(personID) ON DELETE CASCADE,
	FOREIGN KEY (teamName) REFERENCES Team(teamName) ON DELETE CASCADE
);

INSERT INTO Person SELECT DISTINCT PersonID, name, status, mentorID FROM AltPerson;
INSERT INTO Team SELECT DISTINCT teamName, teamTime FROM AltPerson;
INSERT INTO PersonTeam SELECT DISTINCT personID, teamName, teamRole FROM AltPerson;

SELECT * FROM Person;
SELECT * FROM Team;
SELECT * FROM PersonTeam;