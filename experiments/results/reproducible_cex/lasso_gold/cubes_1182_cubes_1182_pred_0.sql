-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1001, 'Allison Hill', 'dog', 1002.5, 'chair', 'since');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1003, 1001, 'Patrick Gardner', 'early', 'play', 'Midshipman');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1004, 1001, 'Amanda Davis', 'mouth', 'agreement', 'Lieutenant');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "captain" WHERE ("rank" = 'Midshipman' OR "rank" = 'Lieutenant') ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
('Amanda Davis',)
('Patrick Gardner',)
*/

-- Prediction Query
SELECT name FROM captain WHERE rank = 'Midshipman' OR rank = 'Lieutenant';

/*
Prediction Result:
('Patrick Gardner',)
('Amanda Davis',)
*/