
--2.1.a
--i.INSERT INTO Movie VALUES (1, 'Scooby Doo', 1999, 10, 2930);
-- There is a unique constraint error here. It does not like having two movies with id 1.

--ii. INSERT INTO Movie VALUES (NULL, 'Scooby Doo', 1999, 10, 2930);
-- NULL is not permitted to be inserted into the primary key value for ID

--iii. INSERT INTO Movie VALUES (23, 'Scooby Doo', 1000, 10, 2930);
--Check is violated, I used a faulty year for the movie Scooby Doo. It serves as a fact checker to make sure the information is realistic.

--iv. INSERT INTO Movie VALUES ('donald trump', 'pokemon', 1999, 10, 2930);
-- I stuck a string into the movie ID which prompts for an integer. It said Invalid number, prompting for a proper int.

--v. INSERT INTO Movie VALUES (5, 'pokemon', 1999, -5.4, 2930);
-- The command went through. It seems the schema permits negative score reviews.

--2.1.b
--i. INSERT INTO Casting VALUES (NULL,NULL,'costar');
-- The command went through. It seems having the IDs be null does not pose a problem due to simply being unknown.

--ii. INSERT INTO Movie VALUES (1, 'Scooby Doo', 1999, 10, 2930);
-- Integrity constraint violated - parent key not found. I stuck in non existant values into movie id and performer id which is why parent key wasnt found.

--iii. INSERT INTO Movie VALUES (3, 'Scooby Doo', 1999, 10, 2930);
--	   INSERT INTO Casting VALUES (3,1, 'costar');
-- The command passes through. It created another row with the movie Scooby Doo as movie 3. Castings was then able to reference it.

--2.1.c
--i. delete FROM Movie
--	 where title = 'Star Wars';
-- The command passes through and the table for Star Wars is deleted. Attempting to reference Star Wars results in parent key not found.

--ii. delete from Casting
--	  where MovieID = 2
--    and status = 'star';
-- Had no problems being deleted, I figured cause the Casting is like a bridge.

--iii. Update Movie
--     Set id = 10
--     Where title = 'Blade Runner';
--Integrity constraint violated - child record found. Cannot modify or else the child will lose its way.
