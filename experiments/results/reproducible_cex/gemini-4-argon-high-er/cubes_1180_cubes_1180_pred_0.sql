-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'ShipA', 'TypeA', 2000.0, 'ClassA', 'FlagA');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (1, 1, 'Alice', '30', 'Class1', 'Rank1');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (2, 1, 'Bob', '40', 'Class1', 'Rank1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM captain ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age DESC, captain.captain_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Alice',)
*/