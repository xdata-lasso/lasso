-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1, 'shi_4b03dc', 'shi_2cd385', 1.0, 'shi_04f2fa', 'shi_b466d3');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483647, 'shi_3c4e2f', 'shi_b5ca61', 1.0, 'shi_b67a84', 'shi_46a635');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483646, '5k5swwqcgs', '9n8', 874.871895, 'pgu7vfe4', 'q_3_e6c3e4');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483645, 'hria2ypuzhs', 'rwbbp6luhvd', 179.378884, 'ilbnp', 'q_3_e6c3e4');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (2, 'mdpos', 'ie5', 327.753528, 'w6kl', 'a9');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (3, '00t5c4e', 'cigce376nium', 779.28645, '52zbuo4nrq', 'rofqyp5s5b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT flag FROM (SELECT * FROM (SELECT * FROM (SELECT CLASS, flag, MAX(n) AS n FROM (SELECT ship_id, name, TYPE, built_year, CLASS, flag, COUNT(*) OVER () AS n FROM ship) GROUP BY CLASS, flag) ORDER BY CLASS DESC) LIMIT 1);

/*
Gold Result:
('a9',)
*/

-- Prediction Query
SELECT flag FROM ship GROUP BY flag ORDER BY COUNT(*) DESC, flag NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_3_e6c3e4',)
*/