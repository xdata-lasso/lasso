-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (1, 'C100', 'Alice', 'Metro', 1);
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (2, 'C200', 'Bob', 'Gotham', 2);
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (3, 'C300', 'Charlie', 'Star City', 3);
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (1, 'Zeta Branch', '2001', '10 First St', 'Boston', '500');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (2, 'Alpha Branch', '2020', '99 Zebra Rd', 'York', '900');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (3, 'Alpha Branch', '1995', '11 Apple Ave', 'Austin', '100');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (4, 'Beta Branch', '2010', '50 Main St', 'Denver', '300');
INSERT INTO membership_register_branch (Member_ID, Branch_ID, Register_Year) VALUES (1, '1', '2015');
INSERT INTO membership_register_branch (Member_ID, Branch_ID, Register_Year) VALUES (2, '1', '2016');
INSERT INTO membership_register_branch (Member_ID, Branch_ID, Register_Year) VALUES (3, '2', '2021');
INSERT INTO purchase (Member_ID, Branch_ID, Year, Total_pounds) VALUES (1, '1', '2018', 120.5);
INSERT INTO purchase (Member_ID, Branch_ID, Year, Total_pounds) VALUES (1, '1', '2019', 85.0);
INSERT INTO purchase (Member_ID, Branch_ID, Year, Total_pounds) VALUES (2, '2', '2020', 310.25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, address_road, city FROM branch ORDER BY name, branch.branch_id NULLS LAST;

/*
Gold Result:
('Alpha Branch', '99 Zebra Rd', 'York')
('Alpha Branch', '11 Apple Ave', 'Austin')
('Beta Branch', '50 Main St', 'Denver')
('Zeta Branch', '10 First St', 'Boston')
*/

-- Prediction Query
SELECT name, address_road, city FROM branch ORDER BY open_year, branch.branch_id NULLS LAST;

/*
Prediction Result:
('Alpha Branch', '11 Apple Ave', 'Austin')
('Zeta Branch', '10 First St', 'Boston')
('Beta Branch', '50 Main St', 'Denver')
('Alpha Branch', '99 Zebra Rd', 'York')
*/