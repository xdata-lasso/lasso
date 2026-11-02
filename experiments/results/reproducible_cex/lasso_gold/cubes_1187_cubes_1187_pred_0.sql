-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1040, 'Aaron Bowen', 'serve', 1041.5, 'everyone', 'month');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1043, 'Lisa Hernandez', 'sound', 1044.5, 'color', 'notice');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1046, 'Timothy Koch', 'theory', 1047.5, 'surface', 'food');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1042, 1040, 'Katie Rodriguez', 'process', 'fire', 'mention');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1045, 1043, 'Tammy Sellers', 'place', 'game', 'mention');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1048, 1046, 'David Bradley', 'bar', 'bed', 'thought');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, rank FROM (SELECT rank, COUNT(*) AS n FROM captain GROUP BY rank) ORDER BY count___, rank NULLS LAST;

/*
Gold Result:
(1, 'thought')
(2, 'mention')
*/

-- Prediction Query
SELECT COUNT(*), rank FROM captain GROUP BY rank;

/*
Prediction Result:
(2, 'mention')
(1, 'thought')
*/