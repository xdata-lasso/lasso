-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: scientists --
INSERT INTO "scientists" ("ssn", "name") VALUES (1, 'sci_6810ef');

-- Inserting into table: projects --
INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_1', 'pro_b7616b', -55602865);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_2', 'pro_b7616b', -921145356);

-- Inserting into table: assignedto --
INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_1');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_2');
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