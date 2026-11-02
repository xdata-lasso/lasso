-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483648, '5k5swwqcgs', '9n8', 874.871895, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483647, 'pgu7vfe4', 'hria2ypuzhs', 663.049759, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483646, 'wbbp6luhvdlt', 'ilbnp', 787.938887, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1, 'lhs_c11ded', 'lhs_736383', 1.0, 'lhs_6811e5', 'lhs_b65b8a');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483644, 'dpos', 'ie5', 327.753528, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483643, 'w6kl', 'a9', 877.276439, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483642, '00t5c4ecigc', 'e376nium52', 816.814398, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483641, 'buo4nrq', 'rofqyp5s5b', NULL, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483640, 'p', '02eutliqa11r', NULL, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483639, 'ytoo3o9', 'l7', NULL, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483638, 'klex14ji', NULL, 598.409165, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483637, 'wau2dwy', NULL, 278.010437, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483636, '3pyu78d', NULL, 550.03107, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483635, 'ljsl0', '4', 884.000446, NULL, 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483634, 'p5qi2rkf9v', 'x58pz', 410.133844, NULL, 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483633, '8j', 'gd', 452.27611, NULL, 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483632, NULL, 'vy9uxj4', 124.573829, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483631, NULL, 'd', 328.40866, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483630, NULL, 'h2gn', 58.749749, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483629, 'wnqcx', '5hncprjtu0d', 395.809081, 'shi_d0a81b', NULL);

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483628, 'fjgq8n2f3', 'dqv0gcb98ozk', 463.845085, 'shi_d0a81b', NULL);

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483627, 'i', 'yrk', 615.222139, 'shi_d0a81b', NULL);

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483626, '6vck', 'ah0f8jsww', 176.824244, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483625, 'xb72fxa7r', 'fdrz16n', 130.468488, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483624, 'jai', 'dh5ogrgj', 54.980195, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483623, 'yzt1afgog', 'itsj3', 15.432127, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483622, 'xp1q430', 'jh3den8', 596.764785, 'shi_d0a81b', 'shi_911f1c');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483621, '6', 'x8vacx7af', 313.653498, 'shi_d0a81b', 'shi_911f1c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT built_year FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.flag AS flag_other FROM ship AS LHS INNER JOIN (SELECT CLASS, flag, COUNT(*) AS n FROM ship GROUP BY CLASS, flag) AS RHS ON (LHS.ship_id = RHS.n AND LHS.class = RHS.class)) ORDER BY built_year;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT built_year FROM ship GROUP BY built_year ORDER BY COUNT(*) DESC, built_year NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/