-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard join, pre-filter aggregation (COUNT(*) BEFORE filtering by Level < 6),
-- boundary conditions for Level (< 6, = 6, > 6, NULL), and multiplicity (no DISTINCT).
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (1, 'C101', 'Alice', 'NY', 5);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (2, 'C102', 'Bob', 'LA', 6);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (3, 'C103', 'Charlie', 'SF', 1);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (4, 'C104', 'Diana', 'CHI', NULL);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (5, 'C105', 'Evan', 'BOS', 7);
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (10, 'Main', '2010', '1st Ave', 'NY', '100');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (20, 'West', '2015', '2nd St', 'LA', '200');
-- Year 2020: 3 total purchases (Member 1, Member 2, Member 4).
-- Only Member 1 has Level < 6. Output for 2020 should be one row with count___ = 3 (not 1).
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (1, '10', '2020', 50.5);
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (2, '10', '2020', 30.0);
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (4, '20', '2020', 10.0);
-- Year 2021: 2 total purchases (Member 1, Member 3). Both have Level < 6.
-- Output for 2021 should be two rows, each with count___ = 2.
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (1, '20', '2021', 25.0);
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (3, '10', '2021', 75.0);
-- Year 2022: 1 purchase by Member 5 (Level 7). Should not appear in output at all.
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (5, '10', '2022', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT LHS.member_id AS member_id, LHS.branch_id AS branch_id, LHS.year AS YEAR, LHS.total_pounds AS total_pounds, LHS.n AS n, RHS.card_number AS card_number, RHS.name AS name, RHS.hometown AS hometown, RHS.level AS LEVEL FROM (SELECT LHS.member_id AS member_id, LHS.branch_id AS branch_id, LHS.year AS YEAR, LHS.total_pounds AS total_pounds, RHS.n AS n FROM purchase AS LHS INNER JOIN (SELECT YEAR, COUNT(*) AS n FROM purchase GROUP BY YEAR) AS RHS ON (LHS.year = RHS.year)) AS LHS INNER JOIN (SELECT * FROM member WHERE (LEVEL < 6)) AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY count___;

/*
Gold Result:
(2,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM purchase AS T1 JOIN member AS T2 ON T1.member_id = T2.member_id WHERE T2.level = 6;

/*
Prediction Result:
(1,)
*/