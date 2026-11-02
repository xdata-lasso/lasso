-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: projects --
INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_1', 'pro_3908ef', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_2', 'pro_3908ef', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_3', 'pro_3908ef', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_4', 'pro_3908ef', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_5', 'pro_3908ef', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_6', 'pro_3908ef', 1);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_7', 'pro_b7616b', NULL);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_8', 'pro_3908ef', NULL);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('co_9', 'pro_3908ef', NULL);

INSERT INTO "projects" ("code", "name", "hours") VALUES ('c_10', 'pro_3908ef', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT hours, name, AVG(hours) AS meanhours FROM projects GROUP BY hours, name) ORDER BY hours DESC) LIMIT 2);

/*
Gold Result:
('pro_3908ef',)
('pro_3908ef',)
*/

-- Prediction Query
SELECT name FROM projects WHERE hours > (SELECT AVG(hours) FROM projects);

/*
Prediction Result:
*/