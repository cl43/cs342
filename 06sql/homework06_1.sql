--6.1.a
SELECT * 
FROM (SELECT M.employee_ID, M.first_Name, M.last_Name, COUNT(*)
	  FROM Employees M, Employees E
	  WHERE E.manager_ID = M.employee_ID
	  GROUP BY M.employee_ID, M.first_Name, M.last_Name
	  ORDER BY COUNT(*) DESC)
	  WHERE ROWNUM <= 10;
	  
--6.1.b
SELECT D.department_Name, COUNT(*), SUM(E.salary)
FROM Departments D, Employees E, Locations L, Countries C
WHERE E.department_ID = D.department_ID
AND D.location_ID = L.location_ID
AND L.country_ID = C.country_ID
AND C.country_Name <> 'US'
GROUP BY D.department_Name
HAVING COUNT(*) < 100;

--6.1.c
SELECT D.department_Name, M.first_Name, M.last_Name, J.job_Title
FROM Departments D, Employees M, Jobs J
WHERE D.manager_ID = M.employee_ID
AND M.job_ID = J.job_ID;

--6.1.d
SELECT D.department_Name, AVG(E.salary)
FROM Departments D, Employees E
WHERE D.department_ID = E.department_ID
GROUP BY D.department_Name
ORDER BY AVG(E.salary) DESC;