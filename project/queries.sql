SELECT O.ID, O.dueDate, E.FName, E.LName, C.name, V.model
FROM Order1 O JOIN Employee E ON O.employeeID = E.ID
JOIN Customer C ON O.customerID = C.ID
JOIN Vehicle V ON O.vehicleID = V.ID
WHERE O.dueDate <= SYSDATE AND O.status <> 'Complete' AND deliverDate IS NULL;

--The query returns the Employee and vehicle that is in charge of any overdue and incomplete orders along with the customer.
--This query is intended for employees that are in charge of delivering orders that are due today.

SELECT L.ID, L.amount, E.FName, E.LName, E.paycheck
FROM Loans L, Employee E
WHERE L.paid = 'N' AND L.employeeID = E.ID AND L.dueDate < SYSDATE;

--The query returns the ID, amount of any unpaid loans that are due today or overdue and the name and paycheck of the employee that owes said loan.
--This query is designed for the boss of the company, who is the one lending the loans.

SELECT * FROM(
SELECT * FROM Vehicle
WHERE condition = 'Working');

--The nested query is to show how many vehicles the company has that is currently usable.
--The query is designed for the boss and delivery team to know which vehicle to assign orders to and who drives it.
--This will allow the team to know how many trucks to send out per day and how to evenly distribute delivery load.

SELECT A.ID, A.FName, A.LName, A.paycheck, B.ID, B.FName, B.LName, B.paycheck
FROM Employee A, Employee B
WHERE A.paycheck < B.paycheck;

--The query is a self-join query that compares employee paycheck.
--It may be useful to whoever is in charge of payroll.

SELECT O1.ID, O1.dueDate, O2.ID, O2.dueDate
FROM Order1 O1, Order1 O2
WHERE O1.status = 'Incomplete'
AND O2.status = 'Incomplete'
ORDER BY dueDate ASC;

--The query is a self-join query that compares the due dates of incomplete orders.
--This is for a bad scenario where we have many overdue orders. Assuming the angry customer does not cancel
--and still wants the items, we will use this query to find the overdue orders and complete oldest to newest.


SELECT Order1.ID,Item.name, OrderItem.Quantity,Customer.Name
FROM Order1 JOIN OrderItem ON OrderItem.orderID = Order1.ID
LEFT OUTER JOIN Item ON Item.ID = OrderItem.itemID
RIGHT OUTER JOIN Customer ON Order1.customerID = Customer.ID;

--The query is to show the list of orders, their contents, and to who the order goes to.
--This query would be useful for the book keepers of the company to keep track of purchases.

SELECT E.id, SUM(L.amount)
FROM Employee E, Loans L
WHERE L.employeeID = E.ID
AND L.paid = 'N'
GROUP BY E.id;

--The aggregate function query is to determine the sum of all the loans that the employees owe.
--It is most likely going to be used by the boss and whoever is in charge of payroll.

CREATE VIEW loan_paycheck AS
	SELECT L.ID, L.amount, L.createDate, L.dueDate, L.paid, E.FName, E.LName, E.paycheck
	FROM Loans L, Employee E;
	
--The view is to look at loans, their creation and due dates, whether they are paid of not, and which employee owed money and his paycheck.
--The boss would use this to keep track of the loans and how much money to deduct for the borrowing employee's pay.
--A regular view is used since this view's purpose is to handle the record of loans. The paid column is updatable which is why a materialized view isn't used.