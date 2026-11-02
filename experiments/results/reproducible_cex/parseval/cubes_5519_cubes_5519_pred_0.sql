-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: shop --
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1, '5k5swwqcgs', '9n8', 874.871895, 'pgu7vfe4');

-- Inserting into table: happy_hour --
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, 1, 'hap_cc8b7d', 1160656988);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, 1, 'lhs_1f57af', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1, 1, 'lhs_738224', 1);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483647, 1, 'q_2_b55ea3', -252690330);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483646, 1, 'q_2_b55ea3', -1670923962);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (2, 1, 'month_5', 906324270);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (3, 1, 'month_6', 2122220075);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (4, 1, 'month_7', 13244799);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (5, 1, 'month_8', 1019800248);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MONTH FROM (SELECT MONTH, num_of_shaff_in_charge, MAX(n) AS maxn FROM (SELECT hh_id, shop_id, MONTH, num_of_shaff_in_charge, num_of_shaff_in_charge AS n FROM (SELECT LHS.hh_id AS hh_id, LHS.shop_id AS shop_id, LHS.month AS MONTH, LHS.num_of_shaff_in_charge AS num_of_shaff_in_charge FROM happy_hour AS LHS INNER JOIN (SELECT MONTH, COUNT(*) AS n FROM happy_hour GROUP BY MONTH) AS RHS ON (LHS.num_of_shaff_in_charge = RHS.n AND LHS.month = RHS.month))) GROUP BY MONTH, num_of_shaff_in_charge) ORDER BY MONTH;

/*
Gold Result:
('lhs_1f57af',)
('lhs_738224',)
*/

-- Prediction Query
SELECT MONTH FROM happy_hour GROUP BY MONTH ORDER BY COUNT(*) DESC, MONTH NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_2_b55ea3',)
*/