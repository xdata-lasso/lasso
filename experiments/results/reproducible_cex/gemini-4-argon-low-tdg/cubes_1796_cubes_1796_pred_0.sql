-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (10, 'West', '2010', '2nd Ave', 'Gotham', '50');
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (1, 'C1', 'Zack', 'Seattle', 1);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (2, 'C2', 'Aaron', NULL, 2);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (3, 'C3', 'Aaron', 'Denver', 3);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (4, 'C4', 'Aaron', 'Atlanta', 4);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (5, 'C5', NULL, 'Miami', 5);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (6, 'C6', NULL, NULL, 6);
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (1, '10', '2016');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (2, '10', '2016');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (3, '10', '2016');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (4, '10', '2016');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (5, '10', '2016');
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (6, '10', '2016');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, hometown FROM (SELECT LHS.member_id AS member_id, LHS.card_number AS card_number, LHS.name AS name, LHS.hometown AS hometown, LHS.level AS LEVEL, RHS.branch_id AS branch_id, RHS.register_year AS register_year FROM member AS LHS INNER JOIN (SELECT * FROM membership_register_branch WHERE (register_year = 2016)) AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name, hometown NULLS LAST;

/*
Gold Result:
(None, 'Miami')
(None, None)
('Aaron', 'Atlanta')
('Aaron', 'Denver')
('Aaron', None)
('Zack', 'Seattle')
*/

-- Prediction Query
SELECT T2.name, T2.hometown FROM membership_register_branch AS T1 JOIN member AS T2 ON T1.member_id = T2.member_id WHERE T1.register_year = 2016;

/*
Prediction Result:
('Zack', 'Seattle')
('Aaron', None)
('Aaron', 'Denver')
('Aaron', 'Atlanta')
(None, 'Miami')
(None, None)
*/