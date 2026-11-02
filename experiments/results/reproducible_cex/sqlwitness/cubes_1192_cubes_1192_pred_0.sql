-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (0, 'default1', 'default1', 0.0, 'default2', NULL), (1, 'default2', NULL, 1.0, NULL, 'default2'), (2, NULL, 'default1', 0.0, 'default2', NULL);
INSERT INTO captain (captain_id, ship_id, name, age, class, rank) VALUES (1, 0, 'default2', 'default1', 'default1', 'default1'), (2, 2, 'default1', 'default2', 'default2', 'default1'), (0, 1, 'default1', NULL, NULL, NULL), (3, 2, 'default1', NULL, 'default1', 'default1'), (4, 0, 'default2', NULL, 'default2', NULL), (5, NULL, 'default2', 'default1', 'default2', NULL), (6, 2, 'default2', 'default2', 'default1', 'default1'), (7, NULL, 'default2', 'default1', 'default2', 'default1'), (8, 2, 'default2', 'default1', NULL, 'default1'), (9, 0, 'default2', 'default2', 'default2', NULL), (10, 0, 'default2', NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.n AS n FROM ship AS LHS INNER JOIN (SELECT ship_id, COUNT(*) AS n FROM captain GROUP BY ship_id) AS RHS ON (LHS.ship_id = RHS.ship_id)) WHERE (n > 1) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT t1.name FROM ship AS t1 JOIN captain AS t2 ON t1.ship_id = t2.ship_id GROUP BY t2.ship_id HAVING COUNT(*) > 1;

/*
Prediction Result:
('default1',)
(None,)
*/