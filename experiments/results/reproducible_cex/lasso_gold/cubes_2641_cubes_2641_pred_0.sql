-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1001, 'purpose', 'site', 'dog', 'blue', 'wait');
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1002, 'brother', 'face', 'chair', 'require', 'offer');
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1003, 'ago', 'election', 'since', 'sit', 'begin');
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1004, 'Amanda Davis', '26542 Susan Junction Apt. 161
Melanieview, AS 06196', 'rise', 1007);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1005, 'Lance Hoffman', '1849 Ray Squares
North Donnaport, CO 31013', 'onto', 1018.0);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1006, 'Meredith Barnes', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'discuss', 1029.0);
INSERT INTO "stock" ("shop_id", "device_id", "quantity") VALUES (1004, 1001, 1010);
INSERT INTO "stock" ("shop_id", "device_id", "quantity") VALUES (1004, 1002, 1017.0);
INSERT INTO "stock" ("shop_id", "device_id", "quantity") VALUES (1004, 1003, 1024.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT carrier FROM (SELECT LHS.device_id AS device_id, LHS.device AS device, LHS.carrier AS carrier, LHS.package_version AS package_version, LHS.applications AS applications, LHS.software_platform AS software_platform, RHS.shop_id AS shop_id, RHS.n AS n FROM device AS LHS INNER JOIN (SELECT * FROM (SELECT device_id, shop_id, COUNT(*) AS n FROM stock GROUP BY device_id, shop_id) WHERE (n >= 1)) AS RHS ON (LHS.device_id = RHS.device_id)) ORDER BY carrier;

/*
Gold Result:
('election',)
('face',)
('site',)
*/

-- Prediction Query
SELECT T2.Carrier FROM stock AS T1 JOIN device AS T2 ON T1.Device_ID = T2.Device_ID GROUP BY T1.Device_ID HAVING COUNT(*) > 1;

/*
Prediction Result:
*/