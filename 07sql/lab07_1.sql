CREATE VIEW birthday_czar AS
	SELECT firstName, lastName, TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) AS age, birthdate
	FROM Person;
	
--7.1.a
SELECT firstName, lastName, birthdate
FROM birthday_czar
WHERE birthdate >= TO_DATE ('01-JAN-1961') AND birthdate <= TO_DATE ('30-DEC-1975');

--7.1.b
UPDATE birthday_czar
