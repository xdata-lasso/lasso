-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (-2147483648, '5k5swwqcgs', '9n8', 874.871895, 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: captain --
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483648, -2147483648, 'rwbbp6luhvd', 'tti', 'bnp', 'cap_f925f5');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483647, -2147483648, 'dpos', 'ie5', 'Third-rate ship of the line', 'cap_fdeb91');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (2, -2147483648, 'w6kl', 'a9', '00t5c4e', 'cap_f925f5');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (3, -2147483648, 'gce', '76nium52', 'zbuo4nrqrof', 'cap_f925f5');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483646, -2147483648, 'p5s5bbp', '02eutliqa11r', 'Third-rate ship of the line', 'cap_fdeb91');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483643, -2147483648, 'ytoo3o9hl7', 'klex14ji', 'Third-rate ship of the line', 'cap_b7d648');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483642, -2147483648, 'au2dwy', 'q13py', '78d99r', 'cap_f925f5');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483641, -2147483648, 'sl0', '4', 'p5qi2rk', 'cap_7aa174');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483640, -2147483648, 'x58pz0f8je', 'd2', 'vy9uxj4', 'cap_f925f5');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483639, -2147483648, 'bdvlph', 'gndqwnqc', 'cap_eae0e1', 'cap_fdeb91');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483638, -2147483648, '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', NULL);

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483637, -2147483648, 'k3zbily', 'kn6vc', 'Third-rate ship of the line', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rank" FROM (SELECT * FROM "captain" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "captain" WHERE ("class" = 'Third-rate ship of the line')) AS RHS WHERE (LHS.rank = RHS.rank))) ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('cap_7aa174',)
('cap_f925f5',)
('cap_f925f5',)
('cap_f925f5',)
('cap_f925f5',)
('cap_f925f5',)
*/

-- Prediction Query
SELECT rank FROM captain EXCEPT SELECT rank FROM captain WHERE CLASS = 'Third-rate ship of the line';

/*
Prediction Result:
('cap_7aa174',)
('cap_f925f5',)
*/