-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join, ORDER BY Name (DESC vs ASC, insertion order vs alphabetical), duplicate names (SELECT vs SELECT DISTINCT), and confusion between membership_register_branch and purchase tables.
INSERT INTO "branch" ("Branch_ID", "Name", "Open_year", "Address_road", "City", "membership_amount") VALUES (10, 'Main Branch', '2010', '1st Ave', 'Metropolis', '500');
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (1, 'C101', 'Zack', 'TownA', 1);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (2, 'C102', 'Alice', 'TownB', 2);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (3, 'C103', 'Bob', 'TownC', 3);
INSERT INTO "member" ("Member_ID", "Card_Number", "Name", "Hometown", "Level") VALUES (4, 'C104', 'Alice', 'TownD', 1);
INSERT INTO "membership_register_branch" ("Member_ID", "Branch_ID", "Register_Year") VALUES (3, '10', '2020');
INSERT INTO "purchase" ("Member_ID", "Branch_ID", "Year", "Total_pounds") VALUES (1, '10', '2021', 150.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM member AS LHS WHERE NOT EXISTS(SELECT 1 FROM membership_register_branch AS RHS WHERE (LHS.member_id = RHS.member_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM member WHERE NOT member_id IN (SELECT member_id FROM membership_register_branch);

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/