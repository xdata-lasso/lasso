-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (0, 'default2', NULL, NULL, 'default2', NULL), (1, 'default2', NULL, 'default1', 'default2', 'default2'), (2, 'default2', 'default1', NULL, 'default1', 'default1');
INSERT INTO ship (id, lost_in_battle, name, tonnage, ship_type, location, disposition_of_ship) VALUES (1, 0, NULL, 'default2', 'default2', 'default2', 'default1'), (0, NULL, NULL, 'default1', NULL, 'default2', 'default2'), (2, NULL, 'default1', NULL, 'default1', 'default2', NULL), (3, 2, 'default1', NULL, 'default2', 'default2', NULL), (4, NULL, NULL, 'default2', NULL, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, tonnage FROM ship ORDER BY name, ship.id NULLS LAST;

/*
Gold Result:
(None, 'default1')
(None, 'default2')
(None, 'default2')
('default1', None)
('default1', None)
*/

-- Prediction Query
SELECT name, tonnage FROM ship ORDER BY name DESC, ship.id NULLS LAST;

/*
Prediction Result:
('default1', None)
('default1', None)
(None, 'default1')
(None, 'default2')
(None, 'default2')
*/