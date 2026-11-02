-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Ship (Ship_ID, Name, Type, Built_Year, Class, Flag) VALUES (1, 'S1', 'T1', 2000.0, 'C1', 'F1');
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (1, 1, 'C1', '30', 'C1', NULL);
INSERT INTO captain (Captain_ID, Ship_ID, Name, age, Class, Rank) VALUES (2, 1, 'C2', '40', 'C1', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rank FROM (SELECT * FROM (SELECT * FROM (SELECT rank, COUNT(*) AS n FROM captain GROUP BY rank) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT rank FROM captain GROUP BY rank ORDER BY COUNT(*) DESC, rank NULLS LAST LIMIT 1;

/*
Prediction Result:
('A',)
*/