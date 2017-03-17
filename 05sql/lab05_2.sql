--5.2.a
SELECT * FROM (
SELECT * FROM person 
WHERE birthdate IS NOT NULL
ORDER BY birthdate DESC)
WHERE ROWNUM = 1;

--5.2.b
SELECT A.ID, A.firstName, A.lastName
FROM Person A
WHERE A.firstName IN (
SELECT A.firstName
FROM Person B
WHERE A.firstName = B.firstName AND A.ID <> B.ID);

--5.2.c
SELECT P.firstName, A.lastName
FROM Person P
WHERE EXISTS (SELECT *
FROM PersonTeam PT
WHERE P.ID = PT.personID
AND PT.teamName = 'Music')
MINUS
SELECT P.firstName, P.lastName
FROM PERSON P
WHERE EXISTS (SELECT *
FROM Homegroup H
WHERE H.ID = P.homeGroupID
AND H.name = 'Byl');