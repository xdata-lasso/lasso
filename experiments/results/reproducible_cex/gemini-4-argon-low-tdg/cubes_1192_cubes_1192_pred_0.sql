-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'ZeroCaptains', 'Cargo', 2000.0, 'A', 'US');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (2, 'OneCaptain', 'Tanker', 2005.0, 'B', 'UK');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (3, 'TwoCaptains', 'Cruiser', 2010.0, 'C', 'FR');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (4, 'ThreeCaptains', 'Ferry', 2015.0, 'A', 'DE');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (101, 2, 'CapA', '40', 'B', 'Major');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (102, 3, 'CapB', '45', 'X', 'Admiral');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (103, 3, 'CapC', '50', 'Y', 'Commander');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (104, 4, 'CapD', '35', 'Z', 'Lieutenant');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (105, 4, 'CapE', '38', 'Z', 'Lieutenant');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (106, 4, 'CapF', '42', 'Z', 'Captain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.n AS n FROM ship AS LHS INNER JOIN (SELECT ship_id, COUNT(*) AS n FROM captain GROUP BY ship_id) AS RHS ON (LHS.ship_id = RHS.ship_id)) WHERE (n > 1) ORDER BY name;

/*
Gold Result:
('ThreeCaptains',)
('TwoCaptains',)
*/

-- Prediction Query
SELECT t1.name FROM ship AS t1 JOIN captain AS t2 ON t1.ship_id = t2.ship_id GROUP BY t2.ship_id HAVING COUNT(*) > 1;

/*
Prediction Result:
('TwoCaptains',)
('ThreeCaptains',)
*/