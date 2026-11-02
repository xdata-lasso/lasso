-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (1, '100 A St', '10', 10.0, '2010');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (2, '200 B St', '20', 20.0, '2015');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (3, '300 C St', '30', 30.0, '2020');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (1, 'Alice', 'Gold', 30, 5, 2, '100 A St');
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (1, 1, 'June', 1);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (2, 2, 'May', 4);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (3, 2, 'May', 5);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (4, 3, 'April', 10);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (5, 3, 'April', 10);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (6, 3, 'April', 10);
INSERT INTO happy_hour_member (HH_ID, Member_ID, Total_amount) VALUES (1, 1, 50.0);
INSERT INTO happy_hour_member (HH_ID, Member_ID, Total_amount) VALUES (4, 1, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MONTH FROM (SELECT * FROM (SELECT * FROM (SELECT MONTH, COUNT(*) AS n FROM happy_hour GROUP BY MONTH) ORDER BY MONTH DESC) LIMIT 1);

/*
Gold Result:
('May',)
*/

-- Prediction Query
SELECT MONTH FROM happy_hour GROUP BY MONTH ORDER BY COUNT(*) DESC, MONTH NULLS LAST LIMIT 1;

/*
Prediction Result:
('April',)
*/