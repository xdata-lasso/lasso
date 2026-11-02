-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Scientists (SSN, Name) VALUES (10, 'S1');
INSERT INTO Scientists (SSN, Name) VALUES (20, 'S2');
INSERT INTO Scientists (SSN, Name) VALUES (30, 'S3');
INSERT INTO Projects (Code, Name, Hours) VALUES ('A1', 'Zebra', 400);
INSERT INTO Projects (Code, Name, Hours) VALUES ('A2', 'Apple', 400);
INSERT INTO Projects (Code, Name, Hours) VALUES ('A3', NULL, 400);
INSERT INTO Projects (Code, Name, Hours) VALUES ('A4', 'Mango', 350);
INSERT INTO Projects (Code, Name, Hours) VALUES ('A5', 'Apple', 500);
INSERT INTO AssignedTo (Scientist, Project) VALUES (10, 'A1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (20, 'A1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (10, 'A2');
INSERT INTO AssignedTo (Scientist, Project) VALUES (20, 'A2');
INSERT INTO AssignedTo (Scientist, Project) VALUES (10, 'A3');
INSERT INTO AssignedTo (Scientist, Project) VALUES (20, 'A3');
INSERT INTO AssignedTo (Scientist, Project) VALUES (10, 'A4');
INSERT INTO AssignedTo (Scientist, Project) VALUES (10, 'A5');
INSERT INTO AssignedTo (Scientist, Project) VALUES (20, 'A5');
INSERT INTO AssignedTo (Scientist, Project) VALUES (30, 'A5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT code, name, hours, n, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT project, COUNT(*) AS n FROM assignedto GROUP BY project) AS RHS ON (LHS.code = RHS.project))) WHERE (hours > 300 AND n < hours) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Mango')
(2, 'Apple')
(2, 'Zebra')
(2, None)
(3, 'Apple')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code = T2.project WHERE T1.hours > 300 GROUP BY T1.name;

/*
Prediction Result:
(2, None)
(5, 'Apple')
(1, 'Mango')
(2, 'Zebra')
*/