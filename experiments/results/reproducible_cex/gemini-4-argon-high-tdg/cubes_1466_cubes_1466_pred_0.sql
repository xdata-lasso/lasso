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
INSERT INTO Projects (Code, Name, Hours) VALUES ('P001', 'Alpha', 100);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P002', 'Beta', 200);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P003', 'Gamma', 300);
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (2, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (2, 'P002');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, name FROM (SELECT name, scientist, COUNT(*) AS n FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist, RHS.project AS project FROM scientists AS LHS CROSS JOIN assignedto AS RHS) GROUP BY name, scientist) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Alice')
(1, 'Bob')
(1, 'Charlie')
(2, 'Alice')
(2, 'Bob')
(2, 'Charlie')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM scientists AS T1 JOIN assignedto AS T2 ON T1.ssn = T2.scientist GROUP BY T1.name;

/*
Prediction Result:
(1, 'Alice')
(2, 'Bob')
*/