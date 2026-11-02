-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'Alpha', 'Cargo', 2005.0, 'A_Class', 'USA');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (2, 'Beta', 'Cargo', 2010.0, 'A_Class', 'USA');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (3, 'Gamma', 'Cargo', 2012.0, 'A_Class', 'USA');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (4, 'Delta', 'Tanker', 2000.0, 'M_Class', 'UK');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (5, 'Epsilon', 'Tanker', 2001.0, 'M_Class', 'UK');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (6, 'Zeta', 'Ferry', 1995.0, 'Z_Class', 'Panama');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (1, 1, 'Smith', '45', 'Z_Class', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (2, 2, 'Jones', '50', 'A_Class', 'Commander');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flag FROM (SELECT * FROM (SELECT * FROM (SELECT CLASS, flag, MAX(n) AS n FROM (SELECT ship_id, name, TYPE, built_year, CLASS, flag, COUNT(*) OVER () AS n FROM ship) GROUP BY CLASS, flag) ORDER BY CLASS DESC) LIMIT 1);

/*
Gold Result:
('Panama',)
*/

-- Prediction Query
SELECT flag FROM ship GROUP BY flag ORDER BY COUNT(*) DESC, flag NULLS LAST LIMIT 1;

/*
Prediction Result:
('USA',)
*/