-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('1', 'Frank Lloyd Wright', 'American', 'Male');
INSERT INTO "bridge" ("id", "architect_id", "name", "location", "length_meters", "length_feet") VALUES (1, 1, 'Kolob Arch', 'Utah', 87.6, 287.4);
INSERT INTO "bridge" ("id", "architect_id", "name", "location", "length_meters", "length_feet") VALUES (2, NULL, 'Rainbow Bridge', 'Arizona', 88.4, 290.0);
INSERT INTO "bridge" ("id", "architect_id", "name", "location", "length_meters", "length_feet") VALUES (3, 1, 'Golden Gate Bridge', 'California', 2737.0, 8981.0);
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1, 1, 'New York', 'Kolob Arch', 'Windmill', 1900, 'None');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (2, 1, 'Nevada', 'Rainbow Bridge', 'Watermill', 1910, 'None');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "location" FROM "bridge" WHERE ("name" = 'Kolob Arch' OR "name" = 'Rainbow Bridge') ORDER BY LOCATION, bridge.id NULLS LAST;

/*
Gold Result:
('Arizona',)
('Utah',)
*/

-- Prediction Query
SELECT LOCATION FROM bridge WHERE name = 'Kolob Arch' OR name = 'Rainbow Bridge';

/*
Prediction Result:
('Utah',)
('Arizona',)
*/