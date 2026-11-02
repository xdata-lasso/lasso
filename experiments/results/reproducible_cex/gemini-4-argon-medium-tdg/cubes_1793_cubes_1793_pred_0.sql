-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (20, NULL, '2015', '300 Elm St', 'Denver', '400');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (5, NULL, '2018', '400 Maple Dr', 'Seattle', '250');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (15, 'Delta', NULL, NULL, 'Miami', NULL);
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (1, 'Delta', '2001', '700 Birch Ln', NULL, '100');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, address_road, city FROM branch ORDER BY name, branch.branch_id NULLS LAST;

/*
Gold Result:
(None, '400 Maple Dr', 'Seattle')
(None, '300 Elm St', 'Denver')
('Delta', '700 Birch Ln', None)
('Delta', None, 'Miami')
*/

-- Prediction Query
SELECT name, address_road, city FROM branch ORDER BY open_year, branch.branch_id NULLS LAST;

/*
Prediction Result:
('Delta', None, 'Miami')
('Delta', '700 Birch Ln', None)
(None, '300 Elm St', 'Denver')
(None, '400 Maple Dr', 'Seattle')
*/