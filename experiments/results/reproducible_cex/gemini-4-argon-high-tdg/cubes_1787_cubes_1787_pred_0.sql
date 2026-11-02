-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (10, '20', 'Delta', 'Austin', 20);
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (20, '10', 'Bravo', 'Dallas', 10);
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (30, '30', 'Echo', 'Houston', 30);
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (40, '20', 'Alpha', 'El Paso', 20);
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (100, 'Main', '2005', 'Oak Rd', 'Austin', '1000');
INSERT INTO membership_register_branch (Member_ID, Branch_ID, Register_Year) VALUES (20, '100', '2019');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM member AS LHS WHERE NOT EXISTS(SELECT 1 FROM membership_register_branch AS RHS WHERE (LHS.member_id = RHS.member_id))) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Delta',)
('Echo',)
*/

-- Prediction Query
SELECT name FROM member WHERE NOT member_id IN (SELECT member_id FROM membership_register_branch);

/*
Prediction Result:
('Delta',)
('Echo',)
('Alpha',)
*/