-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: member --
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483647, 'gu7v', 'e4', 'hria2ypuzhs', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483646, 'rwbbp6luhvd', 'tti', 'bnp', 1);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483645, 'mdpos', 'ie5', 'nw6klf', NULL);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483644, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', NULL);

INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (-2147483643, 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_level_ FROM (SELECT LEVEL, COUNT(*) AS n FROM member GROUP BY LEVEL) ORDER BY count_distinct_level_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT LEVEL) FROM member;

/*
Prediction Result:
(1,)
*/