-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "projects" ("code", "name", "hours") VALUES ('purpose', 'Patrick Sanchez', 1001);
INSERT INTO "scientists" ("ssn", "name") VALUES (1002, 'Brian Yang');
INSERT INTO "assignedto" ("scientist", "project") VALUES (1002, 'purpose');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.scientist AS scientist, LHS.project AS project, RHS.maxhours AS maxhours FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist, RHS.project AS project FROM scientists AS LHS CROSS JOIN assignedto AS RHS) AS LHS CROSS JOIN (SELECT MAX(hours) AS maxhours FROM projects) AS RHS) ORDER BY name;

/*
Gold Result:
('Brian Yang',)
*/

-- Prediction Query
SELECT name FROM scientists EXCEPT SELECT T3.name FROM assignedto AS T1 JOIN projects AS T2 ON T1.project = T2.code JOIN scientists AS T3 ON T1.scientist = T3.SSN WHERE T2.hours = (SELECT MAX(hours) FROM projects);

/*
Prediction Result:
*/