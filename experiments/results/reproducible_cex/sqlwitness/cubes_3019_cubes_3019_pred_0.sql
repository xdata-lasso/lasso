-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO member (member_id, name, membership_card, age, time_of_purchase, level_of_membership, address) VALUES (0, 'default2', NULL, 1, NULL, NULL, 'default1'), (1, NULL, NULL, NULL, 1, 1, 'default2'), (2, 'default2', 'default2', 1, 0, 0, NULL), (3, 'default2', 'default1', NULL, 1, NULL, NULL), (4, 'default1', NULL, 0, 1, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, address FROM (SELECT address, COUNT(*) AS n FROM member GROUP BY address) ORDER BY count___, address NULLS LAST;

/*
Gold Result:
(1, 'default2')
(2, 'default1')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), address FROM member GROUP BY address;

/*
Prediction Result:
(2, None)
(2, 'default1')
(1, 'default2')
*/