--2.
CREATE MATERIALIZED VIEW mat_employee_view AS
	SELECT E.employee_id, E.first_name, E.last_name, E.email, E.hire_date, D.department_name
	FROM Employees E, Departments D
	WHERE E.department_id = D.department_id;

--2a.
SELECT * FROM(
	SELECT first_name, last_name, employee_id
	FROM mat_employee_view
	WHERE department_name = 'Executive'
	ORDER BY hire_date DESC)
WHERE ROWNUM = 1;

--2b.
UPDATE Departments
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';

--2c.
UPDATE Employees
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel';

--2d.
INSERT INTO employee_view VALUES (1,'Jack','Black','jb@gmail.com','18/MAR/01','Payroll');

--2b-d return "data manipulation operation not legal on this view". It cannot be updated because it is a materialized view and is simply a read-only view.