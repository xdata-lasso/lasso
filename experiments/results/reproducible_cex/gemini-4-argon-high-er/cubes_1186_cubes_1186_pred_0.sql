-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Ship A', 'Cargo', 2000.0, 'Class A', 'Malta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "type" FROM "ship" WHERE ("flag" <> 'Panama' OR "flag" = 'Malta') ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('Cargo',)
*/

-- Prediction Query
SELECT TYPE FROM ship WHERE flag = 'Panama' INTERSECT SELECT TYPE FROM ship WHERE flag = 'Malta';

/*
Prediction Result:
*/