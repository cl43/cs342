--6.1a
SELECT T.name, T.mandate, PT.personID
FROM Team T LEFT OUTER JOIN PersonTeam PT ON T.name = PT.teamName
AND PT.role = 'chair'; 