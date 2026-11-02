-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483648, '5k5swwqcgs', '9n8', 874.871895, 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: captain --
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (2, -2147483648, 'rwbbp6luhvd', 'tti', 'Cutter', 'cap_528897');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (3, -2147483648, 'n', 'rmdp', 'Cutter', 'cap_528897');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (4, -2147483648, 'unw6klfa', '9000t5c4ec', 'Armed schooner', 'gce');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (5, -2147483648, '5sw', 'qcgsk9', 'cap_2bb22e', '8c4p');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (6, -2147483648, 'u7vfe4hria2y', 'uzhs', NULL, 'rwbbp6luhvd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "rank" FROM "captain" WHERE ("class" = 'Cutter' OR "class" = 'Armed schooner') ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
('cap_528897',)
('gce',)
*/

-- Prediction Query
SELECT rank FROM captain WHERE CLASS = 'Cutter' INTERSECT SELECT rank FROM captain WHERE CLASS = 'Armed schooner';

/*
Prediction Result:
*/