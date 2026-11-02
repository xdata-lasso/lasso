-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (3, '10', 'Charlie', 'Chicago', 2);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (1, '2', 'Alice', 'Austin', 1);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (2, '10', 'Bob', 'Boston', 3);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (4, '1', 'Alice', 'Austin', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_number, name, hometown FROM member ORDER BY card_number, member.member_id NULLS LAST;

/*
Gold Result:
('1', 'Alice', 'Austin')
('10', 'Bob', 'Boston')
('10', 'Charlie', 'Chicago')
('2', 'Alice', 'Austin')
*/

-- Prediction Query
SELECT card_number, name, hometown FROM member ORDER BY LEVEL DESC, member.member_id NULLS LAST;

/*
Prediction Result:
('10', 'Bob', 'Boston')
('10', 'Charlie', 'Chicago')
('2', 'Alice', 'Austin')
('1', 'Alice', 'Austin')
*/