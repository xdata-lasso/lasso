-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ship --
INSERT INTO "ship" ("ship_id", "name", "type", "built_year", "class", "flag") VALUES (1, '5k5swwqcgs', '9n8', 874.871895, 'pgu7vfe4', 'hria2ypuzhs');

-- Inserting into table: captain --
INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (1, 1, 'cap_b30c6c', 'cap_d4b013', 'cap_affb14', 'cap_e7b891');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483647, 1, 'cap_383096', 'cap_59a619', 'cap_cf4a70', 'cap_28923e');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483646, 1, 'q_1_c31f7f', 'wbbp6luhvdlt', 'ilbnp', 'mdpos');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-2147483645, 1, 'q_1_c31f7f', 'e5u', 'w6kl', 'a9');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (-1, 1, '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b');

INSERT INTO "captain" ("captain_id", "ship_id", "name", "age", "class", "rank") VALUES (0, 1, 'p', '02eutliqa11r', 'ytoo3o9', 'l7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM captain ORDER BY ship_id DESC, captain.captain_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('cap_383096',)
*/

-- Prediction Query
SELECT name FROM captain ORDER BY age, captain.captain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('p',)
*/