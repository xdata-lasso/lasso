-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: projects --
INSERT INTO "projects" ("code", "name", "hours") VALUES ('pro_fc66ce', 'pro_66032f', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('pro_6b7f86', 'pro_929777', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('!', 'A', -55602865);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('"', 'B', -59984348);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_5', 'q_1_940434', -664303813);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_6', 'q_1_940434', -1022641847);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM projects ORDER BY name, projects.code NULLS LAST) LIMIT 1);

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT name FROM projects ORDER BY hours DESC, projects.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('pro_929777',)
*/