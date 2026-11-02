-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'Enterprise', 'Carrier', 1990.0, 'S_Class_1', 'US');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (2, 'Voyager', 'Cruiser', 1995.0, 'S_Class_1', 'US');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (3, 'Defiant', 'Escort', 2000.0, 'S_Class_2', 'UK');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (1, 1, 'Kirk', '40', 'C', 'Admiral');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (2, 2, 'Picard', '50', 'C', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (3, 3, 'Sisko', '45', 'C', 'Commander');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (4, 1, 'Janeway', '42', 'C', 'Admiral');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (5, 1, 'Archer', '38', 'A', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (6, 2, 'Pike', '48', 'A', 'Fleet Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (7, 3, 'Sulu', '39', 'A', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (8, 1, 'Spock', '41', 'D', 'Commander');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (9, 2, 'Riker', '35', 'B', 'Commander');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (10, 2, 'Riker', '35', 'B', 'Commander');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CLASS FROM (SELECT CLASS, COUNT(*) AS n FROM captain GROUP BY CLASS) WHERE (n >= 2) ORDER BY CLASS;

/*
Gold Result:
('A',)
('B',)
('C',)
*/

-- Prediction Query
SELECT CLASS FROM captain GROUP BY CLASS HAVING COUNT(*) > 2;

/*
Prediction Result:
('A',)
('C',)
*/