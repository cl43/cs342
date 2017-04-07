CREATE TABLE RankLog (
  userID integer,
  dateChange date,
  originalRank integer,
  modifiedRank integer
 );
 
CREATE OR REPLACE TRIGGER shadowLog AFTER UPDATE OF rank ON Movie FOR EACH ROW
	BEGIN
		IF :new.rank <> :old.rank THEN
			INSERT INTO RankLog VALUES(user,sysdate,:old.rank,:new.rank);
		END IF;
	END;
/
show errors;

UPDATE Movie
SET rank = 5
WHERE name = 'Aliens';

SELECT * FROM RankLog;