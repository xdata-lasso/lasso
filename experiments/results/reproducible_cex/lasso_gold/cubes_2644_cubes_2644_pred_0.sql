-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1013, 'example', 'result', 'politics', 'none', 'common');
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1014, 'science', 'raise', 'prove', 'shoulder', 'maintain');
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1015, 'write', 'away', 'Congress', 'election', 'hundred');
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1025, 'could', 'born', 'fire', 'decide', 'color');
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1026, 'movement', 'truth', 'thought', 'claim', 'notice');
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1027, 'while', 'process', 'purpose', 'hour', 'start');
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1016, 'Timothy Watts', '30564 Jason Port Suite 376
Thomasberg, IA 98148', 'everyone', 1019);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1017, 'Timothy Watts', '969 Cox Dam Suite 101
Lake Ernest, TX 55834', 'month', 1030.0);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1018, 'Timothy Watts', '9784 Erin Crescent Suite 514
Mooretown, VA 94830', 'sound', 1041.0);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1028, NULL, '4303 Christopher Oval
Port Amandaberg, DC 86975', 'avoid', 1031);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1029, NULL, '8963 Jennifer Locks
Samuelhaven, NV 16361', 'my', 1042.0);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1030, NULL, '0983 Adrian Station
East Carloston, VI 43810', 'economy', 1053.0);
INSERT INTO "stock" ("shop_id", "device_id", "quantity") VALUES (1016, 1013, 1022);
INSERT INTO "stock" ("shop_id", "device_id", "quantity") VALUES (1016, 1014, 1029.0);
INSERT INTO "stock" ("shop_id", "device_id", "quantity") VALUES (1016, 1015, 1036.0);
INSERT INTO "stock" ("shop_id", "device_id", "quantity") VALUES (1028, 1025, 1034);
INSERT INTO "stock" ("shop_id", "device_id", "quantity") VALUES (1028, 1026, 1041.0);
INSERT INTO "stock" ("shop_id", "device_id", "quantity") VALUES (1028, 1027, 1048.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT shop_id, shop_name, COUNT(*) AS n FROM (SELECT LHS.shop_id AS shop_id, LHS.shop_name AS shop_name, LHS.location AS LOCATION, LHS.open_date AS open_date, LHS.open_year AS open_year, RHS.device_id AS device_id, RHS.quantity AS quantity FROM shop AS LHS INNER JOIN stock AS RHS ON (LHS.shop_id = RHS.shop_id)) GROUP BY shop_id, shop_name) WHERE (n > 1) ORDER BY shop_name;

/*
Gold Result:
(None,)
('Timothy Watts',)
*/

-- Prediction Query
SELECT T2.Shop_Name FROM stock AS T1 JOIN shop AS T2 ON T1.Shop_ID = T2.Shop_ID GROUP BY T1.Shop_ID HAVING COUNT(*) > 1;

/*
Prediction Result:
('Timothy Watts',)
(None,)
*/