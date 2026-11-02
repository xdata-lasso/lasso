-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (1, 'Oak St', '10', 4.5, '2015');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (2, 'Elm St', '5', 3.0, '2018');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (3, 'Maple Ave', '20', 4.8, '2010');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (4, 'Elm St', '12', 2.5, '2020');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (1, 'Alice', 'Gold', 30, 5, 2, 'Pine Rd');
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (1, 1, 'Jan', 3);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (2, 1, 'Feb', 4);
INSERT INTO happy_hour_member (HH_ID, Member_ID, Total_amount) VALUES (1, 1, 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address FROM shop ORDER BY address, shop.shop_id NULLS LAST;

/*
Gold Result:
('Elm St',)
('Elm St',)
('Maple Ave',)
('Oak St',)
*/

-- Prediction Query
SELECT address FROM shop ORDER BY open_year, shop.shop_id NULLS LAST;

/*
Prediction Result:
('Maple Ave',)
('Oak St',)
('Elm St',)
('Elm St',)
*/