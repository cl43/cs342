-- Insert your results into this table.
CREATE TABLE SequelsTemp (
  id INTEGER,
  name varchar2(100),
  PRIMARY KEY (id)
 );
 
CREATE OR REPLACE PROCEDURE getSequels (movieidIn IN Movie.id%type) AS
	CURSOR sequelsOut IS
		select S.Id, S.name
		from Movie M, Movie S
		where M.id = movieIdIn
		and M.sequelId = S.id;
	BEGIN
		FOR sOut IN sequelsOut LOOP	
			INSERT INTO SequelsTemp VALUES (sOut.id, sOut.name);	
			getSequels(sOut.Id);			
		END LOOP;
	END;
/

-- Get the sequels for Ocean's 11, i.e., 4 of them.
BEGIN  getSequels(238071);  END;
/
SELECT * FROM SequelsTemp;

-- Get the sequels for Ocean's Fourteen, i.e., none.
BEGIN  getSequels(238075);  END;
/
SELECT * FROM SequelsTemp;

-- Clean up.
DROP TABLE SequelsTemp;