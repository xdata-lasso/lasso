-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1006, 'Daniel Wagner', 'agreement', 1007.5, 'option', 'decide');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1008, 'Abigail Shaffer', 'list', 1008.5, 'perform', 'fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM ship ORDER BY name, ship.ship_id NULLS LAST;

/*
Gold Result:
('Abigail Shaffer',)
('Daniel Wagner',)
*/

-- Prediction Query
SELECT name FROM ship ORDER BY built_year, CLASS, ship.ship_id NULLS LAST;

/*
Prediction Result:
('Daniel Wagner',)
('Abigail Shaffer',)
*/