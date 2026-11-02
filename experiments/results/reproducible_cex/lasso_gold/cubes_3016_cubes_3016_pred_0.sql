-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1059, '71822 Arroyo Expressway
Allisonchester, IL 71187', 'someone', 1060.5, 'show');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1064, '71822 Arroyo Expressway
Allisonchester, IL 71187', 'someone', 1060.5, 'show');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1073, '1834 Lewis Curve
Sanchezfort, AS 53855', 'customer', 1074.5, 'between');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1078, '1834 Lewis Curve
Sanchezfort, AS 53855', 'customer', 1074.5, 'between');
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1061, 1059, 'May', 1062);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1065, 1059, 'road', 1062);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1068, 1059, 'May', 1069);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1075, 1073, 'May', 1076);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1079, 1073, 'bill', 1076);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address", "shop_id" FROM (SELECT "LHS"."hh_id" AS "hh_id", "LHS"."shop_id" AS "shop_id", "LHS"."month" AS "month", "LHS"."num_of_shaff_in_charge" AS "num_of_shaff_in_charge", "RHS"."address" AS "address", "RHS"."num_of_staff" AS "num_of_staff", "RHS"."score" AS "score", "RHS"."open_year" AS "open_year" FROM (SELECT * FROM "happy_hour" WHERE ("month" = 'May')) AS LHS LEFT JOIN shop AS RHS ON (LHS.shop_id = RHS.shop_id)) ORDER BY address, "address" NULLS LAST, "shop_id" NULLS LAST;

/*
Gold Result:
('1834 Lewis Curve\nSanchezfort, AS 53855', 1073)
('71822 Arroyo Expressway\nAllisonchester, IL 71187', 1059)
('71822 Arroyo Expressway\nAllisonchester, IL 71187', 1059)
*/

-- Prediction Query
SELECT t1.address, t1.shop_id FROM shop AS t1 JOIN happy_hour AS t2 ON t1.shop_id = t2.shop_id WHERE MONTH = 'May';

/*
Prediction Result:
('71822 Arroyo Expressway\nAllisonchester, IL 71187', 1059)
('71822 Arroyo Expressway\nAllisonchester, IL 71187', 1059)
('1834 Lewis Curve\nSanchezfort, AS 53855', 1073)
*/