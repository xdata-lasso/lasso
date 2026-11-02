-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483648, '5k5swwqcgs', '9n8', 1.0, 'shi_22066b', '4');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483647, 'gu7v', 'e4', 1.0, 'shi_22066b', 'hria2ypuzhs');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483646, 'rwbbp6luhvd', 'tti', 1.0, 'shi_22066b', 'bnp');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1, 'lhs_187941', 'lhs_433164', 1.0, 'lhs_b2223b', 'lhs_3b1e2a');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483644, 'mdpos', 'ie5', NULL, 'shi_22066b', 'nw6klf');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483643, 'a9000t5c4eci', 'gce376nium52', NULL, 'shi_22066b', 'zbuo4nrqrof');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483642, 'qyp5s5bbp0', '2eutliqa11r', NULL, 'shi_22066b', 'ytoo3o9');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483641, 'l7', 'klex14ji', 1.0, 'shi_22066b', NULL);

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483640, '7zwau2dwyr', '13pyu', 1.0, 'shi_22066b', NULL);

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483639, '8d99rljsl', 'b4yp5qi', 1.0, 'shi_22066b', NULL);

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483638, 'rkf9vqx5', NULL, 1.0, 'shi_22066b', 'pz0f8jegd');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483637, '1vy9uxj4', NULL, 1.0, 'shi_22066b', 'wb');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483636, 'v', NULL, 1.0, 'shi_22066b', 'ph2');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483635, 'nd', 'wnqcx', 1.0, NULL, '5hncprjtu0d');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483634, '79fjgq8', 'n2f3dqv0gcb9', 1.0, NULL, 'ozk3zbily');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483633, 'kn6vc', '6ah', 1.0, NULL, 'f8jswwl');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483632, NULL, '7xb72', 1.0, 'shi_22066b', 'xa');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483631, NULL, '7ryfdrz16n', 1.0, 'shi_22066b', 'jja');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483630, NULL, '5dh', 1.0, 'shi_22066b', 'ogrgjd8y');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483629, 't1afgog', 'itsj3', 1.0, 'shi_22066b', 'y');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483628, 'p1q430', 'jh3den8', 1.0, 'shi_22066b', 'c68x8vacx7');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483627, 'f', '5w1of7', 1.0, 'shi_22066b', 'pzo72ctdc');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483626, 'mfg62', '0v', 1.0, 'shi_22066b', 'q8qdjpe1');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483625, 'o22', '8507cvtjp', 1.0, 'shi_22066b', 'ttg6bnou5zi3');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483624, 'c4bfkfoac', '0', 1.0, 'shi_22066b', '7z2zezjo7wg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT flag FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.built_year AS built_year_other FROM ship AS LHS INNER JOIN (SELECT built_year, CLASS, COUNT(*) AS n FROM ship GROUP BY built_year, CLASS) AS RHS ON (LHS.ship_id = RHS.n AND LHS.class = RHS.class)) ORDER BY flag;

/*
Gold Result:
('lhs_3b1e2a',)
*/

-- Prediction Query
SELECT flag FROM ship GROUP BY flag ORDER BY COUNT(*) DESC, flag NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/