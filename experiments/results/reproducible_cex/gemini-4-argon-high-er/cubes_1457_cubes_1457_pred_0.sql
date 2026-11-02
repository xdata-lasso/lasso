-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Scientists" ("SSN", "Name") VALUES (1, 'Alice');
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P1', 'ProjA', 400);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P2', 'ProjA', 400);
INSERT INTO "AssignedTo" ("Scientist", "Project") VALUES (1, 'P1');
INSERT INTO "AssignedTo" ("Scientist", "Project") VALUES (1, 'P2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT code, name, hours, n, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT project, COUNT(*) AS n FROM assignedto GROUP BY project) AS RHS ON (LHS.code = RHS.project))) WHERE (hours > 300 AND n < hours) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'ProjA')
(1, 'ProjA')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM projects AS T1 JOIN assignedto AS T2 ON T1.code = T2.project WHERE T1.hours > 300 GROUP BY T1.name;

/*
Prediction Result:
(2, 'ProjA')
*/