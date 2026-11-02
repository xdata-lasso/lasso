-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (9, '17', '17', '17', 17);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (8, '17', '17', '17', 17);
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (11, NULL, '2001', NULL, '17', '-550');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (10, '15', '2001', '16', '17', '101');
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (9, 11, '17');
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (8, 11, '17');
INSERT INTO "purchase" ("member_id", "branch_id", "year", "total_pounds") VALUES (8, '11', '17', 17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM branch WHERE (open_year = 2001) ORDER BY city, branch.branch_id NULLS LAST;

/*
Gold Result:
('17',)
('17',)
*/

-- Prediction Query
SELECT city FROM branch WHERE open_year = 2001 AND membership_amount > 100;

/*
Prediction Result:
('17',)
*/