-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Empty Projects table (tests difference between window COUNT(*) OVER() returning empty set vs aggregate COUNT(*) returning 0)
INSERT INTO "Scientists" ("SSN", "Name") VALUES (101, 'Ada Lovelace');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_name_ FROM projects ORDER BY count_distinct_name_;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(DISTINCT name) FROM projects;

/*
Prediction Result:
(0,)
*/