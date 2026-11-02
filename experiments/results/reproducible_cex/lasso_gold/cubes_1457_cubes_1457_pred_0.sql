-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "projects" ("code", "name", "hours") VALUES ('receive', 'Deborah Brennan', 301);
INSERT INTO "projects" ("code", "name", "hours") VALUES ('may', 'Daniel Ryan', 301);
INSERT INTO "projects" ("code", "name", "hours") VALUES ('your', 'Christina Collins', 301);
INSERT INTO "projects" ("code", "name", "hours") VALUES ('avoid', 'Deborah Brennan', 301);
INSERT INTO "scientists" ("ssn", "name") VALUES (1024, 'Marie Kim DDS');
INSERT INTO "scientists" ("ssn", "name") VALUES (1025, 'Danny Morgan');
INSERT INTO "scientists" ("ssn", "name") VALUES (1026, 'Crystal Robinson');
INSERT INTO "scientists" ("ssn", "name") VALUES (1027, 'Austin Johnson');
INSERT INTO "scientists" ("ssn", "name") VALUES (1028, 'Jose Ramirez');
INSERT INTO "scientists" ("ssn", "name") VALUES (1029, 'Mr. Nathaniel Khan');
INSERT INTO "assignedto" ("scientist", "project") VALUES (1024, 'receive');
INSERT INTO "assignedto" ("scientist", "project") VALUES (1025, 'receive');
INSERT INTO "assignedto" ("scientist", "project") VALUES (1026, 'receive');
INSERT INTO "assignedto" ("scientist", "project") VALUES (1027, 'avoid');
INSERT INTO "assignedto" ("scientist", "project") VALUES (1028, 'avoid');
INSERT INTO "assignedto" ("scientist", "project") VALUES (1029, 'avoid');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT code, name, hours, n, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT project, COUNT(*) AS n FROM assignedto GROUP BY project) AS RHS ON (LHS.code = RHS.project))) WHERE (hours > 300 AND n < hours) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(3, 'Deborah Brennan')
(3, 'Deborah Brennan')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code = T2.project WHERE T1.hours > 300 GROUP BY T1.name;

/*
Prediction Result:
(6, 'Deborah Brennan')
*/