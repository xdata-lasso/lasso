-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (10, 'Siege of Tarnovo', '1208-01-01', 'Kaloyan', 'Henry', 'Draw');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (5, 'Siege of Tarnovo', '1209-01-01', 'Ivan Asen II', 'Henry', 'Draw');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (2, 'Battle of Serres', '1205-06-01', 'Kaloyan', 'Boniface', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (8, NULL, '1210-01-01', 'Strez', 'Michael', 'Indecisive');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "result" FROM "battle" WHERE ("bulgarian_commander" <> 'Boril') ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
(None, 'Indecisive')
('Battle of Serres', 'Bulgarian victory')
('Siege of Tarnovo', 'Draw')
('Siege of Tarnovo', 'Draw')
*/

-- Prediction Query
SELECT name, RESULT FROM battle WHERE bulgarian_commander <> 'Boril';

/*
Prediction Result:
('Battle of Serres', 'Bulgarian victory')
('Siege of Tarnovo', 'Draw')
(None, 'Indecisive')
('Siege of Tarnovo', 'Draw')
*/