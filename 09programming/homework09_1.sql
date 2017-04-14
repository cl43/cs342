--1
SELECT *
FROM Movie M, MovieDirector md, Director D
WHERE M.id = MD.movieId AND MD.directorId = D.id
AND d.firstName = 'Clint' AND d.lastName = 'Eastwood';

SELECT * FROM Movie M
JOIN MovieDirector MD ON M.id = MD.movieId
WHERE MD.directorId in (select id from Director WHERE firstname = 'Clint' and lastname = 'Eastwood');

CREATE INDEX directorIndex ON Director(firstname, lastname);

SELECT *
FROM Movie M, MovieDirector md, Director D
WHERE M.id = MD.movieId AND MD.directorId = D.id
AND d.firstName = 'Clint' AND d.lastName = 'Eastwood';

--This query required 0.03 seconds. The other methods that I used was the nested select query 
--which resulted in the same time elapsed. The only difference is that it uses nested loops instead of hash join.
--I later created an index for director table to divert from using a full table scan which did not really change
--the amount of time elapsed.The index seems to have changed the execution plan from a full table scan to
--Access by rowId and Index Range Scan. Although those two seem more complicated to perform than the simple full
--table scan, it seems oracle knows how to auto optimize these queries.

--2.
SELECT directorId, COUNT(*)
FROM MovieDirector
GROUP BY directorId
HAVING COUNT(*) > 200;

CREATE INDEX MovieDirectorIndex ON MovieDirector(directorId);

SELECT directorId, COUNT(*)
FROM MovieDirector
GROUP BY directorId
HAVING COUNT(*) > 200;

--The query took around 0.06-0.07 seconds to run. The execution plan uses a filter to find the directorIds of
--directors that have directed over 200 movies. The query again uses a hash join and group by in its execution plan.
--Creating an index for this query seems to have no effect. It is probably because the query has to go through so 
--many rows, the optimizer decides it is better to go through with a full table access instead.

--3.
SELECT A.id
FROM Movie M, Actor A, Role R
WHERE M.id = R.movieId AND R.actorId = A.id
GROUP BY A.id
HAVING AVG(rank) > 8.5 AND COUNT(*) >= 10;

CREATE INDEX ActorIndex ON Actor(id);

SELECT A.id
FROM Movie M, Actor A, Role R
WHERE M.id = R.movieId AND R.actorId = A.id
GROUP BY A.id
HAVING AVG(rank) > 8.5 AND COUNT(*) >= 10;

SELECT A.id
FROM Movie M, Actor A, Role R
WHERE M.id = R.movieId AND R.actorId = A.id
GROUP BY A.id
HAVING AVG(rank) > 8.5
INTERSECT
SELECT A.id
FROM Movie M, Actor A, Role R
WHERE M.id = R.movieId AND R.actorId = A.id
GROUP BY A.id
HAVING COUNT(*) >= 10;

--This query took around 2 seconds to run. Its execution plan uses a hash join to connect the tables.
--Then hash group and filter is used in order to find the average rank of the actors compare it to 8.5,
--and then compare the actor's movie count to 10. The index seems to provide no effect again, since
--oracle's optimizer seems to think its better to full table scan for this query. The third query finds
--the average rank of the actor then intersects with another query that finds actors with atleast 10 movies
--under their belt. This query took 3.30 seconds. It seems this query is less efficient since it is composed
--of two queries.