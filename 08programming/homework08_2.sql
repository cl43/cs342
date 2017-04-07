CREATE TABLE BaconTable (
	id integer,
	baconNumber integer
);

CREATE OR REPLACE PROCEDURE BaconNo(idIN IN BaconTable.id%type, baconNumberIn IN BaconTable.baconNumber%type) IS counter INTEGER;
	BEGIN
		FOR coActor IN (SELECT DISTINCT actorID
						FROM Role
						WHERE movieID IN(SELECT movieID
										 FROM Role
										 WHERE idIN = actorID)) LOOP
			IF baconNumberIn < 5 THEN
				INSERT INTO BaconTable VALUES (coActor.actorID, baconNumberIn+1);
				BaconNo(coActor.actorID, baconNumberIn+1);		
			END IF;
		END LOOP;
	END;
/

BEGIN 
baconNo(22591, 0); --Kevin Bacon
END;
/

SELECT * FROM BaconTable;