CREATE OR REPLACE PROCEDURE rankTransfer(fromMovieIdIN IN Movie.id%type, toMovieIdIN IN Movie.id%type, rankAmountIN IN Movie.rank%type) AS
	fromRank INTEGER;
	toRank INTEGER;
	belowZero EXCEPTION;
	nullRank EXCEPTION;
BEGIN
	SELECT rank INTO fromRank FROM Movie WHERE id = fromMovieIdIN;
	SELECT rank INTO toRank FROM Movie WHERE id = toMovieIdIN;
	
	IF fromRank IS NULL OR toRank IS NULL THEN
		RAISE nullRank;
	END IF;
	
	IF fromRank < 0 OR toRank < 0 THEN
		RAISE belowZero;
	END IF;
	
	UPDATE Movie SET rank = fromRank - rankAmountIN WHERE id = fromMovieIdIN;
	UPDATE Movie SET rank = toRank + rankAmountIN WHERE id = toMovieIdIN;
	commit;
	
EXCEPTION
	WHEN belowZero THEN
		RAISE_APPLICATION_ERROR(-20001, 'Movie rank is below zero!');
	WHEN nullRank THEN
		RAISE_APPLICATION_ERROR(-20001, 'Movie rank is null!');
END;
/
show errors;

BEGIN
	rankTransfer(176712, 176711, 1.0);
END;
/

SELECT rank FROM Movie WHERE id = 176712;
SELECT rank FROM Movie WHERE id = 176711;