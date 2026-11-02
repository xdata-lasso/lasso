-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO architect (id, name, nationality, gender) VALUES ('1', 'John Doe', 'USA', 'Male');
INSERT INTO bridge (id, architect_id, name, location, length_meters, length_feet) VALUES (1, '1', 'Kolob Arch', 'Zion', 87.6, 287.4);
INSERT INTO bridge (id, architect_id, name, location, length_meters, length_feet) VALUES (2, '1', 'Rainbow Bridge', 'Arizona', 88.0, 290.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "location" FROM "bridge" WHERE ("name" = 'Kolob Arch' OR "name" = 'Rainbow Bridge') ORDER BY LOCATION, bridge.id NULLS LAST;

/*
Gold Result:
('Arizona',)
('Zion',)
*/

-- Prediction Query
SELECT LOCATION FROM bridge WHERE name = 'Kolob Arch' OR name = 'Rainbow Bridge';

/*
Prediction Result:
('Zion',)
('Arizona',)
*/