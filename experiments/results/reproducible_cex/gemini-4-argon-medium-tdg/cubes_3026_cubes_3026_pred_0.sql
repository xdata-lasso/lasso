-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (1, 'Alice', 'Black', 30, 10, 2, '100 Main St');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (2, 'Bob', 'White', 25, 10, 5, '999 Z St');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (3, 'Charlie', 'Black', 40, 20, 4, '800 B St');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (4, 'David', 'Gold', 35, 20, 1, '100 A St');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (5, 'Eve', 'Black', 28, 30, 6, '500 E St');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (6, 'Frank', 'Silver', 50, 99, 1, '300 F St');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (7, 'Grace', 'Black', 22, 10, 99, '700 G St');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address_other" AS "address" FROM (SELECT "level_of_membership" AS "member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address", "name_other", "membership_card_other", "age_other", "level_of_membership_other", "address_other" FROM (SELECT "LHS"."member_id" AS "member_id", "LHS"."name" AS "name", "LHS"."membership_card" AS "membership_card", "LHS"."age" AS "age", "LHS"."time_of_purchase" AS "time_of_purchase", "LHS"."level_of_membership" AS "level_of_membership", "LHS"."address" AS "address", "RHS"."name" AS "name_other", "RHS"."membership_card" AS "membership_card_other", "RHS"."age" AS "age_other", "RHS"."level_of_membership" AS "level_of_membership_other", "RHS"."address" AS "address_other" FROM "member" AS "LHS" INNER JOIN "member" AS "RHS" ON ("LHS"."time_of_purchase" = "RHS"."time_of_purchase" AND "LHS"."level_of_membership" = "RHS"."member_id"))) WHERE ("membership_card" = 'Black') ORDER BY address;

/*
Gold Result:
('100 A St',)
('999 Z St',)
*/

-- Prediction Query
SELECT address FROM member EXCEPT SELECT address FROM member WHERE Membership_card = 'Black';

/*
Prediction Result:
('100 A St',)
('300 F St',)
('999 Z St',)
*/