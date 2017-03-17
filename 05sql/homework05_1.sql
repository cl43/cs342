--a
SELECT DISTINCT E.first_name, E.last_name
FROM Employees E JOIN Job_History JH ON E.Employee_ID = JH.Employee_ID
AND JH.end_date IS NOT NULL;

--b
SELECT E.employee_ID, E.first_name, E.last_name, E.hire_date, E.manager_ID, M.employee_ID, M.first_name, M.last_name, M.hire_date
FROM Employees E JOIN Employees M ON E.manager_ID = M.employee_ID
WHERE E.hire_date < M.hire_date
AND EXISTS( SELECT *
			FROM Job_History JH
			WHERE E.employee_ID = JH.employee_ID
			AND JH.department_ID = M.department_ID);
			
--c
--join
SELECT DISTINCT Country_name
FROM Countries C JOIN Locations L ON C.country_ID = L.country_ID JOIN Departments D ON D.Location_ID = L.Location_ID;

--nested query
SELECT DISTINCT C.country_name
FROM Countries C
WHERE C.country_ID IN(SELECT L.country_ID
					  FROM Locations L
					  WHERE L.location_ID IN(SELECT D.location_ID
											 FROM Departments D));