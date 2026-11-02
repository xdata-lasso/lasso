-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests string matching edge cases (case sensitivity, substring/LIKE mutants, leading/trailing spaces, empty strings) and NULL id in ORDER BY NULLS LAST
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1, 'Skirmish A', '1210-01-01', 'boril', 'Henry', 'Draw');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (2, 'Skirmish B', '1211-01-01', 'Boril II', 'Henry', 'Latin victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (3, 'Skirmish C', '1212-01-01', '', 'Henry', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (4, 'Skirmish D', '1213-01-01', 'Boril', 'Henry', 'Latin victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (NULL, 'Skirmish A', '1214-01-01', 'Kaloyan', 'Henry', 'Bulgarian victory');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "result" FROM "battle" WHERE ("bulgarian_commander" <> 'Boril') ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
('Skirmish A', 'Draw')
('Skirmish A', 'Bulgarian victory')
('Skirmish B', 'Latin victory')
('Skirmish C', 'Bulgarian victory')
*/

-- Prediction Query
SELECT name, RESULT FROM battle WHERE bulgarian_commander <> 'Boril';

/*
Prediction Result:
('Skirmish A', 'Draw')
('Skirmish B', 'Latin victory')
('Skirmish C', 'Bulgarian victory')
('Skirmish A', 'Bulgarian victory')
*/