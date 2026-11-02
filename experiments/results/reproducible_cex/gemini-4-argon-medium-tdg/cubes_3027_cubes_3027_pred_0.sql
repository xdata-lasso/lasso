-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (1, 'Alice', 'Gold', 25, 10, 1, 'Addr1');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (2, 'Alice', 'Gold', 25, 10, 1, 'Addr1');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (3, NULL, 'Gold', 30, 12, 2, NULL);
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (4, 'Bob', 'Gold', 35, 15, 3, 'Addr2');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (5, 'Charlie', 'Gold', 40, 20, 4, 'Addr3');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (6, 'David', 'Bronze', 22, 5, 1, 'Addr4');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (7, 'Eve', 'Bronze', 23, 6, 1, 'Addr5');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (8, 'Frank', 'Bronze', 24, 7, 1, 'Addr6');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (9, 'Grace', 'Bronze', 25, 8, 1, 'Addr7');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (10, 'Heidi', 'Bronze', 26, 9, 1, 'Addr8');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (11, 'Ivan', 'Bronze', 27, 10, 1, 'Addr9');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (12, 'Judy', 'Silver', 28, 11, 2, 'Addr10');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (13, 'Karl', 'Silver', 29, 12, 2, 'Addr11');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (14, 'Leo', 'Silver', 30, 13, 2, 'Addr12');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (15, 'Mallory', 'Silver', 31, 14, 2, 'Addr13');
INSERT INTO "happy_hour_member" ("HH_ID", "Member_ID", "Total_amount") VALUES (1, 12, 50.0);
INSERT INTO "happy_hour_member" ("HH_ID", "Member_ID", "Total_amount") VALUES (2, 12, 60.0);
INSERT INTO "happy_hour_member" ("HH_ID", "Member_ID", "Total_amount") VALUES (3, 13, 70.0);
INSERT INTO "happy_hour_member" ("HH_ID", "Member_ID", "Total_amount") VALUES (4, 14, 80.0);
INSERT INTO "happy_hour_member" ("HH_ID", "Member_ID", "Total_amount") VALUES (5, 15, 90.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT membership_card FROM (SELECT membership_card, COUNT(*) AS n FROM member GROUP BY membership_card) WHERE (n >= 5) ORDER BY membership_card;

/*
Gold Result:
('Bronze',)
('Gold',)
*/

-- Prediction Query
SELECT Membership_card FROM member GROUP BY Membership_card HAVING COUNT(*) > 5;

/*
Prediction Result:
('Bronze',)
*/