-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests SELECT DISTINCT vs SELECT ALL (duplicate names), and ORDER BY direction (ASC vs DESC) and tie-breaking.
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (10, 'Skirmish of Thrace', 'May 1205', 'Kaloyan', 'Baldwin I', 'Draw');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (5, 'Skirmish of Thrace', 'April 1205', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (20, 'Ambush at Rusion', 'Jan 1206', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1, 'Zeta Conflict', 'Feb 1206', 'Kaloyan', 'Baldwin I', 'Latin victory');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "battle" WHERE ("bulgarian_commander" = 'Kaloyan' AND "latin_commander" = 'Baldwin I') ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
('Ambush at Rusion',)
('Skirmish of Thrace',)
('Skirmish of Thrace',)
('Zeta Conflict',)
*/

-- Prediction Query
SELECT name FROM battle WHERE bulgarian_commander = 'Kaloyan' AND latin_commander = 'Baldwin I';

/*
Prediction Result:
('Zeta Conflict',)
('Skirmish of Thrace',)
('Skirmish of Thrace',)
('Ambush at Rusion',)
*/