-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1001, '433 Jill Springs
New Roberttown, CO 29158', 'hear', 1005.5, 'science');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1002, '386 Shane Harbors
Port Lindachester, MA 36922', 'determine', 1014.5, 'write');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1003, '16155 Roman Stream Suite 816
New Kellystad, OK 25704', 'religious', 1023.5, 'result');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1004, '341 Michelle Light
Shawnstad, GA 49021', 'example', 1032.5, 'raise');
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1009, 1001, 'away', 1013);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1009, 1002, 'politics', 1013);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1009, 1003, 'prove', 1013);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1009, 1004, 'Congress', 1013);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS shop_id, num_of_shaff_in_charge AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT hh_id, num_of_shaff_in_charge, COUNT(*) AS n FROM happy_hour GROUP BY hh_id, num_of_shaff_in_charge) ORDER BY hh_id DESC) LIMIT 1);

/*
Gold Result:
(4, 1013)
*/

-- Prediction Query
SELECT shop_id, COUNT(*) FROM happy_hour GROUP BY shop_id ORDER BY COUNT(*) DESC, shop_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1001, 1)
*/