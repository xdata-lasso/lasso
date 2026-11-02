-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (0, 'default1', 'default2', 'default2', 'default2', 'default2'), (1, 'default1', NULL, NULL, NULL, 'default2'), (2, NULL, NULL, 'default1', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, date FROM battle ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
(None, None)
('default1', 'default2')
('default1', None)
*/

-- Prediction Query
SELECT name, date FROM battle;

/*
Prediction Result:
('default1', 'default2')
('default1', None)
(None, None)
*/