--9.1a
DECLARE
	dummy integer;
BEGIN
	FOR i IN 1..1000 LOOP
		SELECT COUNT(1) INTO dummy
		FROM Movie;
	END LOOP;
END;
/
--Time Elapsed: 00:00:05.47

DECLARE
	dummy integer;
BEGIN
	FOR i IN 1..1000 LOOP
		SELECT COUNT(*) INTO dummy
		FROM Movie;
	END LOOP;
END;
/
--Time Elapsed: 00:00:05.40

DECLARE
	dummy integer;
BEGIN
	FOR i IN 1..1000 LOOP
		SELECT SUM(1) INTO dummy
		FROM Movie;
	END LOOP;
END;
/
--Time Elapsed: 00:00:11.18
-- It seems the time difference of SUM is doubled compared to COUNT

--9.1.b
DECLARE
	dummy integer;
BEGIN
	FOR i IN 1..100 LOOP --Set loop to stop at 100 because 1000 was taking forever.
		SELECT COUNT(*) INTO dummy
		FROM Movie, Role, Actor
		WHERE Movie.id = Role.movieId
		AND Role.movieId = Actor.id
		AND Movie.id = 10920;
	END LOOP;
END;
/
--Time Elapsed: 00:00:06.16

DECLARE
	dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(*) INTO dummy
		FROM Role, Movie, Actor
		WHERE Movie.id = Role.movieId
		AND Role.movieId = Actor.id
		AND Movie.id = 10920;
	END LOOP;
END;
/
--Time Elapsed: 00:00:06.13
--The time elapsed seems to be the same regardless of how FROM tables is listed.

--9.1.c
DECLARE
	dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(*) INTO dummy
		FROM Role JOIN Movie ON Role.movieId = Movie.id;
	END LOOP;
END;
/
--Time Elapsed: 00:00:06.29

DECLARE
	dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(*) INTO dummy
		FROM Role JOIN Movie ON Role.movieId+0 = Movie.id+0;
	END LOOP;
END;
/
--Time Elapsed: 00:01:33.68
--Adding a arithmetic function, even one that has no effect such as +0 adds a significant more amount of time.

--9.1.d

SELECT COUNT(*)
FROM Movie;
--Time Elapsed: 00:00:00.01

DECLARE
	dummy integer;
BEGIN
	FOR i IN 1..2 LOOP --more than once = 2?
		SELECT COUNT(*) INTO dummy
		FROM Movie;
	END LOOP;
END;
/
--Time Elapsed: 00:00:00.01
--There is no difference to running a query multiple times, though I probably should have used a more complicated one.

--9.1.e

DECLARE
	dummy integer;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(*) INTO dummy
		FROM Movie M JOIN Movie S ON M.id = S.id;
	END LOOP;
END;
/

CREATE INDEX myIndex ON Movie(id, name);

--Time Elapsed: 00:00:00.56 Before Index
--Time Elapsed: 00:00:00.56 After Index
--There seems to be no difference with the addition of the index.
