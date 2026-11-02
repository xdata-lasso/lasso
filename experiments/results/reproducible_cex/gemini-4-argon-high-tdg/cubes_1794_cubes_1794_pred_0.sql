-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (1, 'Alpha', '2001', '1st St', 'Zurich', '100');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (2, 'Beta', '2000', '2nd St', 'Austin', '2001');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (3, 'Gamma', '2001', '3rd St', 'Boston', '300');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (4, 'Delta', '2002', '4th St', 'Denver', '400');
INSERT INTO branch (Branch_ID, Name, Open_year, Address_road, City, membership_amount) VALUES (5, 'Epsilon', '2001', '5th St', 'Boston', '50');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM branch WHERE (open_year = 2001) ORDER BY city, branch.branch_id NULLS LAST;

/*
Gold Result:
('Boston',)
('Boston',)
('Zurich',)
*/

-- Prediction Query
SELECT city FROM branch WHERE open_year = 2001 AND membership_amount > 100;

/*
Prediction Result:
('Boston',)
('Boston',)
*/