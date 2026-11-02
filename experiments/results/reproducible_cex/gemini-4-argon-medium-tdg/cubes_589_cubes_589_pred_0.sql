-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate "name" values (catches DISTINCT mutations), ORDER BY "name" (ASC vs DESC), NULLs in "name", and tie-breaking with "id".
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (10, 'Zeta Battle', '1205-05-01', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (20, 'Alpha Battle', '1205-04-01', 'Kaloyan', 'Baldwin I', 'Latin victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (5, 'Alpha Battle', '1205-04-02', 'Kaloyan', 'Baldwin I', 'Bulgarian victory');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (15, NULL, '1205-04-03', 'Kaloyan', 'Baldwin I', 'Draw');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "battle" WHERE ("bulgarian_commander" = 'Kaloyan' AND "latin_commander" = 'Baldwin I') ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Battle',)
('Alpha Battle',)
('Zeta Battle',)
*/

-- Prediction Query
SELECT name FROM battle WHERE bulgarian_commander = 'Kaloyan' AND latin_commander = 'Baldwin I';

/*
Prediction Result:
('Alpha Battle',)
('Zeta Battle',)
(None,)
('Alpha Battle',)
*/