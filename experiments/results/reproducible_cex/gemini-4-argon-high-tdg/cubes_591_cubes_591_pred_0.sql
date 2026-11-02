-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1, 'Battle of Rodosto', '1206', 'Kaloyan', 'Henry', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (2, 'Battle of Philippopolis', '1208', 'Boril', 'Henry', 'Latin victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (3, 'Battle of Adrianople', '1205', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (4, 'Battle of Adrianople', '1205', 'Ivan Asen II', 'Baldwin I', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (5, 'Battle of Serres', '1205', 'Kaloyan', 'Boniface', 'Bulgarian victory');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (10, 1, 'Dreadnought', '500', 'Galleon', 'Black Sea', 'Sunk');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (11, 1, 'Vanguard', '300', 'Brig', 'Black Sea', 'Captured');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (12, 2, 'San Marco', '400', 'Carrack', 'Aegean', 'Wrecked');
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (100, 10, 'Crew lost', 50, 12);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (101, 10, 'Officers lost', 5, 2);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (102, 12, 'Sinking casualties', 30, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "result" FROM "battle" WHERE ("bulgarian_commander" <> 'Boril') ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
('Battle of Adrianople', 'Bulgarian victory')
('Battle of Adrianople', 'Bulgarian victory')
('Battle of Rodosto', 'Bulgarian victory')
('Battle of Serres', 'Bulgarian victory')
*/

-- Prediction Query
SELECT name, RESULT FROM battle WHERE bulgarian_commander <> 'Boril';

/*
Prediction Result:
('Battle of Rodosto', 'Bulgarian victory')
('Battle of Adrianople', 'Bulgarian victory')
('Battle of Adrianople', 'Bulgarian victory')
('Battle of Serres', 'Bulgarian victory')
*/