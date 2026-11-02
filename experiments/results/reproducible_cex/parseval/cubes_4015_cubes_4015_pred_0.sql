-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: projects --
INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_1', 'pro_b7616b', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('lhs_5f92d3', 'lhs_cbe377', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_3', 'pro_b7616b', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_4', 'pro_b7616b', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('lhs_56ad2a', 'lhs_e5e00c', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_6', 'pro_b7616b', NULL);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_7', 'pro_b7616b', NULL);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_8', 'pro_b7616b', NULL);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_9', NULL, -55602865);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('c_10', NULL, 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('c_11', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours FROM projects AS LHS INNER JOIN (SELECT MAX(hours) AS hours FROM projects) AS RHS ON (LHS.hours = RHS.hours)) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
('lhs_cbe377',)
('lhs_e5e00c',)
('pro_b7616b',)
('pro_b7616b',)
('pro_b7616b',)
*/

-- Prediction Query
SELECT name FROM projects ORDER BY hours DESC, projects.code NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/