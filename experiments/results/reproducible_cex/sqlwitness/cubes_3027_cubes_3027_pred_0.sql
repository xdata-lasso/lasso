-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO member (member_id, name, membership_card, age, time_of_purchase, level_of_membership, address) VALUES (5, 'default2', 'default1', 4, 5, 0, NULL), (1, 'default1', 'default1', 6, 0, NULL, 'default2'), (0, 'default2', NULL, 5, 0, 4, 'default2'), (6, 'default2', NULL, NULL, 1, 1, NULL), (4, NULL, 'default2', 1, 1, 5, 'default2'), (2, 'default1', NULL, NULL, 0, NULL, 'default1'), (3, NULL, 'default2', 6, 1, 1, NULL), (7, 'default2', NULL, NULL, 0, 6, 'default1'), (8, NULL, NULL, 5, 1, 4, 'default1'), (9, 'default2', 'default1', 6, NULL, 0, NULL), (10, 'default1', 'default1', NULL, 6, 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT membership_card FROM (SELECT membership_card, COUNT(*) AS n FROM member GROUP BY membership_card) WHERE (n >= 5) ORDER BY membership_card;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Membership_card FROM member GROUP BY Membership_card HAVING COUNT(*) > 5;

/*
Prediction Result:
*/