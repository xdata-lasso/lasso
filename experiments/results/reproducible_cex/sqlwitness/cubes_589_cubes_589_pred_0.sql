-- Schema DDL
CREATE TABLE "battle" ("id" INTEGER PRIMARY KEY, "name" TEXT, "date" TEXT, "bulgarian_commander" TEXT, "latin_commander" TEXT, "result" TEXT);

CREATE TABLE "ship" ("id" INTEGER PRIMARY KEY, "lost_in_battle" INTEGER, "name" TEXT, "tonnage" TEXT, "ship_type" TEXT, "location" TEXT, "disposition_of_ship" TEXT, FOREIGN KEY ("lost_in_battle") REFERENCES "battle" ("id"));

CREATE TABLE "death" ("id" INTEGER PRIMARY KEY, "caused_by_ship_id" INTEGER, "note" TEXT, "killed" INTEGER, "injured" INTEGER, FOREIGN KEY ("caused_by_ship_id") REFERENCES "ship" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO battle (id, name, date, bulgarian_commander, latin_commander, result) VALUES (1, NULL, 'default2', NULL, 'default2', 'default2'), (0, 'Baldwin I', 'Baldwin I', 'Baldwin I', NULL, 'default2'), (2, 'default2', 'Kaloyan', 'default2', 'default2', 'Baldwin I'), (3, 'Kaloyan', 'Kaloyan', 'Kaloyan', 'Kaloyan', NULL), (4, 'Baldwin I', 'Kaloyan', NULL, 'default2', 'Kaloyan'), (5, 'Kaloyan', 'Kaloyan', 'Kaloyan', 'Baldwin I', 'default1'), (6, 'Baldwin I', 'default2', 'default2', 'default2', 'Baldwin I'), (7, 'default1', 'Kaloyan', 'Baldwin I', NULL, 'default2'), (8, NULL, NULL, 'Kaloyan', 'Baldwin I', NULL), (9, 'default2', 'Baldwin I', 'default2', 'default2', 'default2'), (10, 'Baldwin I', 'default2', 'default2', 'default2', 'Baldwin I'), (11, 'default2', 'default1', NULL, 'Baldwin I', 'Baldwin I'), (12, 'Kaloyan', NULL, NULL, 'Kaloyan', 'Kaloyan'), (13, 'Baldwin I', 'Baldwin I', 'Kaloyan', 'default1', 'Baldwin I'), (14, NULL, 'default2', 'Baldwin I', 'Baldwin I', 'default2'), (15, 'Baldwin I', NULL, 'default2', 'Baldwin I', 'default1'), (16, 'default2', NULL, 'default1', NULL, NULL), (17, 'Kaloyan', 'default1', 'default2', 'default2', 'default1'), (18, NULL, NULL, 'Kaloyan', 'default2', 'default2'), (19, 'Baldwin I', NULL, NULL, 'Baldwin I', NULL), (20, 'default2', 'default2', 'default1', 'Kaloyan', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "battle" WHERE ("bulgarian_commander" = 'Kaloyan' AND "latin_commander" = 'Baldwin I') ORDER BY name, battle.id NULLS LAST;

/*
Gold Result:
(None,)
('Kaloyan',)
*/

-- Prediction Query
SELECT name FROM battle WHERE bulgarian_commander = 'Kaloyan' AND latin_commander = 'Baldwin I';

/*
Prediction Result:
('Kaloyan',)
(None,)
*/