-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (101, '123 Main St', '10', 4.5, '2015');
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (102, '456 Oak Ave', '15', 4.0, '2018');
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (1, 101, 'Jan', 10);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (1, 101, 'Feb', 10);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (1, 102, 'Jan', 10);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (1, 102, 'Feb', 10);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (5, 101, 'Jan', 20);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (5, 101, 'Feb', 20);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (5, 102, 'Jan', 20);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (10, 101, 'Jan', 5);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (10, 102, 'Feb', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS shop_id, num_of_shaff_in_charge AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT hh_id, num_of_shaff_in_charge, COUNT(*) AS n FROM happy_hour GROUP BY hh_id, num_of_shaff_in_charge) ORDER BY hh_id DESC) LIMIT 1);

/*
Gold Result:
(2, 5)
*/

-- Prediction Query
SELECT shop_id, COUNT(*) FROM happy_hour GROUP BY shop_id ORDER BY COUNT(*) DESC, shop_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(101, 5)
*/