-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (DESC vs ASC), LIMIT 2 (vs LIMIT 1, 3, or no limit), and COUNT(*) vs COUNT(DISTINCT Shop_ID) or COUNT(DISTINCT HH_ID).
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (1, '100 Main St', '10', 4.5, '2015');
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (2, '200 Oak St', '20', 4.8, '2018');
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (1, 1, 'January', 5);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (2, 1, 'January', 2);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (3, 1, 'January', 1);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (4, 1, 'January', 1);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (1, 1, 'February', 10);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (1, 2, 'February', 10);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (2, 2, 'February', 10);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (5, 1, 'March', 50);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (6, 2, 'March', 50);
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (7, 1, 'April', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MONTH FROM (SELECT * FROM (SELECT * FROM (SELECT MONTH, COUNT(*) AS n FROM happy_hour GROUP BY MONTH) ORDER BY n DESC) LIMIT 2);

/*
Gold Result:
('January',)
('February',)
*/

-- Prediction Query
SELECT MONTH FROM happy_hour GROUP BY MONTH HAVING COUNT(*) > 2;

/*
Prediction Result:
('February',)
('January',)
*/