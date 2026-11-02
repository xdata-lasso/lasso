-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1219, 'Duane Mendoza', 'talk', 1223.5, 'energy', 'keep');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1220, 'Vincent King', 'order', 1232.5, 'by', 'pick');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1221, 'Ashley Jones', 'fly', 1241.5, 'open', 'street');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1222, 'Kenneth Parks Jr.', 'bed', 1250.5, 'south', 'present');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1231, 'Michael Harrison', 'summer', 1235.5, 'off', 'when');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1232, 'Dwayne Campbell', 'world', 1244.5, 'down', 'exactly');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1233, 'Andrea Hall', 'decade', 1253.5, 'raise', 'the');
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1234, 'Rick Lawrence', 'large', 1262.5, 'church', 'change');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1227, 1219, 'Joseph Hayes', 'development', 'education', NULL);
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1228, 1219, 'Scott Branch', 'everything', 'consumer', NULL);
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1229, 1219, 'Marc Lynch', 'recent', 'old', NULL);
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1230, 1219, 'Theresa Clark', 'close', 'bad', NULL);
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1239, 1231, 'Christopher Parker', 'be', 'lay', 'enough');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1240, 1231, 'Laura Roberts', 'piece', 'simple', 'enough');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1241, 1231, 'Michael Lyons', 'among', 'future', 'enough');
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1242, 1231, 'Kathryn Snyder', 'visit', 'PM', 'enough');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rank FROM (SELECT * FROM (SELECT * FROM (SELECT rank, COUNT(*) AS n FROM captain GROUP BY rank) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT rank FROM captain GROUP BY rank ORDER BY COUNT(*) DESC, rank NULLS LAST LIMIT 1;

/*
Prediction Result:
('enough',)
*/