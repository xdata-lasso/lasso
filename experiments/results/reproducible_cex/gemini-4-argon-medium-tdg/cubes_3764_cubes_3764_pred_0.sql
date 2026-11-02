-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'Nautilus', 'Submarine', 1980.0, 'S', 'FR');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (2, 'Bismarck', 'Battleship', 1940.0, 'B', 'DE');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (1, 2, 'Miller', '40', 'C1', 'Lieutenant');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (2, 1, 'Davis', '35', 'C2', 'Ensign');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (3, 2, 'Wilson', '55', 'C3', 'Captain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT rank FROM (SELECT captain_id, name, ship_id, age, CLASS, rank, captain_id_other, captain_id AS maxn FROM (SELECT LHS.captain_id AS captain_id, LHS.name AS name, LHS.ship_id AS ship_id, LHS.age AS age, LHS.class AS CLASS, LHS.rank AS rank, RHS.captain_id AS captain_id_other FROM captain AS LHS INNER JOIN (SELECT captain_id, n, MAX(n) OVER () AS maxn FROM (SELECT captain_id, COUNT(*) AS n FROM captain GROUP BY captain_id)) AS RHS ON (LHS.captain_id = RHS.maxn AND LHS.ship_id = RHS.n))) ORDER BY rank;

/*
Gold Result:
*/

-- Prediction Query
SELECT rank FROM captain GROUP BY rank ORDER BY COUNT(*) DESC, rank NULLS LAST LIMIT 1;

/*
Prediction Result:
('Captain',)
*/