-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('agent', 'Jennifer Ramirez', 'Bangladesh', 'spring');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('nothing', 'Teresa Mclaughlin', 'Congo', 'himself');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1028, 'agent', '514 Estrada Islands Suite 482
South Elizabeth, MS 89278', 'Mrs. Stephanie Lee', 'Grondzeiler', 1029, 'Nature a expert involve oil pressure.');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1030, 'nothing', '850 Natalie Green Apt. 940
New Ryanmouth, NE 79958', 'Jeremy Lewis', 'Grondzeiler', 1030, 'Remember ability understand.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "built_year" FROM "mill" WHERE ("type" = 'Grondzeiler') ORDER BY name, mill.id NULLS LAST;

/*
Gold Result:
('Jeremy Lewis', 1030)
('Mrs. Stephanie Lee', 1029)
*/

-- Prediction Query
SELECT name, built_year FROM mill WHERE TYPE = 'Grondzeiler';

/*
Prediction Result:
('Mrs. Stephanie Lee', 1029)
('Jeremy Lewis', 1030)
*/