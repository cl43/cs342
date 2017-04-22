CREATE OR REPLACE TRIGGER maxStock BEFORE INSERT ON OrderItem FOR each ROW
DECLARE
	itemCount INTEGER;
	orderCount INTEGER;
	maxItem EXCEPTION;
BEGIN
	SELECT I.stock INTO itemCount
	FROM orderItem OI, Item I
	WHERE OI.itemId = I.id;
	
	SELECT OI.quantity INTO orderCount
	FROM orderItem OI, Item I
	WHERE OI.itemId = I.id;
	
	IF 5 > itemCount THEN
		raise maxItem;
	END IF;
	EXCEPTION
		WHEN maxItem THEN
			RAISE_APPLICATION_ERROR(-20001, 'Order amount exceeds current stockhold for that item');
END;
	/
show errors;
--This trigger is to make sure that customers do not order something larger than what the company has available.

INSERT INTO OrderItem VALUES (0,1,1);
--Order quantity does not exceed stock.

INSERT INTO OrderItem VALUES (0,1,100);
--Order quantity exceeds stock.

CREATE OR REPLACE TRIGGER improperCondition BEFORE INSERT ON Order1 FOR each ROW
DECLARE
	status VARCHAR(30);
	outOfOrder EXCEPTION;
BEGIN
	SELECT V.condition INTO status
	FROM Vehicle V, order1 O
	WHERE V.id = O.vehicleId;
	IF status <> 'Working' THEN
		raise outOfOrder;
	END IF;
	EXCEPTION
		WHEN outOfOrder THEN
			RAISE_APPLICATION_ERROR(-20001, 'Vehicle is not in working condition!');
	END;
	/
show errors;
--This trigger is to make sure an order does not assign a broken vehicle to the job.

INSERT INTO Order1 VALUES (9,'14/MAR/17',NULL,'15/MAR/17','Incomplete',8,3,0,0);
--Assigning a order to a vehicle that works

INSERT INTO Order1 VALUES (10,'14/MAR/17',NULL,'15/MAR/17','Incomplete',8,3,0,2);
--Assigning an order to a vehicle that doesnt work.