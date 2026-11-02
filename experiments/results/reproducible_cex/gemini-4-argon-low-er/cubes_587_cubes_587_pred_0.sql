-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("id", "name", "tonnage") VALUES (1, 'A', '100');
INSERT INTO "ship" ("id", "name", "tonnage") VALUES (2, 'B', '200');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, tonnage FROM ship ORDER BY name, ship.id NULLS LAST;

/*
Gold Result:
('A', '100')
('B', '200')
*/

-- Prediction Query
SELECT name, tonnage FROM ship ORDER BY name DESC, ship.id NULLS LAST;

/*
Prediction Result:
('B', '200')
('A', '100')
*/