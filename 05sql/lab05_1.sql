--5.1.a
SELECT * FROM HouseHold, Person;

select COUNT(*) FROM Household, Person; --128 rows

--5.1.b
SELECT firstNAME, lastNAME, TO_CHAR(birthdate, 'DDD') as bDate
FROM Person
WHERE birthdate IS NOT NULL
ORDER BY bDate;