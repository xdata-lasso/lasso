-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('purpose', 'Patrick Sanchez', 'Burundi', 'since');
INSERT INTO "bridge" ("id", "architect_id", "name", "location", "length_meters", "length_feet") VALUES (1001, 'purpose', 'Kolob Arch', '600 Jeffery Parkways
New Jamesside, MT 29394', 1003.5, 1005.5);
INSERT INTO "bridge" ("id", "architect_id", "name", "location", "length_meters", "length_feet") VALUES (1002, 'purpose', 'Rainbow Bridge', '26542 Susan Junction Apt. 161
Melanieview, AS 06196', 1014.5, 1018.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "location" FROM "bridge" WHERE ("name" = 'Kolob Arch' OR "name" = 'Rainbow Bridge') ORDER BY LOCATION, bridge.id NULLS LAST;

/*
Gold Result:
('26542 Susan Junction Apt. 161\nMelanieview, AS 06196',)
('600 Jeffery Parkways\nNew Jamesside, MT 29394',)
*/

-- Prediction Query
SELECT LOCATION FROM bridge WHERE name = 'Kolob Arch' OR name = 'Rainbow Bridge';

/*
Prediction Result:
('600 Jeffery Parkways\nNew Jamesside, MT 29394',)
('26542 Susan Junction Apt. 161\nMelanieview, AS 06196',)
*/