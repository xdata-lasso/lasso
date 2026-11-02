-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: scientists --
INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483648, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483647, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483646, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483645, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483644, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483643, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483642, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483641, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483640, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483639, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483638, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483637, 'sci_6810ef');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483636, 'sci_6810ef');

-- Inserting into table: projects --
INSERT INTO "projects" ("code", "name", "hours") VALUES ('t1__039553', 't1__d3d5c6', 301);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('A', 't1__d3d5c6', 301);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('t1__f3ce25', 't1__d3d5c6', 301);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('t1__f9b681', 't1__d3d5c6', 301);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('a', 't1__d3d5c6', 301);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('@', 't1__d3d5c6', 301);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('K', 't1__d3d5c6', 301);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('C', 't1__d3d5c6', 301);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('t2__678336', 't1__d3d5c6', 301);

-- Inserting into table: assignedto --
INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483648, 't1__039553');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483648, 'A');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483647, 'A');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483646, 'A');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483645, 'A');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483644, 'A');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483643, 'A');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483646, 't2__678336');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483648, 't2__678336');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483642, 't2__678336');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483641, 't2__678336');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483640, 't2__678336');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483639, 't2__678336');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483645, 't2__678336');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483638, 't2__678336');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483640, 't1__039553');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483637, 't2__678336');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483636, 't2__678336');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483645, 't1__039553');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483647, 't1__039553');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT code, name, hours, n, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT project, COUNT(*) AS n FROM assignedto GROUP BY project) AS RHS ON (LHS.code = RHS.project))) WHERE (hours > 300 AND n < hours) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(4, 't1__d3d5c6')
(6, 't1__d3d5c6')
(10, 't1__d3d5c6')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code = T2.project WHERE T1.hours > 300 GROUP BY T1.name;

/*
Prediction Result:
(20, 't1__d3d5c6')
*/