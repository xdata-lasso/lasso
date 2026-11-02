-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (2, 'default2', 'default1', 2.0, NULL, 'default2'), (0, 'default1', 'default2', 1.0, NULL, NULL);
INSERT INTO captain (captain_id, ship_id, name, age, class, rank) VALUES (2, NULL, 'default2', 'default2', 'default1', NULL), (1, 0, 'default2', 'default2', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS FROM (SELECT * FROM ship AS LHS WHERE NOT EXISTS(SELECT 1 FROM captain AS RHS WHERE (LHS.ship_id = RHS.ship_id))) ORDER BY name, CLASS NULLS LAST;

/*
Gold Result:
('default2', None)
*/

-- Prediction Query
SELECT name, CLASS FROM ship WHERE NOT ship_id IN (SELECT ship_id FROM captain);

/*
Prediction Result:
*/