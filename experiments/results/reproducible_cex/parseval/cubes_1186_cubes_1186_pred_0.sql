-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1, '5k5swwqcgs', 'shi_d9767e', 171.746906, 'n8c4pgu7v', 'I');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (3, 'e4', 'shi_d9767e', 779.409124, 'hria2ypuzhs', 'I');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (2, 'rwbbp6luhvd', 'tti', 182.319045, 'nprmdposii', 'Malta');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (4, '5k5swwqcgs', '9n8', 874.871895, 'pgu7vfe4', 'Panama');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (5, '5k5swwqcgs', '9n8', 874.871895, 'pgu7vfe4', NULL);

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (6, 'hria2ypuzhs', 'rwbbp6luhvd', 179.378884, 'ilbnp', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "type" FROM "ship" WHERE ("flag" <> 'Panama' OR "flag" = 'Malta') ORDER BY TYPE, ship.ship_id NULLS LAST;

/*
Gold Result:
('shi_d9767e',)
('shi_d9767e',)
('tti',)
*/

-- Prediction Query
SELECT TYPE FROM ship WHERE flag = 'Panama' INTERSECT SELECT TYPE FROM ship WHERE flag = 'Malta';

/*
Prediction Result:
*/