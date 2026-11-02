-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic threshold boundary conditions: n = 1, 2, 3, 4 and ordering of results.
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (1, 'B1', '2005', 'R1', 'C1', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (2, 'B2', '2003', 'R2', 'C2', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (3, 'B3', '2003', 'R3', 'C3', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (4, 'B4', '2004', 'R4', 'C4', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (5, 'B5', '2004', 'R5', 'C5', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (6, 'B6', '2004', 'R6', 'C6', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (7, 'B7', '2001', 'R7', 'C7', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (8, 'B8', '2001', 'R8', 'C8', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (9, 'B9', '2001', 'R9', 'C9', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (10, 'B10', '2001', 'R10', 'C10', '100');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT open_year FROM (SELECT open_year, COUNT(*) AS n FROM branch GROUP BY open_year) WHERE (n > 2) ORDER BY open_year;

/*
Gold Result:
('2001',)
('2004',)
*/

-- Prediction Query
SELECT open_year FROM branch GROUP BY open_year HAVING COUNT(*) >= 2;

/*
Prediction Result:
('2001',)
('2003',)
('2004',)
*/