-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1001, 'Allison Hill', 'offer', '65423 Garcia Light
West Melanieview, AS 06196', 'Port Brandonville', 'response');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1002, 'Noah Rhodes', 'kind', '1849 Ray Squares
North Donnaport, CO 31013', 'Lake Ernest', 'set');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1003, 'Angie Henderson', 'discussion', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'Carlsonfurt', 'building');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1004, 'Daniel Wagner', 'list', '503 Linda Locks
Carlshire, FM 94599', 'Carlsonmouth', 'rest');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1005, 'Cristian Santos', 'perform', '7242 Julie Plain Suite 969
Coxberg, NY 65187', 'Tashatown', 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM (SELECT * FROM (SELECT * FROM branch ORDER BY branch_id DESC) LIMIT 2);

/*
Gold Result:
('Tashatown',)
('Carlsonmouth',)
*/

-- Prediction Query
SELECT DISTINCT city FROM branch WHERE membership_amount >= 100;

/*
Prediction Result:
('Port Brandonville',)
('Lake Ernest',)
('Carlsonfurt',)
('Carlsonmouth',)
('Tashatown',)
*/