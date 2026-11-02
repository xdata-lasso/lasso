-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, address, num_of_staff, score, open_year) VALUES (2, 'default2', NULL, NULL, 'default2'), (0, 'default2', 'default2', 1.0, 'default1'), (1, 'default1', 'default2', 1.0, 'default2'), (3, NULL, 'default2', 2.0, NULL), (4, 'default1', 'default1', 2.0, NULL), (5, 'default1', 'default1', 2.0, 'default2'), (6, 'default2', 'default1', 1.0, 'default1'), (7, 'default2', NULL, 2.0, 'default1'), (8, NULL, 'default2', 0.0, 'default2');
INSERT INTO happy_hour (hh_id, shop_id, month, num_of_shaff_in_charge) VALUES (1, 3, 'default2', 0), (1, 6, 'default1', NULL), (1, 8, 'default2', 1), (2, 6, 'default2', 0), (2, 8, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address, num_of_staff FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM happy_hour AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY address, num_of_staff NULLS LAST;

/*
Gold Result:
('default1', 'default1')
('default1', 'default1')
('default1', 'default2')
('default2', 'default2')
('default2', None)
('default2', None)
*/

-- Prediction Query
SELECT address, num_of_staff FROM shop WHERE NOT shop_id IN (SELECT shop_id FROM happy_hour);

/*
Prediction Result:
('default2', 'default2')
('default1', 'default2')
('default2', None)
('default1', 'default1')
('default1', 'default1')
('default2', None)
*/