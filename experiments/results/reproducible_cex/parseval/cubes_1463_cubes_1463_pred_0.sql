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

-- Inserting into table: projects --
INSERT INTO "projects" ("code", "name", "hours") VALUES ('t1__4185e1', 't1__155e55', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('C', 't1__155e55', -55602865);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('t1__76b86f', 't1__155e55', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('`', 't1__155e55', -664303813);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('@', 't1__155e55', -1022641847);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('a', 't1__155e55', -1726781632);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('A', 'pro_b7616b', 247012447);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('!', 't1__155e55', -1980249628);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('t2__1f2841', 't1__155e55', 1);

-- Inserting into table: assignedto --
INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483648, 't1__4185e1');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483647, 't1__4185e1');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483646, 't1__4185e1');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483646, 'A');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483648, 'A');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483645, 'A');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483646, 't2__1f2841');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483644, 't2__1f2841');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483648, 't2__1f2841');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483643, 't2__1f2841');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483645, 't2__1f2841');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483642, 't2__1f2841');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483641, 't2__1f2841');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483640, 't1__4185e1');

INSERT INTO "assignedto" ("scientist", "project") VALUES (-2147483644, 't1__4185e1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT project, COUNT(*) AS n FROM assignedto GROUP BY project) AS RHS ON (LHS.code = RHS.project)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(3, 'pro_b7616b')
(5, 't1__155e55')
(7, 't1__155e55')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code = T2.project GROUP BY T1.name;

/*
Prediction Result:
(3, 'pro_b7616b')
(12, 't1__155e55')
*/