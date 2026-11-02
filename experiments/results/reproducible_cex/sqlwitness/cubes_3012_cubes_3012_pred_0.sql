-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, address, num_of_staff, score, open_year) VALUES (1, NULL, 'default2', 0.0, NULL), (0, 'default2', 'default1', 0.0, 'default2'), (2, 'default2', 'default2', NULL, 'default1'), (3, 'default2', 'default1', NULL, NULL), (4, 'default2', NULL, 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_id, address FROM (SELECT shop_id, address, num_of_staff, score, open_year, AVG(score) OVER () AS meanscore FROM shop) WHERE (meanscore > score) ORDER BY shop_id, address NULLS LAST;

/*
Gold Result:
(0, 'default2')
(1, None)
*/

-- Prediction Query
SELECT shop_id, address FROM shop WHERE score < (SELECT AVG(score) FROM shop);

/*
Prediction Result:
(0, 'default2')
(1, None)
*/