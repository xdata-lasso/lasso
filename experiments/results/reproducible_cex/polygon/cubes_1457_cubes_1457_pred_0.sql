-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Scientists" ("ssn", "name") VALUES (24, '20');
INSERT INTO "Scientists" ("ssn", "name") VALUES (26, '20');
INSERT INTO "Projects" ("code", "name", "hours") VALUES ('25', '20', 655);
INSERT INTO "Projects" ("code", "name", "hours") VALUES ('27', '20', 301);
INSERT INTO "AssignedTo" ("scientist", "project") VALUES (24, '25');
INSERT INTO "AssignedTo" ("scientist", "project") VALUES (26, '27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT code, name, hours, n, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT project, COUNT(*) AS n FROM assignedto GROUP BY project) AS RHS ON (LHS.code = RHS.project))) WHERE (hours > 300 AND n < hours) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, '20')
(1, '20')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code = T2.project WHERE T1.hours > 300 GROUP BY T1.name;

/*
Prediction Result:
(2, '20')
*/