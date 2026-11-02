-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: scientists --
INSERT INTO "scientists" ("ssn", "name") VALUES (1, 't1__7415fe');

INSERT INTO "scientists" ("ssn", "name") VALUES (-2147483647, 't1__7415fe');

INSERT INTO "scientists" ("ssn", "name") VALUES (2, 't1__7415fe');

INSERT INTO "scientists" ("ssn", "name") VALUES (3, 't1__7415fe');

INSERT INTO "scientists" ("ssn", "name") VALUES (4, 't1__7415fe');

INSERT INTO "scientists" ("ssn", "name") VALUES (5, 'sci_6810ef');

-- Inserting into table: projects --
INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_1', 'pro_b7616b', -55602865);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_2', 'pro_b7616b', -921145356);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_3', 'pro_b7616b', -1022641847);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_4', 'pro_b7616b', 1610062532);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_5', 'pro_b7616b', 1871297066);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_6', 'pro_b7616b', 89267185);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_7', 'pro_b7616b', 1744686505);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_8', 'pro_b7616b', 1160656988);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_9', 'pro_b7616b', -252690330);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('c_10', 'pro_b7616b', -1670923962);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('c_11', 'pro_b7616b', 906324270);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('c_12', 'pro_b7616b', 2122220075);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('c_13', 'pro_b7616b', -1349201381);

-- Inserting into table: assignedto --
INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_1');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_2');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_3');

INSERT INTO "assignedto" ("scientist", "project") VALUES (5, 'co_1');

INSERT INTO "assignedto" ("scientist", "project") VALUES (5, 'co_2');

INSERT INTO "assignedto" ("scientist", "project") VALUES (5, 'co_4');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_4');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_5');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_6');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_7');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_8');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'co_9');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'c_10');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'c_11');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'c_12');

INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'c_13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, name FROM (SELECT name, scientist, COUNT(*) AS n FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist, RHS.project AS project FROM scientists AS LHS CROSS JOIN assignedto AS RHS) GROUP BY name, scientist) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(3, 'sci_6810ef')
(13, 'sci_6810ef')
(15, 't1__7415fe')
(65, 't1__7415fe')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM scientists AS T1 JOIN assignedto AS T2 ON T1.ssn = T2.scientist GROUP BY T1.name;

/*
Prediction Result:
(3, 'sci_6810ef')
(13, 't1__7415fe')
*/