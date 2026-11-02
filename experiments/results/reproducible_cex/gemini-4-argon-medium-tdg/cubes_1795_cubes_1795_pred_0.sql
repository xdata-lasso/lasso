-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests level boundaries (< 6 vs <= 6 vs > 6), pre-filter vs post-filter aggregation per year, and ordering of counts.
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (1, 'C101', 'Alice', 'New York', 5);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (2, 'C102', 'Bob', 'Chicago', 6);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (3, 'C103', 'Charlie', 'Boston', 7);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (4, 'C104', 'Diana', 'Seattle', 1);
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (10, 'Downtown', '2010', 'Main St', 'New York', '500');
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (20, 'Uptown', '2015', 'High St', 'Chicago', '300');
-- Year 2020: 3 total purchases (n=3), but only 1 by a member with Level < 6 (Member 1).
-- If a mutant filters Level < 6 before counting, n will be 1 instead of 3.
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (1, '10', '2020', 100.5);
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (2, '10', '2020', 200.0);
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (3, '20', '2020', 150.0);
-- Year 2021: 2 total purchases (n=2), both by members with Level < 6 (Members 1 and 4).
-- Output should have two rows with n=2, testing duplicate retention (SELECT vs SELECT DISTINCT) and ORDER BY (2, 2, 3).
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (1, '20', '2021', 50.0);
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (4, '10', '2021', 75.25);
-- Year 2022: 1 purchase (n=1), by Member 2 (Level 6). Should be completely excluded from final output.
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (2, '20', '2022', 300.0);
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
(2,)
*/