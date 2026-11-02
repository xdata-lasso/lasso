-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name (out of insertion order), duplicate Names (kills DISTINCT), and tie-breaking by SSN.
INSERT INTO "Scientists" ("SSN", "Name") VALUES (102, 'Charlie');
INSERT INTO "Scientists" ("SSN", "Name") VALUES (105, 'Alice');
INSERT INTO "Scientists" ("SSN", "Name") VALUES (101, 'Alice');
INSERT INTO "Scientists" ("SSN", "Name") VALUES (103, 'Bob');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM scientists ORDER BY name, scientists.ssn NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT T2.name FROM assignedto AS T1 JOIN scientists AS T2 ON T1.scientist = T2.ssn;

/*
Prediction Result:
*/