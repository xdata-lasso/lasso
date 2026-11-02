-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1015, 'PSC 9537, Box 6724
APO AE 32826', 'everyone', 1016.5, 'newspaper');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1017, '184 Rodriguez Mews
South Aaron, VA 94830', 'size', 1017.5, 'option');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address, num_of_staff FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM happy_hour AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY address, num_of_staff NULLS LAST;

/*
Gold Result:
('184 Rodriguez Mews\nSouth Aaron, VA 94830', 'size')
('PSC 9537, Box 6724\nAPO AE 32826', 'everyone')
*/

-- Prediction Query
SELECT address, num_of_staff FROM shop WHERE NOT shop_id IN (SELECT shop_id FROM happy_hour);

/*
Prediction Result:
('PSC 9537, Box 6724\nAPO AE 32826', 'everyone')
('184 Rodriguez Mews\nSouth Aaron, VA 94830', 'size')
*/