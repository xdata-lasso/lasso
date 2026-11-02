-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1007, 'Black', 'show', 1008, 1009, 1010, '1849 Ray Squares
North Donnaport, CO 31013');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1010, 'Black', 'show', 1011, 1009, 1012, '7525 Clark Grove Apt. 928
East Steven, KY 84387');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address_other" AS "address" FROM (SELECT "level_of_membership" AS "member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address", "name_other", "membership_card_other", "age_other", "level_of_membership_other", "address_other" FROM (SELECT "LHS"."member_id" AS "member_id", "LHS"."name" AS "name", "LHS"."membership_card" AS "membership_card", "LHS"."age" AS "age", "LHS"."time_of_purchase" AS "time_of_purchase", "LHS"."level_of_membership" AS "level_of_membership", "LHS"."address" AS "address", "RHS"."name" AS "name_other", "RHS"."membership_card" AS "membership_card_other", "RHS"."age" AS "age_other", "RHS"."level_of_membership" AS "level_of_membership_other", "RHS"."address" AS "address_other" FROM "member" AS "LHS" INNER JOIN "member" AS "RHS" ON ("LHS"."time_of_purchase" = "RHS"."time_of_purchase" AND "LHS"."level_of_membership" = "RHS"."member_id"))) WHERE ("membership_card" = 'Black') ORDER BY address;

/*
Gold Result:
*/

-- Prediction Query
SELECT address FROM member EXCEPT SELECT address FROM member WHERE Membership_card = 'Black';

/*
Prediction Result:
('1849 Ray Squares\nNorth Donnaport, CO 31013',)
('7525 Clark Grove Apt. 928\nEast Steven, KY 84387',)
*/