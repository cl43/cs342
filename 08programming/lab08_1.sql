--Creating procedure to allow actors to be added into movies
CREATE PROCEDURE addRole(actorIDIn IN Actor.ID%type, movieIDIn IN Movie.id%type, roleIn IN Role.role%type) AS
BEGIN
	INSERT INTO Role(actorId, movieId, role) VALUES(actorIDIn, movieIDIn, roleIn);
END;

--Creating the Exclusive Actor trigger and limiting 230 movies.
CREATE TRIGGER MovieLawEnforcement BEFORE INSERT ON Role FOR EACH ROW --Initializing
DECLARE --My variables
	actorRoleCounter INTEGER;
	twoRoles EXCEPTION;
	movieCastCounter INTEGER;
	over230 EXCEPTION;
BEGIN
	SELECT COUNT(*) INTO actorRoleCounter FROM Role --Determines if actor is already in the movie
		WHERE actorId = :new.actorId AND movieID = :new.movieId;
		IF actorRoleCounter > 1 THEN
			RAISE twoRoles;
		END IF;
	
	SELECT COUNT(*) INTO movieCastCounter FROM Role --Determines if movie has too much castings
		WHERE movieId = :new.movieId;
		IF movieCastCounter > 230 THEN
			RAISE over230;
		END IF;
		
EXCEPTION --Exception errors for when the rules are broken.
	WHEN twoRoles THEN
		RAISE_APPLICATION_ERROR(-20001, 'Actor is starring in the movie:' || :new.movieId);
		
	WHEN over230 THEN
		RAISE_APPLICATION_ERROR(-20001, 'Movie has over 230 castings.' || :new.movieId);
END;

--8.1a
BEGIN
	addRole(89558,238072,"Danny Ocean");
END;

--8.1b
BEGIN
	addRole(89558,238073,"Danny Ocean");
END;

--8.1c
BEGIN
	addRole(89558,167324,"Danny Ocean");
END;