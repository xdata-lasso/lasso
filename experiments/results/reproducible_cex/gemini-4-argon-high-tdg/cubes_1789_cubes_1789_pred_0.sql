-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (2, 'West Branch', '2022', '10 West Rd', 'Boston', '900');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (9, 'East Branch', '2018', '20 East Rd', 'Denver', '500');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (15, 'South Branch', '2005', '30 South Rd', 'Austin', '120');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (100, 'North Branch', '1995', '40 North Rd', 'Seattle', '50');
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (1, 'C101', 'Alice', 'Portland', 1);
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (2, 'C102', 'Bob', 'Houston', 2);
INSERT INTO membership_register_branch (Member_ID, Branch_ID, Register_Year) VALUES (1, '2', '2022');
INSERT INTO membership_register_branch (Member_ID, Branch_ID, Register_Year) VALUES (2, '9', '2019');
INSERT INTO purchase (Member_ID, Branch_ID, Year, Total_pounds) VALUES (1, '2', '2022', 150.5);
INSERT INTO purchase (Member_ID, Branch_ID, Year, Total_pounds) VALUES (2, '9', '2020', 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM (SELECT * FROM (SELECT * FROM branch ORDER BY branch_id DESC) LIMIT 2);

/*
Gold Result:
('Seattle',)
('Austin',)
*/

-- Prediction Query
SELECT DISTINCT city FROM branch WHERE membership_amount >= 100;

/*
Prediction Result:
('Boston',)
('Denver',)
('Austin',)
('Seattle',)
*/