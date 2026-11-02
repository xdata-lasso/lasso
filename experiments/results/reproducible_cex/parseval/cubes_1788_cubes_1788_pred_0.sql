-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: branch --
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483648, '5k5swwqcgs', 'bra_a0edbe', '9n8', '4', 'gu7v');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483647, 'e4', 'bra_a0edbe', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483646, 'bnp', 'bra_a0edbe', 'mdpos', 'ie5', 'nw6klf');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (2, 'a9000t5c4eci', 'bra_a0edbe', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (3, '2eutliqa11r', 'bra_a0edbe', 'ytoo3o9', 'l7', 'klex14ji');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483645, '7zwau2dwyr', 'bra_a0edbe', '13pyu', '8d99rljsl', 'b4yp5qi');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483642, 'rkf9vqx5', 'bra_a0edbe', 'pz0f8jegd', '1vy9uxj4', 'wb');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483641, 'v', 'bra_a0edbe', 'ph2', 'nd', 'wnqcx');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483640, '5hncprjtu0d', 'bra_a0edbe', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483639, 'kn6vc', 'bra_a0edbe', '6ah', 'f8jswwl', '7xb72');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483638, 'xa', 'bra_a0edbe', '7ryfdrz16n', 'jja', '5dh');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483637, 'ogrgjd8y', 'bra_a0edbe', 't1afgog', 'itsj3', 'y');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483636, 'p1q430', NULL, 'jh3den8', 'c68x8vacx7', 'f');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483635, '5w1of7', NULL, 'pzo72ctdc', 'mfg62', '0v');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483634, 'q8qdjpe1', NULL, 'o22', '8507cvtjp', 'ttg6bnou5zi3');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (4, 'c4bfkfoac', 'bra_ce76b6', '0', '7z2zezjo7wg', 'd5ysxc');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (5, 'r0oz', 'bra_ce76b6', 'dgj5i', 'lq5lnpim', 'k58qs27p');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483631, '5k5swwqcgs', 'bra_73ec64', '9n8', '4', 'gu7v');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (6, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT open_year FROM (SELECT open_year, COUNT(*) AS n FROM branch GROUP BY open_year) WHERE (n > 2) ORDER BY open_year;

/*
Gold Result:
(None,)
('bra_a0edbe',)
*/

-- Prediction Query
SELECT open_year FROM branch GROUP BY open_year HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None,)
('bra_a0edbe',)
('bra_ce76b6',)
*/