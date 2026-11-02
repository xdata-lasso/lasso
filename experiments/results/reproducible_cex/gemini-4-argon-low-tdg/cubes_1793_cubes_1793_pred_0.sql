-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (20, 'Beta', '2001', '123 Main St', 'Metropolis', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (10, 'Alpha', '1999', '456 Oak Ave', 'Gotham', '200');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (5, 'Alpha', '2005', '789 Pine Rd', 'Star City', '50');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (15, 'Gamma', '2010', '101 Maple Ln', 'Central City', '300');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, address_road, city FROM branch ORDER BY name, branch.branch_id NULLS LAST;

/*
Gold Result:
('Alpha', '789 Pine Rd', 'Star City')
('Alpha', '456 Oak Ave', 'Gotham')
('Beta', '123 Main St', 'Metropolis')
('Gamma', '101 Maple Ln', 'Central City')
*/

-- Prediction Query
SELECT name, address_road, city FROM branch ORDER BY open_year, branch.branch_id NULLS LAST;

/*
Prediction Result:
('Alpha', '456 Oak Ave', 'Gotham')
('Beta', '123 Main St', 'Metropolis')
('Alpha', '789 Pine Rd', 'Star City')
('Gamma', '101 Maple Ln', 'Central City')
*/