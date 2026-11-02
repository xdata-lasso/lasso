-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "captain" ("Captain_ID", "Rank") VALUES (1, 'A');
INSERT INTO "captain" ("Captain_ID", "Rank") VALUES (2, 'A');
INSERT INTO "captain" ("Captain_ID", "Rank") VALUES (3, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, rank FROM (SELECT rank, COUNT(*) AS n FROM captain GROUP BY rank) ORDER BY count___, rank NULLS LAST;

/*
Gold Result:
(1, 'B')
(2, 'A')
*/

-- Prediction Query
SELECT COUNT(*), rank FROM captain GROUP BY rank;

/*
Prediction Result:
(2, 'A')
(1, 'B')
*/