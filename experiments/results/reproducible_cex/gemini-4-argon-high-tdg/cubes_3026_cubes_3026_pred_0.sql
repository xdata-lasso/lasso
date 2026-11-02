-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (1, 'Alice', 'Silver', 30, 10, 99, 'Zeta Ave');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (2, 'Charlie', 'Gold', 40, 20, 88, 'Beta Rd');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (3, 'Eve', 'Silver', 28, 30, 77, 'Decoy Time Low');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (4, 'Grace', 'Silver', 45, 32, 66, 'Decoy Time High');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (5, 'Heidi', 'Black', 50, 50, 95, 'Wrong RHS Black Addr');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (6, 'Ivan', 'Black', 22, 60, 98, 'Swapped LHS Addr');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (10, 'Bob', 'Black', 25, 10, 1, 'Alpha St');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (20, 'Diana', 'Black', 35, 20, 2, 'Omega Blvd');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (30, 'Frank', 'Black', 28, 31, 3, 'Frank Addr');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (40, 'Judy', 'Black', 45, 31, 4, 'Judy Addr');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (50, 'Mallory', 'Gold', 50, 50, 5, 'Mallory Addr');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (60, 'Niaj', 'Silver', 22, 60, 6, 'Swapped RHS Addr');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address_other" AS "address" FROM (SELECT "level_of_membership" AS "member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address", "name_other", "membership_card_other", "age_other", "level_of_membership_other", "address_other" FROM (SELECT "LHS"."member_id" AS "member_id", "LHS"."name" AS "name", "LHS"."membership_card" AS "membership_card", "LHS"."age" AS "age", "LHS"."time_of_purchase" AS "time_of_purchase", "LHS"."level_of_membership" AS "level_of_membership", "LHS"."address" AS "address", "RHS"."name" AS "name_other", "RHS"."membership_card" AS "membership_card_other", "RHS"."age" AS "age_other", "RHS"."level_of_membership" AS "level_of_membership_other", "RHS"."address" AS "address_other" FROM "member" AS "LHS" INNER JOIN "member" AS "RHS" ON ("LHS"."time_of_purchase" = "RHS"."time_of_purchase" AND "LHS"."level_of_membership" = "RHS"."member_id"))) WHERE ("membership_card" = 'Black') ORDER BY address;

/*
Gold Result:
('Beta Rd',)
('Zeta Ave',)
*/

-- Prediction Query
SELECT address FROM member EXCEPT SELECT address FROM member WHERE Membership_card = 'Black';

/*
Prediction Result:
('Beta Rd',)
('Decoy Time High',)
('Decoy Time Low',)
('Mallory Addr',)
('Swapped RHS Addr',)
('Zeta Ave',)
*/