-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (10, 'Voyager', 'Cruiser', 1995.0, 'A', 'US');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (20, 'Defiant', 'Escort', 2005.0, 'B', 'UK');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (30, 'Zulu', 'Battleship', 1980.0, 'C', 'FR');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (40, 'Alpha', 'Destroyer', 2015.0, 'D', 'DE');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (50, 'Bravo', 'Frigate', 2000.0, 'E', 'JP');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (10, 20, 'Sisko', '42', 'X', 'Commander');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (11, 30, 'Picard', '59', 'Y', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (20, 30, 'Riker', '40', 'Z', 'Commander');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (21, 40, 'Janeway', '45', 'W', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (22, 40, 'Chakotay', '47', 'V', 'Commander');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (23, 40, 'Tuvok', '100', 'U', 'Lieutenant');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (24, 50, 'Archer', '50', 'T', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (25, 50, 'TPol', '65', 'S', 'Commander');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (26, 50, 'Tucker', '35', 'R', 'Commander');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (27, 50, 'Reed', '34', 'Q', 'Lieutenant');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.n AS n FROM ship AS LHS INNER JOIN (SELECT ship_id, COUNT(*) AS n FROM captain GROUP BY ship_id) AS RHS ON (LHS.ship_id = RHS.ship_id)) WHERE (n > 1) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Bravo',)
('Zulu',)
*/

-- Prediction Query
SELECT t1.name FROM ship AS t1 JOIN captain AS t2 ON t1.ship_id = t2.ship_id GROUP BY t2.ship_id HAVING COUNT(*) > 1;

/*
Prediction Result:
('Zulu',)
('Alpha',)
('Bravo',)
*/