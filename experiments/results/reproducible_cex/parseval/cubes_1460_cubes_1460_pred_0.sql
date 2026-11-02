-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: scientists --
INSERT INTO "scientists" ("ssn", "name") VALUES (1, 'lhs_256c1f');

-- Inserting into table: projects --
INSERT INTO "projects" ("code", "name", "hours") VALUES ('rhs_df0a44', 'value', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_2', 'pro_b7616b', NULL);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_3', 'pro_b7616b', NULL);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_4', 'pro_b7616b', NULL);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_5', 'pro_b7616b', NULL);

-- Inserting into table: assignedto --
INSERT INTO "assignedto" ("scientist", "project") VALUES (1, 'rhs_df0a44');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.scientist AS scientist, LHS.project AS project, RHS.maxhours AS maxhours FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, RHS.scientist AS scientist, RHS.project AS project FROM scientists AS LHS CROSS JOIN assignedto AS RHS) AS LHS CROSS JOIN (SELECT MAX(hours) AS maxhours FROM projects) AS RHS) ORDER BY name;

/*
Gold Result:
('lhs_256c1f',)
*/

-- Prediction Query
SELECT name FROM scientists EXCEPT SELECT T3.name FROM assignedto AS T1 JOIN projects AS T2 ON T1.project = T2.code JOIN scientists AS T3 ON T1.scientist = T3.SSN WHERE T2.hours = (SELECT MAX(hours) FROM projects);

/*
Prediction Result:
*/