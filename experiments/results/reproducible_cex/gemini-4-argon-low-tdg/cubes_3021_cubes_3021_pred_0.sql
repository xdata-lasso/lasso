-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set vs. scalar COUNT(*) behavior when no 'Black' membership_card exists.
-- Reference Query returns 0 rows (empty result set) because of GROUP BY on an empty filtered relation.
-- Catches:
-- 1. Queries that omit GROUP BY "membership_card" (i.e., SELECT COUNT(*) FROM member WHERE membership_card = 'Black'), which return 1 row with value 0 instead of 0 rows.
-- 2. Queries that use != 'Black' or NOT IN ('Black').
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (1, 'Alice', 'Gold', 30, 5, 2, '123 St');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (2, 'Bob', 'Silver', 22, 3, 1, '456 St');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (3, 'Charlie', NULL, 45, 10, 4, '789 St');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "membership_card", COUNT(*) AS "n" FROM (SELECT * FROM "member" WHERE ("membership_card" = 'Black')) GROUP BY membership_card) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM member WHERE Membership_card = 'Black';

/*
Prediction Result:
(0,)
*/