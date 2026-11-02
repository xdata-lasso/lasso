-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Scientists (SSN, Name) VALUES (1, 'P1');
INSERT INTO Scientists (SSN, Name) VALUES (2, 'P1');
INSERT INTO Scientists (SSN, Name) VALUES (3, 'P2');
INSERT INTO Scientists (SSN, Name) VALUES (4, 'P2');
INSERT INTO Scientists (SSN, Name) VALUES (5, 'P3');
INSERT INTO Scientists (SSN, Name) VALUES (6, 'Alice');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P1', 'Alpha', 100);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P2', 'Beta', 200);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P3', 'Gamma', 300);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P4', 'Delta', 400);
INSERT INTO AssignedTo (Scientist, Project) VALUES (6, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (5, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (4, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (6, 'P2');
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P4');
INSERT INTO AssignedTo (Scientist, Project) VALUES (2, 'P4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT ssn) AS n_distinct FROM (SELECT ssn, name, scientist, name AS project FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist FROM scientists AS LHS INNER JOIN assignedto AS RHS ON (LHS.name = RHS.project)))) ORDER BY count___;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM scientists WHERE NOT ssn IN (SELECT scientist FROM AssignedTo);

/*
Prediction Result:
(1,)
*/