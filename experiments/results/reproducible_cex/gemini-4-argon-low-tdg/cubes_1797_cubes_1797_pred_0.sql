-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality, GROUP BY (card_number, level), DISTINCT, and ORDER BY.
-- Includes:
-- 1) Multiple groups for the same level to test DISTINCT.
-- 2) Same card_number across different levels to test composite GROUP BY vs GROUP BY card_number only.
-- 3) Different card_numbers within the same level to test composite GROUP BY vs GROUP BY level only.
-- 4) Out-of-order insertion to test ORDER BY.
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (10, 'C1', 'Alice', 'NY', 30);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (1, 'C2', 'Bob', 'LA', 30);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (2, 'C3', 'Charlie', 'SF', 10);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (3, 'C3', 'David', 'SF', 10);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (4, 'C1', 'Eve', 'TX', 20);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (5, 'C4', 'Frank', 'FL', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LEVEL FROM (SELECT LHS.card_number AS card_number, LHS.level AS LEVEL, LHS.n AS n, RHS.card_number AS card_number_other, RHS.name AS name, RHS.hometown AS hometown FROM (SELECT card_number, LEVEL, COUNT(*) AS n FROM member GROUP BY card_number, LEVEL) AS LHS INNER JOIN member AS RHS ON (LHS.level = RHS.level AND LHS.n = RHS.member_id)) ORDER BY LEVEL;

/*
Gold Result:
(10,)
(30,)
*/

-- Prediction Query
SELECT LEVEL FROM member GROUP BY LEVEL ORDER BY COUNT(*) DESC, LEVEL NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/