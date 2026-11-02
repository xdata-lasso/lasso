-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT JOIN (unassigned projects), GROUP BY project vs GROUP BY name (same project names with different codes), and primary ordering by count.
INSERT INTO "Scientists" ("SSN", "Name") VALUES (1, 'Alice');
INSERT INTO "Scientists" ("SSN", "Name") VALUES (2, 'Bob');
INSERT INTO "Scientists" ("SSN", "Name") VALUES (3, 'Charlie');
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P001', 'Alpha', 100);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P002', 'Alpha', 200);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P003', 'Beta', 150);
INSERT INTO "AssignedTo" ("Scientist", "Project") VALUES (1, 'P001');
INSERT INTO "AssignedTo" ("Scientist", "Project") VALUES (2, 'P001');
INSERT INTO "AssignedTo" ("Scientist", "Project") VALUES (3, 'P002');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT project, COUNT(*) AS n FROM assignedto GROUP BY project) AS RHS ON (LHS.code = RHS.project)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Alpha')
(2, 'Alpha')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code = T2.project GROUP BY T1.name;

/*
Prediction Result:
(3, 'Alpha')
*/