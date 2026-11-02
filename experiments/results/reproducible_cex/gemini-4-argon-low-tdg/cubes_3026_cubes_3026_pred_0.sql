-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests partial join condition failures (only Time_of_purchase matches, or only Level_of_membership = Member_ID matches) and WHERE clause filtering (LHS vs RHS Membership_card)
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (1, 'A', 'Black', 20, 5, 2, 'Addr1');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (2, 'B', 'White', 22, 6, 99, 'Addr2');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (3, 'C', 'Black', 25, 7, 99, 'Addr3');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (4, 'D', 'White', 30, 7, 88, 'Addr4');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (5, 'E', 'White', 35, 8, 6, 'Addr5');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (6, 'F', 'Black', 40, 8, 77, 'Addr6');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (7, 'G', 'Black', 45, 9, 8, 'Addr7');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (8, 'H', 'White', 50, 9, 66, 'Addr8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address_other" AS "address" FROM (SELECT "level_of_membership" AS "member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address", "name_other", "membership_card_other", "age_other", "level_of_membership_other", "address_other" FROM (SELECT "LHS"."member_id" AS "member_id", "LHS"."name" AS "name", "LHS"."membership_card" AS "membership_card", "LHS"."age" AS "age", "LHS"."time_of_purchase" AS "time_of_purchase", "LHS"."level_of_membership" AS "level_of_membership", "LHS"."address" AS "address", "RHS"."name" AS "name_other", "RHS"."membership_card" AS "membership_card_other", "RHS"."age" AS "age_other", "RHS"."level_of_membership" AS "level_of_membership_other", "RHS"."address" AS "address_other" FROM "member" AS "LHS" INNER JOIN "member" AS "RHS" ON ("LHS"."time_of_purchase" = "RHS"."time_of_purchase" AND "LHS"."level_of_membership" = "RHS"."member_id"))) WHERE ("membership_card" = 'Black') ORDER BY address;

/*
Gold Result:
('Addr8',)
*/

-- Prediction Query
SELECT address FROM member EXCEPT SELECT address FROM member WHERE Membership_card = 'Black';

/*
Prediction Result:
('Addr2',)
('Addr4',)
('Addr5',)
('Addr8',)
*/