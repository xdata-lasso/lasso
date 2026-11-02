-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (1, 'North', '2010', '1st Ave', 'Boston', '1');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (2, 'South', '2010', '2nd Ave', 'Austin', '1');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (3, 'East', '2010', '3rd Ave', 'Denver', '2');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (4, 'West', '2001', '4th Ave', 'Seattle', '0');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (5, 'Central', '2001', '5th Ave', 'Miami', '1');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (6, 'Harbor', '2001', '6th Ave', 'Dallas', '1');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (7, 'Valley', '2001', '7th Ave', 'Phoenix', '1');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (8, 'Hill', '2005', '8th Ave', 'Chicago', '100');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (9, 'Lake', '2005', '9th Ave', 'Detroit', '200');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (10, 'Metro', '1998', '10th Ave', 'Atlanta', '500');
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (1, 'C101', 'Alice', 'Atlanta', 1);
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (2, 'C102', 'Bob', 'Atlanta', 2);
INSERT INTO member (Member_ID, Card_Number, Name, Hometown, Level) VALUES (3, 'C103', 'Charlie', 'Atlanta', 3);
INSERT INTO membership_register_branch (Member_ID, Branch_ID, Register_Year) VALUES (1, '10', '2015');
INSERT INTO membership_register_branch (Member_ID, Branch_ID, Register_Year) VALUES (2, '10', '2015');
INSERT INTO membership_register_branch (Member_ID, Branch_ID, Register_Year) VALUES (3, '10', '2015');
INSERT INTO purchase (Member_ID, Branch_ID, Year, Total_pounds) VALUES (1, '10', '2016', 50.5);
INSERT INTO purchase (Member_ID, Branch_ID, Year, Total_pounds) VALUES (2, '10', '2016', 75.0);
INSERT INTO purchase (Member_ID, Branch_ID, Year, Total_pounds) VALUES (3, '10', '2016', 120.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT open_year FROM (SELECT open_year, COUNT(*) AS n FROM branch GROUP BY open_year) WHERE (n > 2) ORDER BY open_year;

/*
Gold Result:
('2001',)
('2010',)
*/

-- Prediction Query
SELECT open_year FROM branch GROUP BY open_year HAVING COUNT(*) >= 2;

/*
Prediction Result:
('2001',)
('2005',)
('2010',)
*/