-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Scientists (SSN, Name) VALUES (1, 'Alice');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT ssn) AS n_distinct FROM (SELECT ssn, name, scientist, name AS project FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist FROM scientists AS LHS INNER JOIN assignedto AS RHS ON (LHS.name = RHS.project)))) ORDER BY count___;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM scientists WHERE NOT ssn IN (SELECT scientist FROM AssignedTo);

/*
Prediction Result:
(1,)
*/