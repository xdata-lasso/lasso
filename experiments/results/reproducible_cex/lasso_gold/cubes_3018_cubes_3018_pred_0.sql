-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1021, '38849 Hurst Locks Suite 328
Daviston, VI 14872', 'someone', 1026.5, 'forget');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1022, '691 James Mountain
Tashatown, TX 94967', 'show', 1035.5, 'inside');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1023, '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 'road', 1044.5, 'remain');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1024, '809 Burns Creek
Natashaport, IA 08093', 'deep', 1053.5, 'rate');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1025, '71822 Arroyo Expressway
Allisonchester, IL 71187', 'sell', 1062.5, 'hour');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1041, '0983 Adrian Station
East Carloston, VI 43810', 'particularly', 1046.5, 'former');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1042, '7382 Sanchez Mountains
Leeville, TN 56999', 'simply', 1055.5, 'art');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1043, '0106 Mcbride Coves Apt. 338
Taylorburgh, KY 61138', 'occur', 1064.5, 'apply');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1044, '8108 Tanya Terrace
East Richard, NJ 28517', 'ask', 1073.5, 'pattern');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1045, '60647 Henderson Street
Mooreport, IL 08166', 'small', 1082.5, 'me');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1061, '19136 Shelly Port
New Brooke, RI 11246', 'option', 1066.5, 'use');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1062, '3534 Anderson Rue Suite 751
South Christineshire, CT 10103', 'act', 1075.5, 'rock');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1063, '51354 Samuel Plains Suite 980
Sarahville, FM 18102', 'brother', 1084.5, 'well');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1064, '824 Jacobs Stravenue
Jamesview, NY 64533', 'bag', 1093.5, 'church');
INSERT INTO "shop" ("shop_id", "address", "num_of_staff", "score", "open_year") VALUES (1065, '64005 Dana Greens
Lake Scott, VT 56558', 'you', 1102.5, 'offer');
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1031, 1021, 'left', 1036);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1032, 1022, 'left', 1045.0);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1033, 1023, 'left', 1054.0);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1034, 1024, 'left', 1063.0);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1035, 1025, 'left', 1072.0);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1051, 1041, 'morning', NULL);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1052, 1042, 'morning', NULL);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1053, 1043, 'morning', NULL);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1054, 1044, 'morning', NULL);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1055, 1045, 'morning', NULL);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1071, 1061, 'morning', 1076);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1072, 1062, 'morning', 1085.0);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1073, 1063, 'morning', 1094.0);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1074, 1064, 'morning', 1103.0);
INSERT INTO "happy_hour" ("hh_id", "shop_id", "month", "num_of_shaff_in_charge") VALUES (1075, 1065, 'morning', 1112.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MONTH FROM (SELECT * FROM (SELECT * FROM (SELECT MONTH, COUNT(*) AS n FROM happy_hour GROUP BY MONTH) ORDER BY n DESC) LIMIT 2);

/*
Gold Result:
('morning',)
('left',)
*/

-- Prediction Query
SELECT MONTH FROM happy_hour GROUP BY MONTH HAVING COUNT(*) > 2;

/*
Prediction Result:
('left',)
('morning',)
*/