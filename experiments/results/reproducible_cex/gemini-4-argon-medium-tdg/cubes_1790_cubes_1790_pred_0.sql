-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard duplicate levels, NULL level handling (GROUP BY treats NULL as a group vs COUNT(DISTINCT Level) ignoring NULL), and orphan members not present in child tables.
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (1, 'Central', '2010', 'Main St', 'Metropolis', '100');
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (1, 'C101', 'Alice', 'Metropolis', 1);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (2, 'C102', 'Bob', 'Metropolis', 1);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (3, 'C103', 'Charlie', 'Gotham', 2);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (4, 'C104', 'Diana', 'Gotham', NULL);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (5, 'C105', 'Evan', 'Star City', NULL);
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (1, '1', '2015');
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (1, '1', '2016', 50.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_level_ FROM (SELECT LEVEL, COUNT(*) AS n FROM member GROUP BY LEVEL) ORDER BY count_distinct_level_;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT LEVEL) FROM member;

/*
Prediction Result:
(2,)
*/