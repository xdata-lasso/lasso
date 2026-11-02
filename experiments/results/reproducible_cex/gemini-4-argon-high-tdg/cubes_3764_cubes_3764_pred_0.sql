-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (0, 'SS Zero', 'Cargo', 1995.0, 'S_Zero', 'US');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'SS One', 'Cruiser', 2000.0, 'S_One', 'UK');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (2, 'SS Two', 'Frigate', 2005.0, 'S_Two', 'FR');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (0, 1, 'C0', '30', 'C_Zero', 'R_Zero');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (1, 1, 'C1', '35', 'C_Shared', 'R_One');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (2, 1, 'C2', '35', 'C_Shared', 'R_Two');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (3, 2, 'C3', '40', 'C_Shared', 'R_Two');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT rank FROM (SELECT captain_id, name, ship_id, age, CLASS, rank, captain_id_other, captain_id AS maxn FROM (SELECT LHS.captain_id AS captain_id, LHS.name AS name, LHS.ship_id AS ship_id, LHS.age AS age, LHS.class AS CLASS, LHS.rank AS rank, RHS.captain_id AS captain_id_other FROM captain AS LHS INNER JOIN (SELECT captain_id, n, MAX(n) OVER () AS maxn FROM (SELECT captain_id, COUNT(*) AS n FROM captain GROUP BY captain_id)) AS RHS ON (LHS.captain_id = RHS.maxn AND LHS.ship_id = RHS.n))) ORDER BY rank;

/*
Gold Result:
('R_One',)
*/

-- Prediction Query
SELECT rank FROM captain GROUP BY rank ORDER BY COUNT(*) DESC, rank NULLS LAST LIMIT 1;

/*
Prediction Result:
('R_Two',)
*/