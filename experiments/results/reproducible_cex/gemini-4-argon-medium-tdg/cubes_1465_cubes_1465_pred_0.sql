-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests COUNT(DISTINCT ssn) vs COUNT(ssn) or COUNT(*) and COUNT(DISTINCT name)
-- Two scientists share the name 'P001' which matches a project code assigned to multiple scientists.
-- Reference returns 2 (SSNs 1 and 2). COUNT(*) would return 4. COUNT(DISTINCT name) would return 1. COUNT(DISTINCT scientist) would return 2, so we add a 3rd scientist to AssignedTo to make COUNT(DISTINCT scientist) = 3.
INSERT INTO Scientists (SSN, Name) VALUES (1, 'P001');
INSERT INTO Scientists (SSN, Name) VALUES (2, 'P001');
INSERT INTO Scientists (SSN, Name) VALUES (3, 'Charlie');
INSERT INTO Scientists (SSN, Name) VALUES (4, 'David');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P001', 'Project One', 50);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P002', 'Project Two', 60);
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (3, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (4, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (2, 'P002');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT ssn) AS n_distinct FROM (SELECT ssn, name, scientist, name AS project FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist FROM scientists AS LHS INNER JOIN assignedto AS RHS ON (LHS.name = RHS.project)))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM scientists WHERE NOT ssn IN (SELECT scientist FROM AssignedTo);

/*
Prediction Result:
(0,)
*/