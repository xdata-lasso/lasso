-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1, 'Battle of Adrianople', '1205-04-14', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (2, 'Battle of Rusion', '1206-01-31', 'Kaloyan', 'Thierry de Termonde', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (3, 'Battle of Plovdiv', '1208-06-30', 'Boril', 'Baldwin I', 'Latin victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (4, 'Battle of Philippopolis', '1208-07-31', 'Boril', 'Henry of Flanders', 'Latin victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (5, 'Battle of Swapped', '1205-05-01', 'Baldwin I', 'Kaloyan', 'Draw');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (6, 'Ambush at Didymoteicho', '1206-09-20', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (1, 6, 'San Marco', '300', 'Galley', 'Propontis', 'Sunk');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (2, 6, 'Aquila', '250', 'Cog', 'Propontis', 'Captured');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (3, 2, 'Leone', '400', 'Galley', 'Thrace', 'Wrecked');
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (1, 1, 'Drowned in sinking', 45, 12);
INSERT INTO "death" ("id", "caused_by_ship_id", "note", "killed", "injured") VALUES (2, 2, 'Boarding action', 18, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "battle" WHERE ("bulgarian_commander" = 'Kaloyan' AND "latin_commander" = 'Baldwin I') ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
('Ambush at Didymoteicho',)
('Battle of Adrianople',)
*/

-- Prediction Query
SELECT name FROM battle WHERE bulgarian_commander = 'Kaloyan' AND latin_commander = 'Baldwin I';

/*
Prediction Result:
('Battle of Adrianople',)
('Ambush at Didymoteicho',)
*/