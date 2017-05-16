CREATE OR REPLACE PROCEDURE itemStock(itemIdIN IN Item.id%type, changeAmountIN IN Item.stock%type) AS
	currentStock INTEGER;
	BEGIN
		SELECT stock INTO currentStock FROM Item WHERE id = itemIdIN FOR UPDATE;
		IF currentStock + changeAmountIN < 0 THEN
			RAISE_APPLICATION_ERROR(-20000, 'Cannot have negative amounts of an item');
			ROLLBACk;
		END IF;
		UPDATE Item
		SET stock = currentStock + changeAmountIN
		WHERE id = itemIdIN;
		COMMIT;
	END;
	/
	show errors;
	
	--This procedure allows the db user to update the stockpile of vegetables whether the amount decreased
	--because of delivery or the amount increased because of resupplying. It does not account for new or
	--removed items due to those situations being much more rare and I believe those situations would be
	--better suited in an anonymous block.
	
	
	BEGIN
	itemStock(0,10);
	END;
	/
	 --Add 10 to the stock of beansprout
	
	SELECT * FROM Item WHERE id = 0;
	 --Check beansprout. Old:20, New:30
	
	BEGIN
	itemStock(1,-10);
	END;
	/
	 --Subtract 10 to the stock of Broccoli
	 
	SELECT * FROM Item WHERE id = 1;
	 --Check brocolli. Old:10, New:0
	
	BEGIN
	itemStock(2,-10);
	END;
	/
	 --Subtract 10 to the stock of eggplant. This should not work as the count will be -5
