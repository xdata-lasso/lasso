-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Scientists" ("SSN", "Name") VALUES (1, 'A');
INSERT INTO "Scientists" ("SSN", "Name") VALUES (2, 'B');
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P1', 'Y', 10);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P2', 'X', 20);
INSERT INTO "AssignedTo" ("Scientist", "Project") VALUES (1, 'P1');
INSERT INTO "AssignedTo" ("Scientist", "Project") VALUES (2, 'P2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2, hours FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.code AS code, RHS.name AS name_other, RHS.hours AS hours, RHS.project AS project FROM scientists AS LHS INNER JOIN (SELECT code, name, hours, scientist, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.scientist AS scientist FROM projects AS LHS INNER JOIN assignedto AS RHS ON (LHS.code = RHS.project))) AS RHS ON (LHS.ssn = RHS.scientist)) ORDER BY name___1, name___2 NULLS LAST, hours NULLS LAST;

/*
Gold Result:
('A', 'Y', 10)
('B', 'X', 20)
*/

-- Prediction Query
SELECT T1.Name, T3.Name, T3.Hours FROM Scientists AS T1 JOIN AssignedTo AS T2 ON T1.SSN = T2.Scientist JOIN Projects AS T3 ON T2.Project = T3.Code ORDER BY T3.Name, T1.Name, T1.ssn NULLS LAST, T2.scientist NULLS LAST, T2.project NULLS LAST, T3.code NULLS LAST;

/*
Prediction Result:
('B', 'X', 20)
('A', 'Y', 10)
*/