-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1019, 'Carla Kelly', 'religious', 1020.5, 'example', 'science');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1022, 'Joel Nelson', 'wish', 1023.5, 'push', 'rise');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1021, 1019, 'Maria Lynch', 'Congress', 'none', NULL);
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1024, 1022, 'Melinda Cameron', 'stand', 'Third-rate ship of the line', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rank" FROM (SELECT * FROM "captain" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "captain" WHERE ("class" = 'Third-rate ship of the line')) AS RHS WHERE (LHS.rank = RHS.rank))) ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT rank FROM captain EXCEPT SELECT rank FROM captain WHERE CLASS = 'Third-rate ship of the line';

/*
Prediction Result:
*/