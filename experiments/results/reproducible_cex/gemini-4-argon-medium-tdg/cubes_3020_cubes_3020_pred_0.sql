-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (1, NULL, '15', 4.1, '2011');
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (2, '100 Main St', NULL, 4.3, '2013');
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (3, '100 Main St', '20', 4.5, '2014');
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (4, '100 Main St', '5', 3.9, '2016');
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (5, '500 Elm St', '10', 4.0, '2017');
INSERT INTO "happy_hour" ("HH_ID", "Shop_ID", "Month", "Num_of_shaff_in_charge") VALUES (1, 5, 'June', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address, num_of_staff FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM happy_hour AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY address, num_of_staff NULLS LAST;

/*
Gold Result:
(None, '15')
('100 Main St', '20')
('100 Main St', '5')
('100 Main St', None)
*/

-- Prediction Query
SELECT address, num_of_staff FROM shop WHERE NOT shop_id IN (SELECT shop_id FROM happy_hour);

/*
Prediction Result:
(None, '15')
('100 Main St', None)
('100 Main St', '20')
('100 Main St', '5')
*/