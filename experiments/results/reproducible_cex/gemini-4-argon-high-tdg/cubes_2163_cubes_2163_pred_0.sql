-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO architect (id, name, nationality, gender) VALUES ('1', 'Jan Van Der Berg', 'Belgian', 'male');
INSERT INTO architect (id, name, nationality, gender) VALUES ('2', 'Marie Dubois', 'French', 'female');
INSERT INTO bridge (id, architect_id, name, location, length_meters, length_feet) VALUES (1, 1, 'Pont de Donceel', 'Donceel', 45.0, 147.6);
INSERT INTO bridge (id, architect_id, name, location, length_meters, length_feet) VALUES (2, 2, 'Pont de Liege', 'Liege', 120.5, 395.3);
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (1, 1, 'Donceel', 'Moulin de Donceel', 'Grondzeiler', 1820, 'Historical mill');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (2, 1, 'Antwerp', 'Zuidmolen', 'Standerdmolen', 1750, 'Restored');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (3, 2, 'Wavre', 'Bovenmolen', 'Bergmolen', 1890, 'Active');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (4, 2, 'Gent', 'Bovenmolen', 'Watermill', 1810, 'Duplicate name test');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (5, 1, 'Bruges', 'Middenmolen', 'Standerdmolen', 1785, 'Museum');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "mill" WHERE ("location" <> 'Donceel') ORDER BY name, mill.id NULLS LAST;

/*
Gold Result:
('Bovenmolen',)
('Bovenmolen',)
('Middenmolen',)
('Zuidmolen',)
*/

-- Prediction Query
SELECT name FROM mill WHERE LOCATION <> 'Donceel';

/*
Prediction Result:
('Zuidmolen',)
('Bovenmolen',)
('Bovenmolen',)
('Middenmolen',)
*/