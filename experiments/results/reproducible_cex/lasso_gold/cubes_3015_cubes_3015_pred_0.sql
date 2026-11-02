-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1001, 'Allison Hill', 'dog', 1002, 1003, 1004, 'Hartford');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "membership_card" FROM "member" WHERE ("address" = 'Hartford' AND "address" <> 'Waterbury') ORDER BY membership_card, "membership_card" NULLS LAST;

/*
Gold Result:
('dog',)
*/

-- Prediction Query
SELECT membership_card FROM member WHERE address = 'Hartford' INTERSECT SELECT membership_card FROM member WHERE address = 'Waterbury';

/*
Prediction Result:
*/