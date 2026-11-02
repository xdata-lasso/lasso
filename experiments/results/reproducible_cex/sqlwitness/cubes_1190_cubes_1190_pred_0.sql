-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (1, NULL, 'default2', 1.0, NULL, NULL), (0, NULL, 'default1', 1.0, 'default1', NULL), (2, 'default1', 'default1', 0.0, 'default2', NULL), (3, 'default1', NULL, 1.0, 'default1', NULL), (4, 'default1', NULL, NULL, NULL, NULL), (5, NULL, 'default2', 1.0, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM ship ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(None,)
('default1',)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT name FROM ship ORDER BY built_year, CLASS, ship.ship_id NULLS LAST;

/*
Prediction Result:
('default1',)
('default1',)
(None,)
(None,)
('default1',)
(None,)
*/