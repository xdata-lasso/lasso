-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "captain" ("Captain_ID", "Name", "Rank") VALUES (1, 'B', 'Midshipman');
INSERT INTO "captain" ("Captain_ID", "Name", "Rank") VALUES (2, 'A', 'Lieutenant');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "captain" WHERE ("rank" = 'Midshipman' OR "rank" = 'Lieutenant') ORDER BY name, captain.captain_id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT name FROM captain WHERE rank = 'Midshipman' OR rank = 'Lieutenant';

/*
Prediction Result:
('B',)
('A',)
*/