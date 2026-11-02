-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (1, '742 Evergreen Terrace', '12', 4.5, '2010');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (2, '221B Baker Street', '8', 4.9, '2005');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (3, '1600 Pennsylvania Ave', '25', 3.8, '2018');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (4, '350 Fifth Avenue', '5', 2.9, '1999');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (1, 'Alice Smith', 'Gold', 30, 10, 3, '999 Member Lane');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (2, 'Bob Jones', 'Silver', 25, 4, 1, '888 Subscriber Rd');
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (1, 2, 'May', 3);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (4, 2, 'June', 4);
INSERT INTO happy_hour_member (HH_ID, Member_ID, Total_amount) VALUES (1, 1, 120.5);
INSERT INTO happy_hour_member (HH_ID, Member_ID, Total_amount) VALUES (4, 2, 45.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address, num_of_staff FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM happy_hour AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY address, num_of_staff NULLS LAST;

/*
Gold Result:
('1600 Pennsylvania Ave', '25')
('350 Fifth Avenue', '5')
('742 Evergreen Terrace', '12')
*/

-- Prediction Query
SELECT address, num_of_staff FROM shop WHERE NOT shop_id IN (SELECT shop_id FROM happy_hour);

/*
Prediction Result:
('742 Evergreen Terrace', '12')
('1600 Pennsylvania Ave', '25')
('350 Fifth Avenue', '5')
*/