-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1017, '76483 Cameron Trail
East Lydiamouth, MO 35594', 'claim', 1021.5, 'notice');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1018, '76724 John Points Suite 969
Coxberg, NY 65187', 'hour', 1030.5, 'start');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1019, '22691 James Mountain
Tashatown, TX 94967', 'sound', 1039.5, 'win');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1020, '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 'color', 1048.5, 'nice');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1033, '4303 Christopher Oval
Port Amandaberg, DC 86975', 'health', 1037.5, 'treat');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1034, '8963 Jennifer Locks
Samuelhaven, NV 16361', 'land', 1046.5, 'shoulder');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1035, '0983 Adrian Station
East Carloston, VI 43810', 'item', 1055.5, 'arm');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1036, '7382 Sanchez Mountains
Leeville, TN 56999', 'manage', 1064.5, 'report');
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1025, 1017, 'why', 1029);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1026, 1018, 'why', 1038.0);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1027, 1019, 'why', 1047.0);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1028, 1020, 'why', 1056.0);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1041, 1033, 'ready', NULL);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1042, 1034, 'ready', NULL);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1043, 1035, 'ready', NULL);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1044, 1036, 'ready', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MONTH FROM (SELECT * FROM (SELECT * FROM (SELECT MONTH, COUNT(*) AS n FROM happy_hour GROUP BY MONTH) ORDER BY MONTH DESC) LIMIT 1);

/*
Gold Result:
('why',)
*/

-- Prediction Query
SELECT MONTH FROM happy_hour GROUP BY MONTH ORDER BY COUNT(*) DESC, MONTH NULLS LAST LIMIT 1;

/*
Prediction Result:
('ready',)
*/