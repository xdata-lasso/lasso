-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1016, 'Frederick Tate', 'arrive', 'drop', 'our', 'almost');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1017, 'Christy Porter', 'white', 'yes', 'term', 'under');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "result" FROM "battle" WHERE ("bulgarian_commander" <> 'Boril') ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
('Christy Porter', 'under')
('Frederick Tate', 'almost')
*/

-- Prediction Query
SELECT name, RESULT FROM battle WHERE bulgarian_commander <> 'Boril';

/*
Prediction Result:
('Frederick Tate', 'almost')
('Christy Porter', 'under')
*/