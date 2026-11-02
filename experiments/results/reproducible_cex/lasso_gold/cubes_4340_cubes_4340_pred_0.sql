-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1088, 'walk', 'James Hernandez', 'Port Nicoleshire', NULL);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1089, 'now', 'Jason Rivera', 'Woodsstad', NULL);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1090, 'be', 'Antonio Wall', 'Karenchester', NULL);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1091, 'certainly', 'Randy Shah', 'South Jeffrey', NULL);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1093, 'mention', 'Rebecca Ramsey', 'Whiteview', 1097);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1094, 'air', 'Tamara Hooper', 'Murphymouth', 1097);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1095, 'improve', 'Susan Vargas', 'Matthewfurt', 1097);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1096, 'great', 'Angela Patterson', 'Maryfort', 1097);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LEVEL FROM (SELECT * FROM (SELECT * FROM (SELECT LEVEL, MAX(n) AS maxn FROM (SELECT LEVEL, COUNT(*) AS n FROM member GROUP BY LEVEL) GROUP BY LEVEL) ORDER BY maxn DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT LEVEL FROM member GROUP BY LEVEL ORDER BY COUNT(*) DESC, LEVEL NULLS LAST LIMIT 1;

/*
Prediction Result:
(1097,)
*/