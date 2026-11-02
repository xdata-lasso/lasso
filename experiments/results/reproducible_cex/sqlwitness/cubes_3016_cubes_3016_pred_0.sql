-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, address, num_of_staff, score, open_year) VALUES (1, 'May', 'May', 1.0, 'default1'), (0, 'default2', 'default1', 1.0, 'May'), (2, 'default1', NULL, 1.0, 'default2'), (3, 'default1', 'default1', 0.0, 'default1'), (4, NULL, 'default2', 0.0, 'default1'), (5, NULL, NULL, NULL, 'May'), (6, 'default1', NULL, NULL, NULL), (7, 'May', 'default1', 1.0, 'May'), (8, 'default2', NULL, 1.0, 'default2'), (9, 'default1', 'May', NULL, NULL), (10, 'default1', 'May', 1.0, 'default1'), (11, 'default1', 'default1', NULL, 'default2'), (12, 'default2', 'May', 0.0, NULL), (13, 'May', 'May', 1.0, NULL);
INSERT INTO happy_hour (hh_id, shop_id, month, num_of_shaff_in_charge) VALUES (0, 1, 'default2', 0), (1, 10, 'default2', 1), (1, 3, 'default2', NULL), (1, 6, 'May', NULL), (0, 2, 'May', 0), (0, 1, 'May', 0), (0, 4, 'May', 0), (1, 5, 'May', 1), (1, 7, 'May', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address", "shop_id" FROM (SELECT "LHS"."hh_id" AS "hh_id", "LHS"."shop_id" AS "shop_id", "LHS"."month" AS "month", "LHS"."num_of_shaff_in_charge" AS "num_of_shaff_in_charge", "RHS"."address" AS "address", "RHS"."num_of_staff" AS "num_of_staff", "RHS"."score" AS "score", "RHS"."open_year" AS "open_year" FROM (SELECT * FROM "happy_hour" WHERE ("month" = 'May')) AS LHS LEFT JOIN shop AS RHS ON (LHS.shop_id = RHS.shop_id)) ORDER BY address, "address" NULLS LAST, "shop_id" NULLS LAST;

/*
Gold Result:
(None, 4)
(None, 5)
('May', 1)
('May', 7)
('default1', 2)
('default1', 6)
*/

-- Prediction Query
SELECT t1.address, t1.shop_id FROM shop AS t1 JOIN happy_hour AS t2 ON t1.shop_id = t2.shop_id WHERE MONTH = 'May';

/*
Prediction Result:
('May', 1)
('default1', 2)
(None, 4)
(None, 5)
('default1', 6)
('May', 7)
*/