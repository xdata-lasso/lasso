-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests a single scientist assigned to multiple projects, plus unassigned scientists and projects.
-- Distinguishes COUNT(*) (returns 3) from COUNT(DISTINCT Scientist) (returns 1) and COUNT(DISTINCT Project) (returns 3, but tested against Scientist).
-- Also catches mutants that INNER/LEFT JOIN with Scientists or Projects without filtering, or count from the wrong table.
INSERT INTO Scientists (SSN, Name) VALUES (101, 'Marie Curie');
INSERT INTO Scientists (SSN, Name) VALUES (102, 'Albert Einstein');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P001', 'Radium Research', 100);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P002', 'Polonium Isolation', 200);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P003', 'Mobile X-Ray', 150);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P004', 'Relativity', 300);
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P002');
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P003');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_scientist_ FROM (SELECT COUNT(*) AS n FROM assignedto) ORDER BY count_distinct_scientist_;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT scientist) FROM assignedto;

/*
Prediction Result:
(1,)
*/