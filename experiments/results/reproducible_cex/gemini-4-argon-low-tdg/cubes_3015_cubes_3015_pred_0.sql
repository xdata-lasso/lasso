-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (1, 'Alice', 'Gold', 30, 5, 2, 'Hartford');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (2, 'Bob', 'Gold', 25, 3, 1, 'Hartford');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (3, 'Charlie', 'Silver', 40, 10, 3, 'Hartford');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (4, 'David', 'Bronze', 28, 2, 1, 'Hartford');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (5, 'Eve', NULL, 35, 7, 2, 'Hartford');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (6, 'Frank', NULL, 45, 1, 1, 'Hartford');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (7, 'Grace', 'Platinum', 50, 15, 4, 'Waterbury');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (8, 'Heidi', 'Diamond', 22, 1, 1, 'New Haven');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (9, 'Ivan', 'Titanium', 29, 4, 2, 'hartford');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (10, 'Judy', 'Copper', 31, 6, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "membership_card" FROM "member" WHERE ("address" = 'Hartford' AND "address" <> 'Waterbury') ORDER BY membership_card, "membership_card" NULLS LAST;

/*
Gold Result:
(None,)
('Bronze',)
('Gold',)
('Silver',)
*/

-- Prediction Query
SELECT membership_card FROM member WHERE address = 'Hartford' INTERSECT SELECT membership_card FROM member WHERE address = 'Waterbury';

/*
Prediction Result:
*/