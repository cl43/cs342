--5.3a
SELECT DISTINCT A.lastName || ', ' || A.firstName || ' and ' || B.firstName ||' - ' || H.phoneNumber ||  ' - ' || H.street
FROM Person A JOIN Person B ON A.householdID = B.householdID
JOIN Household H ON H.ID = A.householdID AND A.householdID = B.householdID
WHERE A.householdRole = 'husband' AND B.householdRole = 'wife';

--5.3b
SELECT DISTINCT A.lastName || ', ' || A.firstName || ' and ' || B.firstName || ' ' || B.lastName ||' - ' || H.phoneNumber ||  ' - ' || H.street
FROM Person A JOIN Person B ON A.householdID = B.householdID
JOIN Household H ON H.ID = A.householdID AND A.householdID = B.householdID
WHERE A.householdRole = 'husband' AND B.householdRole = 'wife';

--5.3c
SELECT DISTINCT A.lastName || ', ' || A.firstName || ' and ' || B.firstName || ' ' || B.lastName ||' - ' || H.phoneNumber ||  ' - ' || H.street
FROM Person A JOIN Person B ON A.householdID = B.householdID
JOIN Household H ON H.ID = A.householdID AND A.householdID = B.householdID
WHERE A.householdRole = 'husband' AND B.householdRole = 'wife'
UNION
SELECT C.lastName || ',' || C.firstName || ' - ' || H.phoneNumber || ' - ' || H.street
FROM Person C JOIN Household H ON C.householdID = H.ID
WHERE C.householdRole = 'single';