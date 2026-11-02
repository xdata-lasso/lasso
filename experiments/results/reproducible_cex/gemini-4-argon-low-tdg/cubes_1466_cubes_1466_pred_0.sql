-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Scientists (SSN, Name) VALUES (1, 'Alice');
INSERT INTO Scientists (SSN, Name) VALUES (2, 'Alice');
INSERT INTO Scientists (SSN, Name) VALUES (3, 'Bob');
INSERT INTO Scientists (SSN, Name) VALUES (4, 'Charlie');
INSERT INTO Scientists (SSN, Name) VALUES (5, NULL);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P1', 'Proj1', 10);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P2', 'Proj2', 20);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P3', 'Proj3', 30);
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P2');
INSERT INTO AssignedTo (Scientist, Project) VALUES (3, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (3, 'P2');
INSERT INTO AssignedTo (Scientist, Project) VALUES (4, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (4, 'P2');
INSERT INTO AssignedTo (Scientist, Project) VALUES (4, 'P3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, name FROM (SELECT name, scientist, COUNT(*) AS n FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist, RHS.project AS project FROM scientists AS LHS CROSS JOIN assignedto AS RHS) GROUP BY name, scientist) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(2, 'Bob')
(2, 'Charlie')
(2, None)
(3, 'Bob')
(3, 'Charlie')
(3, None)
(4, 'Alice')
(6, 'Alice')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM scientists AS T1 JOIN assignedto AS T2 ON T1.ssn = T2.scientist GROUP BY T1.name;

/*
Prediction Result:
(2, 'Alice')
(2, 'Bob')
(3, 'Charlie')
*/