-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY name, hometown NULLS LAST, and SELECT vs SELECT DISTINCT (duplicate name and hometown combinations).
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (1, 'Main', '2010', 'Oak Rd', 'NY', '100');
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (10, 'C1', 'Zack', 'Seattle', 1);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (20, 'C2', 'Anna', 'Boston', 2);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (30, 'C3', 'Anna', 'Austin', 3);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (40, 'C4', 'Anna', NULL, 1);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (50, 'C5', 'Anna', 'Austin', 4);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (60, 'C6', NULL, 'Denver', 2);
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (10, '1', '2016');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (20, '1', '2016');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (30, '1', '2016');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (40, '1', '2016');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (50, '1', '2016');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (60, '1', '2016');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, hometown FROM (SELECT LHS.member_id AS member_id, LHS.card_number AS card_number, LHS.name AS name, LHS.hometown AS hometown, LHS.level AS LEVEL, RHS.branch_id AS branch_id, RHS.register_year AS register_year FROM member AS LHS INNER JOIN (SELECT * FROM membership_register_branch WHERE (register_year = 2016)) AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name, hometown NULLS LAST;

/*
Gold Result:
(None, 'Denver')
('Anna', 'Austin')
('Anna', 'Austin')
('Anna', 'Boston')
('Anna', None)
('Zack', 'Seattle')
*/

-- Prediction Query
SELECT T2.name, T2.hometown FROM membership_register_branch AS T1 JOIN member AS T2 ON T1.member_id = T2.member_id WHERE T1.register_year = 2016;

/*
Prediction Result:
('Zack', 'Seattle')
('Anna', 'Boston')
('Anna', 'Austin')
('Anna', None)
('Anna', 'Austin')
(None, 'Denver')
*/