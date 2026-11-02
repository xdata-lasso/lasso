-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (1, '100', 'Alice', 'NYC', 5);
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (1, 'Main', '2000', '1st Ave', 'NYC', '100');
INSERT INTO purchase (Member_ID, Branch_ID, Year, Total_pounds) VALUES (1, '1', '2020', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT LHS.member_id AS member_id, LHS.branch_id AS branch_id, LHS.year AS YEAR, LHS.total_pounds AS total_pounds, LHS.n AS n, RHS.card_number AS card_number, RHS.name AS name, RHS.hometown AS hometown, RHS.level AS LEVEL FROM (SELECT LHS.member_id AS member_id, LHS.branch_id AS branch_id, LHS.year AS YEAR, LHS.total_pounds AS total_pounds, RHS.n AS n FROM purchase AS LHS INNER JOIN (SELECT YEAR, COUNT(*) AS n FROM purchase GROUP BY YEAR) AS RHS ON (LHS.year = RHS.year)) AS LHS INNER JOIN (SELECT * FROM member WHERE (LEVEL < 6)) AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM purchase AS T1 JOIN member AS T2 ON T1.member_id = T2.member_id WHERE T2.level = 6;

/*
Prediction Result:
(0,)
*/