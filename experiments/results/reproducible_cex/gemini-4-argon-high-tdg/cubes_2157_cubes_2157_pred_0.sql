-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('1', 'Jan Adriaanszoon', 'Dutch', 'Male');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('2', 'Cornelis Corneliszoon', 'Dutch', 'Male');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (50, 1, 'Leiden', 'De Hoop', 'Grondzeiler', 1800, 'Restored');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (10, 1, 'Delft', 'De Hoop', 'Grondzeiler', 1900, 'Active');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (20, 2, 'Gouda', 'Molenzicht', 'Grondzeiler', 1850, 'First twin');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (30, 2, 'Gouda', 'Molenzicht', 'Grondzeiler', 1850, 'Second twin');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (5, 1, 'Alkmaar', 'Albatros', 'Grondzeiler', 1950, 'Newest');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (60, 2, 'Utrecht', 'Zwaluw', 'Grondzeiler', 1750, 'Oldest');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (70, 1, 'Haarlem', 'De Valk', 'Stellingmolen', 1785, 'Grondzeiler');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (80, 1, 'Grondzeiler', 'Windlust', 'Wipmolen', 1650, 'Historic');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (90, 2, 'Rotterdam', 'Grondzeiler', 'Bovenkruier', 1810, 'Named after type');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (100, 2, 'Breda', 'De Ster', 'grondzeiler', 1820, 'Lowercase type');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (110, 1, 'Zwolle', 'De Kroon', 'Grondzeiler Extra', 1830, 'Superstring type');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "built_year" FROM "mill" WHERE ("type" = 'Grondzeiler') ORDER BY name, mill.id NULLS LAST;

/*
Gold Result:
('Albatros', 1950)
('De Hoop', 1900)
('De Hoop', 1800)
('Molenzicht', 1850)
('Molenzicht', 1850)
('Zwaluw', 1750)
*/

-- Prediction Query
SELECT name, built_year FROM mill WHERE TYPE = 'Grondzeiler';

/*
Prediction Result:
('Albatros', 1950)
('De Hoop', 1900)
('Molenzicht', 1850)
('Molenzicht', 1850)
('De Hoop', 1800)
('Zwaluw', 1750)
*/