-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1006, 'USNV Garcia
FPO AA 13177', 'her', 1007.5, 'blood');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1008, '525 Clark Grove Apt. 928
East Steven, KY 84387', 'trial', 1008.5, 'throw');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address FROM shop ORDER BY address, shop.shop_id NULLS LAST;

/*
Gold Result:
('525 Clark Grove Apt. 928\nEast Steven, KY 84387',)
('USNV Garcia\nFPO AA 13177',)
*/

-- Prediction Query
SELECT address FROM shop ORDER BY open_year, shop.shop_id NULLS LAST;

/*
Prediction Result:
('USNV Garcia\nFPO AA 13177',)
('525 Clark Grove Apt. 928\nEast Steven, KY 84387',)
*/