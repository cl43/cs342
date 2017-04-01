--1.
CREATE VIEW employee_view AS
	SELECT E.employee_id, E.first_name, E.last_name, E.email, E.hire_date, D.department_name
	FROM Employees E, Departments D
	WHERE E.department_id = D.department_id;

--1a.
SELECT * FROM(
	SELECT first_name, last_name, employee_id
	FROM employee_view
	WHERE department_name = 'Executive'
	ORDER BY hire_date DESC)
WHERE ROWNUM = 1;

--1b.
UPDATE Departments
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';

--1c.
UPDATE Employees
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel';

--1d.
INSERT INTO employee_view VALUES (1,'Jack','Black','jb@gmail.com','18/MAR/01','Payroll');
--It is not legal to modify more than one table via join view.