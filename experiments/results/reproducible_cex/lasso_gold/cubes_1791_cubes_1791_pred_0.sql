-- Schema DDL
CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Card_Number" TEXT, "Name" TEXT, "Hometown" TEXT, "Level" INTEGER);

CREATE TABLE "branch" ("Branch_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Open_year" TEXT, "Address_road" TEXT, "City" TEXT, "membership_amount" TEXT);

CREATE TABLE "membership_register_branch" ("Member_ID" INTEGER PRIMARY KEY, "Branch_ID" TEXT, "Register_Year" TEXT, FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

CREATE TABLE "purchase" ("Member_ID" INTEGER, "Branch_ID" TEXT, "Year" TEXT, "Total_pounds" REAL, PRIMARY KEY ("Member_ID", "Branch_ID", "Year"), FOREIGN KEY ("Branch_ID") REFERENCES "branch" ("Branch_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1, 'Kirk Cruz', 'cup', '71518 Benjamin Station
Ritterhaven, NC 80429', 'Romerotown', 'dark');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1130, 'Tiffany Stevenson', 'fund', '6659 Kristina Rue Suite 151
Mitchellberg, MA 11183', 'Kyleborough', 'draw');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1131, 'Terry Armstrong', 'point', '4629 Kyle Lane
Lisahaven, CO 85176', 'Staceyfort', 'certain');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1146, 'Rachel Young', 'own', '862 Laurie Dam Suite 075
Lake Meghanville, LA 11494', 'Westtown', 'economy');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1138, 'Vincent Mueller', 'let', '8261 Lisa Keys Apt. 606
Joeland, MN 29931', 'North Jonathanberg', 'fish');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1139, 'Cheyenne Gregory', 'main', '522 Justin Village
Hortonberg, WV 92977', 'Rodriguezport', 'campaign');
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1147, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1148, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "branch" ("branch_id", "name", "open_year", "address_road", "city", "membership_amount") VALUES (1149, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1132, 'clear', 'Ashley Wise', 'Mooreburgh', 1135);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1133, 'bank', 'Sophia Johnson', 'Lake Samuel', 1146.0);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1134, 'find', 'Ralph Anderson', 'Diazbury', 1157.0);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1140, 'anyone', 'Lisa Brown', 'Rubenstad', 1143);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1141, 'edge', 'Kathryn Herrera', 'New Robert', 1154.0);
INSERT INTO "member" ("member_id", "card_number", "name", "hometown", "level") VALUES (1142, 'kind', 'Laura Higgins', 'New Theresaland', 1165.0);
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (1132, 1, 'life');
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (1133, 1, 'popular');
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (1134, 1, 'feel');
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (1140, 1147, 'never');
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (1141, 1148, 'off');
INSERT INTO "membership_register_branch" ("member_id", "branch_id", "register_year") VALUES (1142, 1149, 'movement');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, open_year FROM (SELECT branch_id, name, open_year, address_road, city, membership_amount, branch_id_other, branch_id AS n_distinct FROM (SELECT LHS.branch_id AS branch_id, LHS.name AS name, LHS.open_year AS open_year, LHS.address_road AS address_road, LHS.city AS city, LHS.membership_amount AS membership_amount, RHS.branch_id AS branch_id_other FROM branch AS LHS INNER JOIN (SELECT branch_id, COUNT(DISTINCT register_year) AS n_distinct FROM membership_register_branch GROUP BY branch_id) AS RHS ON (LHS.branch_id = RHS.n_distinct))) WHERE (n_distinct < 2016 AND n_distinct = 1) ORDER BY name, open_year NULLS LAST;

/*
Gold Result:
('Kirk Cruz', 'cup')
*/

-- Prediction Query
SELECT T2.name, T2.open_year FROM membership_register_branch AS T1 JOIN branch AS T2 ON T1.branch_id = T2.branch_id WHERE T1.register_year = 2016 GROUP BY T2.branch_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST, T2.open_year NULLS LAST LIMIT 1;

/*
Prediction Result:
*/