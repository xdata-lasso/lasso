-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1017, 'Sandra Williams', '2001', '427 Hoffman Creek
Lake Rebeccaside, AZ 48894', 'Rebeccaton', 'best');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1018, 'Teresa Taylor', '2001', '824 Jacobs Stravenue
Jamesview, NY 64533', 'Rachelton', 'foot');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM branch WHERE (open_year = 2001) ORDER BY city, branch.branch_id NULLS LAST;

/*
Gold Result:
('Rachelton',)
('Rebeccaton',)
*/

-- Prediction Query
SELECT city FROM branch WHERE open_year = 2001 AND membership_amount > 100;

/*
Prediction Result:
('Rebeccaton',)
('Rachelton',)
*/