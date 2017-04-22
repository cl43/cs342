CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn FOR UPDATE;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/

UPDATE Movie SET rank = 8.2 WHERE id = 10920; --reset the rank

EXECUTE incrementRank(10920, 1);

SELECT rank from movie where id = 10920; --See result

--So when I ran this procedure simultaneously, I desired to add 1 rank to the movie Aliens which sat at 8.2 rank before the updates.
--However, the simultaneous update increased the rank to 50008.2. I believe there is redundancy that happens when it comes to this update.
--Session one gets the initial rank and modifies it, but session two then grabs session one's new rank and modifies if not overwrites session one's work.
--This makes it so we only get one execution's worth of work, hence rank only increased by 50000 once.
--FOR UPDATE at the end of the select statement in the for loop seems to fix the issue because it locks the records into a cursor result set.
--Our new rank is 100008.2 which should be the sum of both 50000 increments.