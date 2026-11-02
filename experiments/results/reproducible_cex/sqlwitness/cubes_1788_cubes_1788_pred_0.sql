-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO branch (branch_id, name, open_year, address_road, city, membership_amount) VALUES (2, 'default2', NULL, NULL, 'default1', NULL), (0, 'default2', 'default2', 'default1', 'default2', NULL), (3, 'default2', NULL, 'default1', 'default1', NULL), (1, 'default1', 'default1', NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT open_year FROM (SELECT open_year, COUNT(*) AS n FROM branch GROUP BY open_year) WHERE (n > 2) ORDER BY open_year;

/*
Gold Result:
*/

-- Prediction Query
SELECT open_year FROM branch GROUP BY open_year HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None,)
*/