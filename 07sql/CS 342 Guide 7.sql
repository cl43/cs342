--1a.
CREATE VIEW Movie_Performer
AS SELECT id, title, year, firstName, lastName, status
FROM Movie, Performer, Casting
WHERE Casting.status = 'star';

--1b.
--i. Base Tables = A physical structure that contains tuples.
--ii. Join Views = A view that is formed when two separate views are joined,
--iii. Updateable Join Views = A joined view that can be updated by the DBMS.
--iv. Key-Preserved Tables = A table where every key of the table can be a key of the resulted join.
--v. Materialized View = A view that is a replica of its target master from a single point in time.