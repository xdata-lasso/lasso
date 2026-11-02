-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1004, 'Christy Porter', 'Congress', '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'East Robinshire', 'science');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1005, 'Calvin Nielsen', 'bar', '76483 Cameron Trail
East Lydiamouth, MO 35594', 'Jasonview', 'under');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, address_road, city FROM branch ORDER BY name, branch.branch_id NULLS LAST;

/*
Gold Result:
('Calvin Nielsen', '76483 Cameron Trail\nEast Lydiamouth, MO 35594', 'Jasonview')
('Christy Porter', '310 Kendra Common Apt. 164\nReidstad, GA 49021', 'East Robinshire')
*/

-- Prediction Query
SELECT name, address_road, city FROM branch ORDER BY open_year, branch.branch_id NULLS LAST;

/*
Prediction Result:
('Christy Porter', '310 Kendra Common Apt. 164\nReidstad, GA 49021', 'East Robinshire')
('Calvin Nielsen', '76483 Cameron Trail\nEast Lydiamouth, MO 35594', 'Jasonview')
*/