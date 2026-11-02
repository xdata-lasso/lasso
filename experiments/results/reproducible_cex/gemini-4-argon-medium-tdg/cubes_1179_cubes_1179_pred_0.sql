-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'USS Enterprise', 'Carrier', 1961.0, 'Nimitz', 'USA');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (2, 'HMS Victory', 'Ship of the line', 1765.0, 'First-rate', 'UK');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (10, 1, 'John Doe', '45', 'Class B', 'Admiral');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (5, 1, 'John Doe', '50', 'Class A', 'Captain');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (20, 2, 'Alice Smith', '38', 'Class C', 'Commander');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (15, 2, 'Bob Jones', '42', 'Class A', 'Lieutenant');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, CLASS, rank FROM captain ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
('Alice Smith', 'Class C', 'Commander')
('Bob Jones', 'Class A', 'Lieutenant')
('John Doe', 'Class A', 'Captain')
('John Doe', 'Class B', 'Admiral')
*/

-- Prediction Query
SELECT name, CLASS, rank FROM captain;

/*
Prediction Result:
('John Doe', 'Class A', 'Captain')
('John Doe', 'Class B', 'Admiral')
('Bob Jones', 'Class A', 'Lieutenant')
('Alice Smith', 'Class C', 'Commander')
*/