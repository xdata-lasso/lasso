-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO captain (captain_id, ship_id, name, age, class, rank) VALUES (1, NULL, 'default2', NULL, 'Cutter', 'Cutter');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "rank" FROM "captain" WHERE ("class" = 'Cutter' OR "class" = 'Armed schooner') ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
('Cutter',)
*/

-- Prediction Query
SELECT rank FROM captain WHERE CLASS = 'Cutter' INTERSECT SELECT rank FROM captain WHERE CLASS = 'Armed schooner';

/*
Prediction Result:
*/