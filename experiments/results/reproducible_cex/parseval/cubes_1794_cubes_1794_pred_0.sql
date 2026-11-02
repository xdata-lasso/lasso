-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: branch --
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483648, '5k5swwqcgs', '2001', '9n8', 'bra_ce21bb', '601');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (2, '4', '2001', 'gu7v', 'bra_ce21bb', '601');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (3, 'e4', '2001', 'hria2ypuzhs', 'bra_ce21bb', '601');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483645, 'rwbbp6luhvd', 'bra_3ac23f', 'tti', 'bra_ce21bb', '601');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483644, 'bnp', '2001', 'mdpos', 'bra_ce21bb', '50');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483643, 'ie5', '2001', 'nw6klf', NULL, '601');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (4, 'a9000t5c4eci', '2001', 'gce376nium52', 'zbuo4nrqrof', NULL);

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (5, 'qyp5s5bbp0', 'bra_89596f', '2eutliqa11r', 'ytoo3o9', '50');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (6, 'l7', 'bra_89596f', 'klex14ji', '7zwau2dwyr', NULL);

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (7, '13pyu', NULL, '8d99rljsl', 'b4yp5qi', '601');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (8, 'rkf9vqx5', NULL, 'pz0f8jegd', '1vy9uxj4', '50');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (9, 'wb', NULL, 'v', 'ph2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM branch WHERE (open_year = 2001) ORDER BY city, branch.branch_id NULLS LAST;

/*
Gold Result:
(None,)
('bra_ce21bb',)
('bra_ce21bb',)
('bra_ce21bb',)
('bra_ce21bb',)
('zbuo4nrqrof',)
*/

-- Prediction Query
SELECT city FROM branch WHERE open_year = 2001 AND membership_amount > 100;

/*
Prediction Result:
('bra_ce21bb',)
('bra_ce21bb',)
(None,)
('bra_ce21bb',)
('bra_ce21bb',)
*/