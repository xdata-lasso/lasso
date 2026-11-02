-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (10, 'Poseidon', 'Cargo', 1998.0, 'Heavy', 'Panama');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (20, 'Neptune', 'Tanker', 2005.0, 'Medium', 'Liberia');
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (30, 'Triton', 'Passenger', 2012.0, 'Light', 'Bahamas');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (1, 10, 'Zack', '25', 'A', '1st');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (2, 20, 'Maverick', '35', 'B', '2nd');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (3, 10, 'Alice', '45', 'C', '3rd');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (4, 20, 'Maverick', '55', 'D', '4th');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM captain ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Maverick',)
('Maverick',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age DESC, captain.captain_id NULLS LAST;

/*
Prediction Result:
('Maverick',)
('Alice',)
('Maverick',)
('Zack',)
*/