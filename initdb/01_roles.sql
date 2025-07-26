-- 01_roles.sql
-- This script defines the roles for the clinic we are working with

CREATE ROLE  doctor NOLOGIN;
CREATE ROLE  nurse NOLOGIN;
CREATE ROLE receptionist NOLOGIN;
CREATE ROLE analyst NOLOGIN;
CREATE ROLE admin NOLOGIN;

GRANT doctor TO admin;
GRANT nurse TO admin;
GRANT receptionist TO admin;
GRANT analyst TO admin;
