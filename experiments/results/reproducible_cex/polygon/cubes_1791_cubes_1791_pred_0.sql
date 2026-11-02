-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (29, '30', '30', '30', 30);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (28, '30', '30', '30', 30);
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (30, '31', '32', '33', '34', '35');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1, '24', '25', '21', '22', '23');
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (28, 30, '2016');
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (29, 30, '2016');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, open_year FROM (SELECT branch_id, name, open_year, address_road, city, membership_amount, branch_id_other, branch_id AS n_distinct FROM (SELECT LHS.branch_id AS branch_id, LHS.name AS name, LHS.open_year AS open_year, LHS.address_road AS address_road, LHS.city AS city, LHS.membership_amount AS membership_amount, RHS.branch_id AS branch_id_other FROM branch AS LHS INNER JOIN (SELECT branch_id, COUNT(DISTINCT register_year) AS n_distinct FROM membership_register_branch GROUP BY branch_id) AS RHS ON (LHS.branch_id = RHS.n_distinct))) WHERE (n_distinct < 2016 AND n_distinct = 1) ORDER BY name, open_year NULLS LAST;

/*
Gold Result:
('24', '25')
*/

-- Prediction Query
SELECT T2.name, T2.open_year FROM membership_register_branch AS T1 JOIN branch AS T2 ON T1.branch_id = T2.branch_id WHERE T1.register_year = 2016 GROUP BY T2.branch_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST, T2.open_year NULLS LAST LIMIT 1;

/*
Prediction Result:
('31', '32')
*/