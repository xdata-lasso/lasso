-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (1, 'B Street', '10', 4.5, '2020');
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (2, 'A Street', '15', 4.8, '2021');
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (1, 1, 'May', 2);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (2, 2, 'May', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address", "shop_id" FROM (SELECT "LHS"."hh_id" AS "hh_id", "LHS"."shop_id" AS "shop_id", "LHS"."month" AS "month", "LHS"."num_of_shaff_in_charge" AS "num_of_shaff_in_charge", "RHS"."address" AS "address", "RHS"."num_of_staff" AS "num_of_staff", "RHS"."score" AS "score", "RHS"."open_year" AS "open_year" FROM (SELECT * FROM "happy_hour" WHERE ("month" = 'May')) AS LHS LEFT JOIN shop AS RHS ON (LHS.shop_id = RHS.shop_id)) ORDER BY address, "address" NULLS LAST, "shop_id" NULLS LAST;

/*
Gold Result:
('A Street', 2)
('B Street', 1)
*/

-- Prediction Query
SELECT t1.address, t1.shop_id FROM shop AS t1 JOIN happy_hour AS t2 ON t1.shop_id = t2.shop_id WHERE MONTH = 'May';

/*
Prediction Result:
('B Street', 1)
('A Street', 2)
*/