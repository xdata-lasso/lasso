-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Scientists" ("ssn", "name") VALUES (6, '7');
INSERT INTO "Projects" ("code", "name", "hours") VALUES ('8', '11', 7);
INSERT INTO "Projects" ("code", "name", "hours") VALUES ('7', '11', 7);
INSERT INTO "AssignedTo" ("scientist", "project") VALUES (6, '7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_name_ FROM projects ORDER BY count_distinct_name_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT name) FROM projects;

/*
Prediction Result:
(1,)
*/