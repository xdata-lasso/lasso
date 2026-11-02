-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: shop --
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (-2147483648, '5k5swwqcgs', '9n8', 874.871895, 'pgu7vfe4');

-- Inserting into table: happy_hour --
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483648, -2147483648, 'hap_50bd73', 1160656988);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483647, -2147483648, 'hap_50bd73', -252690330);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483646, -2147483648, 'hap_50bd73', -1670923962);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483645, -2147483648, 'hap_50bd73', 906324270);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483644, -2147483648, 'hap_50bd73', 2122220075);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483643, -2147483648, 'hap_50bd73', 13244799);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483642, -2147483648, 'hap_50bd73', 1019800248);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483641, -2147483648, 'hap_50bd73', 1526238907);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483640, -2147483648, 'hap_50bd73', -845863578);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483639, -2147483648, 'hap_50bd73', -1364429300);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483638, -2147483648, 'hap_50bd73', 462974032);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483637, -2147483648, 'hap_50bd73', 2026480202);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483636, -2147483648, 'hap_50bd73', -1602639011);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483635, -2147483648, 'hap_50bd73', -1209887326);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483634, -2147483648, 'hap_50bd73', 1151980946);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483633, -2147483648, 'hap_50bd73', 1038707349);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483632, -2147483648, 'hap_50bd73', 546571701);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483631, -2147483648, 'hap_50bd73', 1990080517);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483630, -2147483648, 'hap_50bd73', -1964997180);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483629, -2147483648, 'hap_50bd73', -1833165707);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483628, -2147483648, 'hap_50bd73', 1313172851);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (2, -2147483648, 'month_2', -53231346);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (3, -2147483648, 'month_3', -747753377);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483625, -2147483648, 'q_2_d02c67', 1119186446);

INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (-2147483624, -2147483648, 'q_2_d02c67', -967741825);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MONTH FROM (SELECT * FROM (SELECT * FROM (SELECT MONTH, COUNT(*) AS n FROM happy_hour GROUP BY MONTH) ORDER BY n DESC) LIMIT 2);

/*
Gold Result:
('hap_50bd73',)
('q_2_d02c67',)
*/

-- Prediction Query
SELECT MONTH FROM happy_hour GROUP BY MONTH HAVING COUNT(*) > 2;

/*
Prediction Result:
('hap_50bd73',)
*/