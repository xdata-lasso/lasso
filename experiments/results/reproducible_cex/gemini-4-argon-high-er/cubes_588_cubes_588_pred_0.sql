-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (1, 'B', '1205', 'Kaloyan', 'Baldwin', 'Victory');
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (2, 'A', '1206', 'Kaloyan', 'Henry', 'Victory');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, date FROM battle ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
('A', '1206')
('B', '1205')
*/

-- Prediction Query
SELECT name, date FROM battle;

/*
Prediction Result:
('B', '1205')
('A', '1206')
*/