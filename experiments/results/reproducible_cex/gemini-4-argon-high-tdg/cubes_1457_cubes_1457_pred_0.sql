-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Scientists (SSN, Name) VALUES (101, 'Alice');
INSERT INTO Scientists (SSN, Name) VALUES (102, 'Bob');
INSERT INTO Scientists (SSN, Name) VALUES (103, 'Charlie');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P001', 'Boundary300', 300);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P002', 'Boundary301', 301);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P003', 'UnassignedHigh', 500);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P004', 'ValidProject', 400);
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P002');
INSERT INTO AssignedTo (Scientist, Project) VALUES (102, 'P002');
INSERT INTO AssignedTo (Scientist, Project) VALUES (103, 'P004');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT code, name, hours, n, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT project, COUNT(*) AS n FROM assignedto GROUP BY project) AS RHS ON (LHS.code = RHS.project))) WHERE (hours > 300 AND n < hours) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'ValidProject')
(2, 'Boundary301')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code = T2.project WHERE T1.hours > 300 GROUP BY T1.name;

/*
Prediction Result:
(2, 'Boundary301')
(1, 'ValidProject')
*/