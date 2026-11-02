-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1001, 'Allison Hill', 'offer', 1006, 1011, 1016, '402 Peterson Drives Apt. 511
Davisstad, PA 35172');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1002, 'Noah Rhodes', 'offer', 1015.0, 1022.0, 1029.0, '161 Calderon River Suite 931
Lake Jeremyport, CO 31013');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1003, 'Angie Henderson', 'offer', 1024.0, 1033.0, 1042.0, '7525 Clark Grove Apt. 928
East Steven, KY 84387');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1004, 'Daniel Wagner', 'offer', 1033.0, 1044.0, 1055.0, '503 Linda Locks
Carlshire, FM 94599');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (1005, 'Cristian Santos', 'offer', 1042.0, 1055.0, 1068.0, '7242 Julie Plain Suite 969
Coxberg, NY 65187');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT membership_card FROM (SELECT membership_card, COUNT(*) AS n FROM member GROUP BY membership_card) WHERE (n >= 5) ORDER BY membership_card;

/*
Gold Result:
('offer',)
*/

-- Prediction Query
SELECT Membership_card FROM member GROUP BY Membership_card HAVING COUNT(*) > 5;

/*
Prediction Result:
*/