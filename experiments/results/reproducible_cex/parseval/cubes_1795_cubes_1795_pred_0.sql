-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1, '5k5swwqcgs', '9n8', '4', 6);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (2, 'nprmdposii', '5u', 'w6kl', 6);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (3, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 373262291);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (4, '5k5swwqcgs', '9n8', '4', NULL);

-- Inserting into table: branch --
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti');

-- Inserting into table: purchase --
INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_1', 182.319045);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (3, '-2147483648', 'year_2', 389.878901);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (3, '-2147483648', 'year_3', 938.694822);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (3, '-2147483648', 'year_4', 718.756092);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (3, '-2147483648', 'year_5', 22.720462);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_6', 705.580387);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_7', 825.231787);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_8', 325.080047);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_9', 138.017996);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_10', 6.833035);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_11', 274.580687);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_12', 881.232072);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_13', 300.875654);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_14', 937.856955);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (1, '-2147483648', 'year_15', 882.985782);

INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (4, '-2147483648', 'year_16', 935.695299);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT LHS.member_id AS member_id, LHS.branch_id AS branch_id, LHS.year AS YEAR, LHS.total_pounds AS total_pounds, LHS.n AS n, RHS.card_number AS card_number, RHS.name AS name, RHS.hometown AS hometown, RHS.level AS LEVEL FROM (SELECT LHS.member_id AS member_id, LHS.branch_id AS branch_id, LHS.year AS YEAR, LHS.total_pounds AS total_pounds, RHS.n AS n FROM purchase AS LHS INNER JOIN (SELECT YEAR, COUNT(*) AS n FROM purchase GROUP BY YEAR) AS RHS ON (LHS.year = RHS.year)) AS LHS INNER JOIN (SELECT * FROM member WHERE (LEVEL < 6)) AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM purchase AS T1 JOIN member AS T2 ON T1.member_id = T2.member_id WHERE T2.level = 6;

/*
Prediction Result:
(11,)
*/