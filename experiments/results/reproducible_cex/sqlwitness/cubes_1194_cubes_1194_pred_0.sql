-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO captain (captain_id, ship_id, name, age, class, rank) VALUES (2, NULL, 'default2', NULL, NULL, NULL), (1, NULL, 'default1', 'default1', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CLASS FROM (SELECT CLASS, COUNT(*) AS n FROM captain GROUP BY CLASS) WHERE (n >= 2) ORDER BY CLASS;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CLASS FROM captain GROUP BY CLASS HAVING COUNT(*) > 2;

/*
Prediction Result:
*/