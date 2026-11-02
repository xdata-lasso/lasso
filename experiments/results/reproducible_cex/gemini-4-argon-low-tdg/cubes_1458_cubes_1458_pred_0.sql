-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(*) vs COUNT(DISTINCT Scientist) and COUNT(DISTINCT Project) when both have duplicates.
-- 2. Querying AssignedTo vs Scientists or Projects (all 3 tables have different cardinalities: 3, 4, 5).
-- 3. Unassigned Scientists and unassigned Projects (tests INNER JOIN vs LEFT/RIGHT JOIN mutants).
-- 4. Scientists and Projects with NULL attributes (tests if mutant filters or counts nullable columns in parent tables).
INSERT INTO Scientists (SSN, Name) VALUES (1, 'Alice');
INSERT INTO Scientists (SSN, Name) VALUES (2, 'Bob');
INSERT INTO Scientists (SSN, Name) VALUES (3, NULL);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P1', 'Alpha', 100);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P2', 'Beta', 200);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P3', NULL, NULL);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P4', 'Delta', 0);
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P2');
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P3');
INSERT INTO AssignedTo (Scientist, Project) VALUES (2, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (2, 'P2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_scientist_ FROM (SELECT COUNT(*) AS n FROM assignedto) ORDER BY count_distinct_scientist_;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT scientist) FROM assignedto;

/*
Prediction Result:
(2,)
*/