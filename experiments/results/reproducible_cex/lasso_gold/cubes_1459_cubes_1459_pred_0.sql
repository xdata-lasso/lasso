-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "projects" ("code", "name", "hours") VALUES ('chair', 'Megan Mcclain', 1002);
INSERT INTO "projects" ("code", "name", "hours") VALUES ('begin', 'Megan Mcclain', 1002);
INSERT INTO "scientists" ("ssn", "name") VALUES (1003, 'Amanda Davis');
INSERT INTO "assignedto" ("scientist", "project") VALUES (1003, 'begin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM projects AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT code, name, hours, scientist, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.scientist AS scientist FROM projects AS LHS INNER JOIN assignedto AS RHS ON (LHS.code = RHS.project))) AS RHS WHERE (LHS.hours = RHS.hours AND LHS.name = RHS.name))) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT Name FROM Projects WHERE NOT Code IN (SELECT Project FROM AssignedTo);

/*
Prediction Result:
('Megan Mcclain',)
*/