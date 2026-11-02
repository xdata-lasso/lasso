-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (8, 'Waterbury24', 'Waterbury24', 24, 'Waterbury24');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (10, NULL, 'Waterbury16', 17, 18, 19, 'Waterbury');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (9, NULL, 'Waterbury20', 21, 22, 23, 'Harford');
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (24, 8, 'Waterbury12', 24);
INSERT INTO "happy_hour_member" ("hh_id", "member_id", "total_amount") VALUES (15, 9, 24);
INSERT INTO "happy_hour_member" ("hh_id", "member_id", "total_amount") VALUES (14, 9, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "member" WHERE ("address" = 'Waterbury') ORDER BY name, member.member_id NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT name FROM member WHERE address = 'Harford' OR address = 'Waterbury';

/*
Prediction Result:
(None,)
(None,)
*/