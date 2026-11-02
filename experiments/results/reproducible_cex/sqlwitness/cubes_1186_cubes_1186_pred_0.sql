-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ship (ship_id, name, type, built_year, class, flag) VALUES (1, 'default1', 'default1', 0.0, 'Panama', 'Malta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "type" FROM "ship" WHERE ("flag" <> 'Panama' OR "flag" = 'Malta') ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT TYPE FROM ship WHERE flag = 'Panama' INTERSECT SELECT TYPE FROM ship WHERE flag = 'Malta';

/*
Prediction Result:
*/