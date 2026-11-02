-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1048, 'Justin Lowery', 'campaign', '889 Dodson Mills Suite 872
Colebury, MP 84080', 'Katiehaven', 'memory');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1051, 'Angela Hernandez', 'identify', '66587 Brown Village
Priceshire, UT 03061', 'Woodsstad', 'fire');
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1049, 'produce', 'Jeremiah Reeves', 'Ramseymouth', 1050);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1052, 'some', 'Allen Rogers', 'West Matthew', 1051);
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (1049, 1048, '2016');
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (1052, 1051, '2016');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, hometown FROM (SELECT LHS.member_id AS member_id, LHS.card_number AS card_number, LHS.name AS name, LHS.hometown AS hometown, LHS.level AS LEVEL, RHS.branch_id AS branch_id, RHS.register_year AS register_year FROM member AS LHS INNER JOIN (SELECT * FROM membership_register_branch WHERE (register_year = 2016)) AS RHS ON (LHS.member_id = RHS.member_id)) ORDER BY name, hometown NULLS LAST;

/*
Gold Result:
('Allen Rogers', 'West Matthew')
('Jeremiah Reeves', 'Ramseymouth')
*/

-- Prediction Query
SELECT T2.name, T2.hometown FROM membership_register_branch AS T1 JOIN member AS T2 ON T1.member_id = T2.member_id WHERE T1.register_year = 2016;

/*
Prediction Result:
('Jeremiah Reeves', 'Ramseymouth')
('Allen Rogers', 'West Matthew')
*/