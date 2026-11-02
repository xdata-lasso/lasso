-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicate addresses (DISTINCT vs ALL), and column confusion (shop.Address vs member.Address)
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (1, '200 Oak St', '10', 4.5, '2010');
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (2, '100 Main St', '8', 3.8, '2012');
INSERT INTO "shop" ("Shop_ID", "Address", "Num_of_staff", "Score", "Open_Year") VALUES (3, '100 Main St', '15', 4.9, '2008');
INSERT INTO "member" ("Member_ID", "Name", "Membership_card", "Age", "Time_of_purchase", "Level_of_membership", "Address") VALUES (1, 'Alice', 'Gold', 30, 5, 2, '999 Wrong Table Ave');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address FROM shop ORDER BY address, shop.shop_id NULLS LAST;

/*
Gold Result:
('100 Main St',)
('100 Main St',)
('200 Oak St',)
*/

-- Prediction Query
SELECT address FROM shop ORDER BY open_year, shop.shop_id NULLS LAST;

/*
Prediction Result:
('100 Main St',)
('200 Oak St',)
('100 Main St',)
*/