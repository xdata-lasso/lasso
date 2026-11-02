-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Scientists" ("ssn", "name") VALUES (18, '19');
INSERT INTO "Scientists" ("ssn", "name") VALUES (24, NULL);
INSERT INTO "Projects" ("code", "name", "hours") VALUES ('13', '19', 19);
INSERT INTO "Projects" ("code", "name", "hours") VALUES ('19', '19', 19);
INSERT INTO "AssignedTo" ("scientist", "project") VALUES (24, '13');
INSERT INTO "AssignedTo" ("scientist", "project") VALUES (24, '19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT ssn) AS n_distinct FROM (SELECT ssn, name, scientist, name AS project FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist FROM scientists AS LHS INNER JOIN assignedto AS RHS ON (LHS.name = RHS.project)))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM scientists WHERE NOT ssn IN (SELECT scientist FROM AssignedTo);

/*
Prediction Result:
(1,)
*/