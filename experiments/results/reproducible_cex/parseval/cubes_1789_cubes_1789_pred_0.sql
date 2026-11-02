-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: branch --
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1, 'bra_fe8975', 'bra_e93144', 'bra_17c813', 'bra_dac63c', 'bra_0c42a7');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483647, 'bra_30b92b', 'bra_c6c82f', 'bra_668fb6', 'bra_149ec7', 'bra_ed2110');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483646, '5k5swwqcgs', '9n8', '4', 'q_1_7cef83', 'gu7v');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483645, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'q_1_7cef83', 'tti');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (2, 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci');

INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483648, 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM (SELECT * FROM (SELECT * FROM branch ORDER BY branch_id DESC) LIMIT 2);

/*
Gold Result:
('nw6klf',)
('bra_dac63c',)
*/

-- Prediction Query
SELECT DISTINCT city FROM branch WHERE membership_amount >= 100;

/*
Prediction Result:
('2eutliqa11r',)
('bra_149ec7',)
('q_1_7cef83',)
('bra_dac63c',)
('nw6klf',)
*/