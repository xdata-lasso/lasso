-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Scientists (SSN, Name) VALUES (101, 'Alice');
INSERT INTO Scientists (SSN, Name) VALUES (102, 'Bob');
INSERT INTO Scientists (SSN, Name) VALUES (103, 'Carol');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P001', 'Alpha', 100);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P002', 'Beta', 200);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P003', 'Gamma', 300);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P004', 'Delta', 400);
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P002');
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P003');
INSERT INTO AssignedTo (Scientist, Project) VALUES (102, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (102, 'P002');
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