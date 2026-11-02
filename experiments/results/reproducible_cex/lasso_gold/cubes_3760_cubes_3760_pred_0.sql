-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1113, 'Michelle Moore', 'coach', 1117.5, 'today', 'cultural');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1114, 'Michelle Moore', 'art', 1126.5, 'today', 'cultural');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1115, 'Michelle Moore', 'movie', 1135.5, 'today', 'cultural');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1116, 'Michelle Moore', 'be', 1144.5, 'today', 'cultural');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1121, 'Michelle Moore', 'authority', 1125.5, 'training', 'easy');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1122, 'Michelle Moore', 'physical', 1134.5, 'training', 'easy');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1123, 'Michelle Moore', 'author', 1143.5, 'training', 'easy');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1124, 'Michelle Moore', 'Republican', 1152.5, 'training', 'easy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flag FROM (SELECT * FROM (SELECT * FROM (SELECT CLASS, flag, MAX(n) AS n FROM (SELECT ship_id, name, TYPE, built_year, CLASS, flag, COUNT(*) OVER () AS n FROM ship) GROUP BY CLASS, flag) ORDER BY CLASS DESC) LIMIT 1);

/*
Gold Result:
('easy',)
*/

-- Prediction Query
SELECT flag FROM ship GROUP BY flag ORDER BY COUNT(*) DESC, flag NULLS LAST LIMIT 1;

/*
Prediction Result:
('cultural',)
*/