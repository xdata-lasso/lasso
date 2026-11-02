-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483648, '5k5swwqcgs', '9n8', 874.871895, 'pgu7vfe4', 'hria2ypuzhs');

INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1, '5u', 'w6kl', 83.204633, '9', '00t5c4e');

-- Inserting into table: captain --
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1, -2147483648, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (2, 1, 'eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (3, 1, 'au2dwy', 'q13py', '78d99r', 'jsl');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (4, 1, '4', 'p5qi2rk', '9v', 'x58pz');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (5, 1, 'f8jegd21vy9u', 'j4hwbd', 'lph2gn', 'q');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (6, 1, 'qcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (7, -2147483648, 'k3zbily', 'kn6vc', '6ah', 'f8jswwl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT rank FROM (SELECT captain_id, name, ship_id, age, CLASS, rank, captain_id_other, captain_id AS maxn FROM (SELECT LHS.captain_id AS captain_id, LHS.name AS name, LHS.ship_id AS ship_id, LHS.age AS age, LHS.class AS CLASS, LHS.rank AS rank, RHS.captain_id AS captain_id_other FROM captain AS LHS INNER JOIN (SELECT captain_id, n, MAX(n) OVER () AS maxn FROM (SELECT captain_id, COUNT(*) AS n FROM captain GROUP BY captain_id)) AS RHS ON (LHS.captain_id = RHS.maxn AND LHS.ship_id = RHS.n))) ORDER BY rank;

/*
Gold Result:
*/

-- Prediction Query
SELECT rank FROM captain GROUP BY rank ORDER BY COUNT(*) DESC, rank NULLS LAST LIMIT 1;

/*
Prediction Result:
('dqv0gcb9',)
*/