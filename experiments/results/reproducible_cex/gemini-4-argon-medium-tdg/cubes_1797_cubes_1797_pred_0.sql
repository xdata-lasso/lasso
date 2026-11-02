-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (2, 'C1', 'Alice', 'NY', 10);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (3, 'C1', 'Bob', 'LA', 20);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (4, 'C2', 'Charlie', 'SF', 10);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (5, 'C3', 'Dave', 'TX', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LEVEL FROM (SELECT LHS.card_number AS card_number, LHS.level AS LEVEL, LHS.n AS n, RHS.card_number AS card_number_other, RHS.name AS name, RHS.hometown AS hometown FROM (SELECT card_number, LEVEL, COUNT(*) AS n FROM member GROUP BY card_number, LEVEL) AS LHS INNER JOIN member AS RHS ON (LHS.level = RHS.level AND LHS.n = RHS.member_id)) ORDER BY LEVEL;

/*
Gold Result:
*/

-- Prediction Query
SELECT LEVEL FROM member GROUP BY LEVEL ORDER BY COUNT(*) DESC, LEVEL NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/