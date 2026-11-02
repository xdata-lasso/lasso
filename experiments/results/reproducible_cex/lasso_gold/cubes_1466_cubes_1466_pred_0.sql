-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "projects" ("code", "name", "hours") VALUES ('offer', 'Javier Johnson', 1003);
INSERT INTO "scientists" ("ssn", "name") VALUES (1004, 'Jonathan Johnson');
INSERT INTO "scientists" ("ssn", "name") VALUES (1008, NULL);
INSERT INTO "assignedto" ("scientist", "project") VALUES (1004, 'offer');
INSERT INTO "assignedto" ("scientist", "project") VALUES (1008, 'offer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, name FROM (SELECT name, scientist, COUNT(*) AS n FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist, RHS.project AS project FROM scientists AS LHS CROSS JOIN assignedto AS RHS) GROUP BY name, scientist) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Jonathan Johnson')
(1, None)
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM scientists AS T1 JOIN assignedto AS T2 ON T1.ssn = T2.scientist GROUP BY T1.name;

/*
Prediction Result:
(1, None)
(1, 'Jonathan Johnson')
*/