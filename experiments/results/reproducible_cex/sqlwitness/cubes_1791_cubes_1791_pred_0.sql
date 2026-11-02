-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO branch (branch_id, name, open_year, address_road, city, membership_amount) VALUES (0, 'default2', 'default2', 'default1', NULL, 'default2'), (2015, 'default1', 'default1', 'default2', 'default2', NULL), (1, 'default1', 'default1', NULL, 'default1', 'default2'), (2016, 'default1', NULL, NULL, 'default1', NULL), (2017, 'default1', NULL, 'default1', 'default2', NULL);
INSERT INTO member (member_id, card_number, name, hometown, level) VALUES (2017, 'default1', 'default2', 'default2', 2016), (2016, 'default1', 'default1', 'default2', 0), (1, NULL, 'default2', 'default1', 2016), (2015, 'default2', NULL, NULL, 2016);
INSERT INTO membership_register_branch (member_id, branch_id, register_year) VALUES (2016, NULL, NULL), (1, 0, 'default2'), (2015, 2017, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, open_year FROM (SELECT branch_id, name, open_year, address_road, city, membership_amount, branch_id_other, branch_id AS n_distinct FROM (SELECT LHS.branch_id AS branch_id, LHS.name AS name, LHS.open_year AS open_year, LHS.address_road AS address_road, LHS.city AS city, LHS.membership_amount AS membership_amount, RHS.branch_id AS branch_id_other FROM branch AS LHS INNER JOIN (SELECT branch_id, COUNT(DISTINCT register_year) AS n_distinct FROM membership_register_branch GROUP BY branch_id) AS RHS ON (LHS.branch_id = RHS.n_distinct))) WHERE (n_distinct < 2016 AND n_distinct = 1) ORDER BY name, open_year NULLS LAST;

/*
Gold Result:
('default1', 'default1')
*/

-- Prediction Query
SELECT T2.name, T2.open_year FROM membership_register_branch AS T1 JOIN branch AS T2 ON T1.branch_id = T2.branch_id WHERE T1.register_year = 2016 GROUP BY T2.branch_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST, T2.open_year NULLS LAST LIMIT 1;

/*
Prediction Result:
*/