-- Load the Centrepointe church database. 
-- See ../README.md for details.

-- Drop the previous table declarations.
@&cl43\drop         
commit;
-- Reload the table declarations.
@&cl43\schema
commit;
-- Load the table data.
@&cl43\data
commit;