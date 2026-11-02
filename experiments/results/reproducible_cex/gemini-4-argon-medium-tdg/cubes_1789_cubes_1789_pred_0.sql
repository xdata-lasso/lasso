-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard ordering (DESC vs ASC), LIMIT boundary (2 vs 1, 3, or none), and ordering by the correct column (Branch_ID vs Open_year, Name, City, or membership_amount).
-- Also includes an unreferenced branch (Branch_ID 30) to kill mutants that incorrectly INNER JOIN with membership_register_branch or purchase.
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (1, 'C100', 'Alice', 'London', 1);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (2, 'C200', 'Bob', 'Paris', 2);
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (10, 'Zeta Branch', '2022', '1st Ave', 'Chicago', '900');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (30, 'Beta Branch', '2018', '3rd Ave', 'Boston', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (20, 'Alpha Branch', '2020', '2nd Ave', 'Seattle', '500');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (5, 'Omega Branch', '2023', '4th Ave', 'Miami', '999');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (1, '10', '2022');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (2, '20', '2021');
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (1, '10', '2022', 150.5);
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (2, '20', '2021', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM (SELECT * FROM (SELECT * FROM branch ORDER BY branch_id DESC) LIMIT 2);

/*
Gold Result:
('Boston',)
('Seattle',)
*/

-- Prediction Query
SELECT DISTINCT city FROM branch WHERE membership_amount >= 100;

/*
Prediction Result:
('Miami',)
('Chicago',)
('Seattle',)
('Boston',)
*/