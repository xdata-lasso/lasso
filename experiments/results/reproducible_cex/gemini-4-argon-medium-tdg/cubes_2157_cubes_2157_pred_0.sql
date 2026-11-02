-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('1', 'Jan Jansen', 'Dutch', 'Male');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1, 1, 'Amsterdam', 'De Gooyer', 'Stellingmolen', 1725, 'Historic');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (2, 1, 'Leiden', 'De Valk', 'Grondzeiler', 1743, 'Museum');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (3, 1, 'Delft', 'De Roos', 'Grondzeiler', 1679, 'Active');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (4, 1, 'Utrecht', 'Rijn en Zon', 'grondzeiler', 1913, 'Case test');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (5, 1, 'Gouda', 'De Roode Leeuw', NULL, 1727, 'Null type');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "built_year" FROM "mill" WHERE ("type" = 'Grondzeiler') ORDER BY name, mill.id NULLS LAST;

/*
Gold Result:
('De Roos', 1679)
('De Valk', 1743)
*/

-- Prediction Query
SELECT name, built_year FROM mill WHERE TYPE = 'Grondzeiler';

/*
Prediction Result:
('De Valk', 1743)
('De Roos', 1679)
*/