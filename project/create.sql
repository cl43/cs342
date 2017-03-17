
-- Create the Vegetable company user and data. 
-- See ../README.txt for details.

-- Create the user.
DROP USER cl43 CASCADE;
CREATE USER cl43 
	IDENTIFIED BY veggies
	QUOTA 5M ON System;
GRANT 
	CONNECT,
	CREATE TABLE,
	CREATE SESSION,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE MATERIALIZED VIEW,
	CREATE PROCEDURE,
	CREATE TRIGGER,
	UNLIMITED TABLESPACE
	TO cl43;

-- Connect to the user's account/schema.
CONNECT cl43/veggies;

-- Create the database.
DEFINE cl43=S:\CS342\project
@&cl43\load