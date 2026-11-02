-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1006, 'Donald Reid', 'his', 'commercial', 'hospital', 'hear');
INSERT INTO "battle" ("id", "name", "date", "bulgarian_commander", "latin_commander", "result") VALUES (1008, 'Renee Morales', 'attorney', 'development', 'white', 'yes');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (1007, 1006, 'Rebecca Henderson', 'money', 'away', '327 Nelson Route
Lake Mark, WI 07832', 'claim');
INSERT INTO "ship" ("id", "lost_in_battle", "name", "tonnage", "ship_type", "location", "disposition_of_ship") VALUES (1009, 1008, 'Derek Zuniga', 'raise', 'individual', '42388 Burgess Meadow Suite 532
Daviston, VI 14872', 'drop');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, tonnage FROM ship ORDER BY name, ship.id NULLS LAST;

/*
Gold Result:
('Derek Zuniga', 'raise')
('Rebecca Henderson', 'money')
*/

-- Prediction Query
SELECT name, tonnage FROM ship ORDER BY name DESC, ship.id NULLS LAST;

/*
Prediction Result:
('Rebecca Henderson', 'money')
('Derek Zuniga', 'raise')
*/