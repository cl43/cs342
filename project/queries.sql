SELECT O.ID, C.name, C.address, C.city, C.zip, I.name, OI.quantity, O.price
FROM Order1 O, Customer C, OrderItem OI, Item I
WHERE O.deliverDate = SYSDATE; <-- strange error

--The query returns ...
--This query is intended for employees that are in charge of delivering orders that are due today.

SELECT L.ID, L.amount, E.FName, E.LName, E.paycheck
FROM Loans L, Employee E
WHERE L.paid = 'N' AND L.employeeID = E.ID AND L.dueDate < SYSDATE;

--The query returns the ID, amount of any unpaid loans that are due today or overdue and the name and paycheck of the employee that owes said loan.
--This query is designed for the boss of the company, who is the one lending the loans.

SELECT COUNT(ID)
FROM Vehicle
WHERE condition = 'Working';

--The query is to show how many vehicles the company has that is currently usable.
--The query is designed for the boss and delivery team to know which vehicle to assign orders to and who drives it.

