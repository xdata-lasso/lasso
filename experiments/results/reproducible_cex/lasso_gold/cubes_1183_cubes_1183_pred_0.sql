-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1014, 'Ian Cooper', 'everything', 1015.5, 'surface', 'animal');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1016, 'Kimberly Dudley', 'human', 1017.5, 'bar', 'animal');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1018, 'Mark Mcclure', 'high', 1019.5, 'participant', 'sea');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, flag FROM (SELECT flag, COUNT(*) AS n FROM ship GROUP BY flag) ORDER BY count___, flag NULLS LAST;

/*
Gold Result:
(1, 'sea')
(2, 'animal')
*/

-- Prediction Query
SELECT COUNT(*), flag FROM ship GROUP BY flag;

/*
Prediction Result:
(2, 'animal')
(1, 'sea')
*/