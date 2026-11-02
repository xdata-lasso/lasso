-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Scientists (SSN, Name) VALUES (1, 'Alice');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P1', 'Proj1', 10);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P2', 'Proj2', 20);
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (1, 'P2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_scientist_ FROM (SELECT COUNT(*) AS n FROM assignedto) ORDER BY count_distinct_scientist_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT scientist) FROM assignedto;

/*
Prediction Result:
(1,)
*/