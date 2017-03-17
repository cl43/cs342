-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;

--4.2.a. PersonVisit is in BCNF form due to having no nontrivial FDs. personName -> personVisit.
-- It is not a 4NF however, due to there not being enough multivalued dependent.
--PersonTeam on the otherhand is not in BCNF or 4NF due to not having a superkey.

--4.2.b. This value is in BCNF due to the nontrivial FDS. Name-> team, visit
-- It is also in 4NF form due to having multivalued dependency with Name being superkey.

--4.2.c. 
--The combined view has a multivalue dependency opposed to the previous form which doesn't. The combined values of personVisit and teamName, which are completely unrelated,
--results in a lot of redundant information say if you were to make a table with the insert values above. Furthermore, if a new row was made where visit or teamname was changed,
--then more redundant information would be created in the columns as well.

--4.2d.
drop table PersonTeamVisit;

CREATE TABLE PersonTeamVisit(
	personName varchar(10),
	teamName varchar (10),
	personVisit date
);

INSERT INTO PersonTeamVisit
SELECT P.personName, P.teamName, V.personVisit
FROM PersonTeam P, PersonVisit V
WHERE P.personName = V.personName;

SELECT * FROM PersonTeamVisit;