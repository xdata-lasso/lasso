-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (1, '123 Main St', '10', 4.5, '2015');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (2, '456 Oak Ave', '5', 3.8, '2018');
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (1, 1, 'Jan', 1);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (2, 1, 'Feb', 2);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (3, 2, 'Feb', 2);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (4, 1, 'Mar', 5);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (5, 2, 'Mar', 1);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (6, 1, 'Apr', 3);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (7, 2, 'Apr', 1);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (8, 1, 'Apr', 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MONTH FROM (SELECT MONTH, num_of_shaff_in_charge, MAX(n) AS maxn FROM (SELECT hh_id, shop_id, MONTH, num_of_shaff_in_charge, num_of_shaff_in_charge AS n FROM (SELECT LHS.hh_id AS hh_id, LHS.shop_id AS shop_id, LHS.month AS MONTH, LHS.num_of_shaff_in_charge AS num_of_shaff_in_charge FROM happy_hour AS LHS INNER JOIN (SELECT MONTH, COUNT(*) AS n FROM happy_hour GROUP BY MONTH) AS RHS ON (LHS.num_of_shaff_in_charge = RHS.n AND LHS.month = RHS.month))) GROUP BY MONTH, num_of_shaff_in_charge) ORDER BY MONTH;

/*
Gold Result:
('Apr',)
('Feb',)
('Jan',)
*/

-- Prediction Query
SELECT MONTH FROM happy_hour GROUP BY MONTH ORDER BY COUNT(*) DESC, MONTH NULLS LAST LIMIT 1;

/*
Prediction Result:
('Apr',)
*/