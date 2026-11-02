-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'PhoneA', 'CarrierB', '1.0', 'App1', 'OS1');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'PhoneB', 'CarrierA', '1.0', 'App1', 'OS1');
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (1, 'ShopB', 'Loc1', '2020-01-01', 2020);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (2, 'ShopA', 'Loc2', '2020-01-01', 2020);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (1, 1, 10);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (2, 2, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name, carrier FROM (SELECT LHS.device_id AS device_id, LHS.device AS device, LHS.carrier AS carrier, LHS.package_version AS package_version, LHS.applications AS applications, LHS.software_platform AS software_platform, LHS.shop_id AS shop_id, LHS.shop_name AS shop_name, LHS.location AS LOCATION, LHS.open_date AS open_date, LHS.open_year AS open_year, RHS.quantity AS quantity FROM (SELECT LHS.device_id AS device_id, LHS.device AS device, LHS.carrier AS carrier, LHS.package_version AS package_version, LHS.applications AS applications, LHS.software_platform AS software_platform, RHS.shop_id AS shop_id, RHS.shop_name AS shop_name, RHS.location AS LOCATION, RHS.open_date AS open_date, RHS.open_year AS open_year FROM device AS LHS CROSS JOIN shop AS RHS) AS LHS INNER JOIN stock AS RHS ON (LHS.device_id = RHS.device_id AND LHS.shop_id = RHS.shop_id)) ORDER BY shop_name, carrier NULLS LAST;

/*
Gold Result:
('ShopA', 'CarrierA')
('ShopB', 'CarrierB')
*/

-- Prediction Query
SELECT T3.Shop_Name, T2.Carrier FROM stock AS T1 JOIN device AS T2 ON T1.Device_ID = T2.Device_ID JOIN shop AS T3 ON T1.Shop_ID = T3.Shop_ID;

/*
Prediction Result:
('ShopB', 'CarrierB')
('ShopA', 'CarrierA')
*/