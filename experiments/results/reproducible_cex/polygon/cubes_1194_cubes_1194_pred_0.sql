-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (7, 8, '11', '11', NULL, '11');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (6, NULL, '11', '11', NULL, '11');
INSERT INTO "Ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (8, '11', '11', 11, '11', '11');
INSERT INTO "Ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (9, '11', '11', 11, '11', '11');
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