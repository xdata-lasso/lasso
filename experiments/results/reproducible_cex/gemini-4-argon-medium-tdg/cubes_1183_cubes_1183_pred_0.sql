-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, COUNT(*), primary sorting by count ASC, and secondary sorting by flag ASC
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Endeavour', 'Bark', 1764.0, 'First', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'Victory', 'Ship of the line', 1765.0, 'First', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'Mayflower', 'Fluyt', 1609.0, 'Second', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (4, 'Constitution', 'Frigate', 1797.0, 'First', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (5, 'Enterprise', 'Carrier', 1936.0, 'First', 'USA');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (6, 'Bismarck', 'Battleship', 1939.0, 'First', 'Germany');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (7, 'Yamato', 'Battleship', 1940.0, 'First', 'Japan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, flag FROM (SELECT flag, COUNT(*) AS n FROM ship GROUP BY flag) ORDER BY count___, flag NULLS LAST;

/*
Gold Result:
(1, 'Germany')
(1, 'Japan')
(2, 'USA')
(3, 'UK')
*/

-- Prediction Query
SELECT COUNT(*), flag FROM ship GROUP BY flag;

/*
Prediction Result:
(1, 'Germany')
(1, 'Japan')
(3, 'UK')
(2, 'USA')
*/