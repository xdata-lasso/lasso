-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (11, '14', NULL, 534, NULL);
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (28, '29', '16', 532, '18');
INSERT INTO "member" ("member_id", "name", "membership_card", "age", "time_of_purchase", "level_of_membership", "address") VALUES (12, '28', '28', 28, 28, 28, '28');
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (28, 28, '28', 28);
INSERT INTO "happy_hour_member" ("hh_id", "member_id", "total_amount") VALUES (28, 12, 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_id, address FROM (SELECT shop_id, address, num_of_staff, score, open_year, AVG(score) OVER () AS meanscore FROM shop) WHERE (meanscore > score) ORDER BY shop_id, address NULLS LAST;

/*
Gold Result:
(28, '29')
*/

-- Prediction Query
SELECT shop_id, address FROM shop WHERE score < (SELECT AVG(score) FROM shop);

/*
Prediction Result:
(28, '29')
*/