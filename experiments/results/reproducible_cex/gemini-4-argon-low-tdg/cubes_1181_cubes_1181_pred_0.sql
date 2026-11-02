-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'HMS Victory', 'Warship', 1765.0, 'First-rate', 'UK');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (2, 'USS Enterprise', 'Carrier', 1961.0, 'Enterprise', 'USA');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (3, 'Bismarck', 'Battleship', 1939.0, 'Bismarck', 'Germany');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (10, 1, 'Horatio Nelson', '47', 'A', 'Admiral');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (20, 3, 'Ernst Lindemann', '46', 'A', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (5, 3, 'Günther Lütjens', '52', 'A', 'Admiral');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (30, 2, 'Vincent DePoix', '45', 'B', 'Captain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM captain ORDER BY ship_id DESC, captain.captain_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Günther Lütjens',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age, captain.captain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Vincent DePoix',)
*/