-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO architect (id, name, nationality, gender) VALUES ('1', 'Zaha Hadid', 'British', 'female');
INSERT INTO mill (id, architect_id, location, name, type, built_year, notes) VALUES (1, 1, 'London', 'Apex Mill', 'Steam', 1900, 'Active');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(length_feet) OVER () AS avg_length_feet_ FROM bridge ORDER BY avg_length_feet_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(length_feet) FROM bridge;

/*
Prediction Result:
(None,)
*/