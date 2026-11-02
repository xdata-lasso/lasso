-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Scientists" ("ssn", "name") VALUES (9, '16');
INSERT INTO "Projects" ("code", "name", "hours") VALUES ('10', '16', -636);
INSERT INTO "Projects" ("code", "name", "hours") VALUES ('15', '16', -635);
INSERT INTO "AssignedTo" ("scientist", "project") VALUES (9, '15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours FROM projects AS LHS INNER JOIN (SELECT MAX(hours) AS hours FROM projects) AS RHS ON (LHS.hours = RHS.hours)) ORDER BY name;

/*
Gold Result:
('16',)
*/

-- Prediction Query
SELECT name FROM projects ORDER BY hours DESC, projects.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('16',)
*/