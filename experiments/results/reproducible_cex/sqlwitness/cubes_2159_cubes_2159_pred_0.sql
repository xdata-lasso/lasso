-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO architect (id, name, nationality, gender) VALUES ('default2', 'default1', 'Kolob Arch', 'Rainbow Bridge'), ('default1', 'default2', 'default2', 'default1'), ('Rainbow Bridge', 'default1', 'Rainbow Bridge', 'default2'), ('Kolob Arch', 'Rainbow Bridge', 'Rainbow Bridge', NULL), ('unique_4', 'Kolob Arch', 'Kolob Arch', 'Kolob Arch');
INSERT INTO bridge (id, architect_id, name, location, length_meters, length_feet) VALUES (0, NULL, 'Kolob Arch', 'default2', 0.0, 0.0), (1, 'unique_4', 'Kolob Arch', 'Rainbow Bridge', 0.0, 0.0), (2, 'default1', NULL, NULL, 1.0, NULL), (3, 'Kolob Arch', 'default2', 'Kolob Arch', NULL, 0.0), (4, 'default1', 'Rainbow Bridge', NULL, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "location" FROM "bridge" WHERE ("name" = 'Kolob Arch' OR "name" = 'Rainbow Bridge') ORDER BY LOCATION, bridge.id NULLS LAST;

/*
Gold Result:
(None,)
('Rainbow Bridge',)
('default2',)
*/

-- Prediction Query
SELECT LOCATION FROM bridge WHERE name = 'Kolob Arch' OR name = 'Rainbow Bridge';

/*
Prediction Result:
('default2',)
('Rainbow Bridge',)
(None,)
*/