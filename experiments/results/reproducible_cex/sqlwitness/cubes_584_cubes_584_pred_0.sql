-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (0, NULL, 'default1', NULL, 'default1', 'default1'), (1, 'default2', 'default2', 'default1', 'default2', 'default1');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (0, NULL, 'default2', NULL, 'default1', 'default2', 'default1'), (1, NULL, NULL, 'default1', NULL, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(injured) OVER () AS avg_injured_ FROM death ORDER BY avg_injured_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(injured) FROM death;

/*
Prediction Result:
(None,)
*/