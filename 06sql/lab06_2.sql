--6.2a
SELECT TRUNC(AVG(MONTHS_BETWEEN(SYSDATE,birthdate)/12))
FROM Person;

--The agregate function is the MONTHS_Between function and it performs by grouping the birthdates of the people before computing with it.

--6.2b
SELECT H.ID, COUNT(*)
FROM Household H JOIN Person P ON H.ID = P.householdID
WHERE H.city = 'Grand Rapids'
GROUP BY H.ID
HAVING COUNT(*) > 1
ORDER BY COUNT(*) desc;

--6.2c
SELECT H.ID, H.phoneNumber, COUNT(*)
FROM Household H JOIN Person P ON H.ID = P.householdID
WHERE H.city = 'Grand Rapids'
GROUP BY H.ID, H.phoneNumber
HAVING COUNT(*) > 1
ORDER BY COUNT(*) desc;