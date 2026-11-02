-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Scientists (SSN, Name) VALUES (1, 'Alice');
INSERT INTO Scientists (SSN, Name) VALUES (2, 'Bob');
INSERT INTO Scientists (SSN, Name) VALUES (3, 'Charlie');
INSERT INTO Scientists (SSN, Name) VALUES (4, 'David');
INSERT INTO Scientists (SSN, Name) VALUES (5, NULL);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P1', 'Alpha', 300);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P2', 'Beta', 301);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P3', 'Gamma', 299);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P4', 'Delta', 500);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P5', NULL, 400);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P6', 'Alpha', 600);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P7', 'Zeta', NULL);
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P2');
INSERT INTO AssignedTo (Scientist, Project) VALUES (2, 'P2');
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P3');
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P5');
INSERT INTO AssignedTo (Scientist, Project) VALUES (2, 'P5');
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P6');
INSERT INTO AssignedTo (Scientist, Project) VALUES (2, 'P6');
INSERT INTO AssignedTo (Scientist, Project) VALUES (3, 'P6');
INSERT INTO AssignedTo (Scientist, Project) VALUES (5, 'P6');
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT code, name, hours, n, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT project, COUNT(*) AS n FROM assignedto GROUP BY project) AS RHS ON (LHS.code = RHS.project))) WHERE (hours > 300 AND n < hours) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(2, 'Beta')
(2, None)
(4, 'Alpha')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code = T2.project WHERE T1.hours > 300 GROUP BY T1.name;

/*
Prediction Result:
(2, None)
(4, 'Alpha')
(2, 'Beta')
*/