-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, shop_name, location, open_date, open_year) VALUES (1, 'default2', NULL, 'default2', NULL), (0, 'default1', NULL, 'default1', 1), (2, NULL, 'default2', 'default1', 1), (3, 'default1', 'default1', 'default2', NULL), (4, 'default1', 'default2', 'default2', NULL), (5, 'default1', 'default1', 'default1', 0), (6, 'default1', 'default2', 'default2', 1);
INSERT INTO device (device_id, device, carrier, package_version, applications, software_platform) VALUES (1, NULL, 'default1', 'default1', NULL, NULL), (0, 'default2', 'default2', 'default1', 'default2', NULL), (2, 'default2', NULL, 'default2', NULL, NULL), (3, NULL, 'default2', 'default2', NULL, 'default2'), (4, 'default2', 'default2', 'default1', 'default1', 'default2'), (5, NULL, 'default2', NULL, 'default2', 'default1'), (6, NULL, NULL, 'default2', 'default1', 'default2');
INSERT INTO stock (shop_id, device_id, quantity) VALUES (5, 5, 0), (3, 4, 1), (1, 1, 1), (2, 0, 0), (0, 6, 1), (2, 2, NULL), (1, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name, carrier FROM (SELECT LHS.device_id AS device_id, LHS.device AS device, LHS.carrier AS carrier, LHS.package_version AS package_version, LHS.applications AS applications, LHS.software_platform AS software_platform, LHS.shop_id AS shop_id, LHS.shop_name AS shop_name, LHS.location AS LOCATION, LHS.open_date AS open_date, LHS.open_year AS open_year, RHS.quantity AS quantity FROM (SELECT LHS.device_id AS device_id, LHS.device AS device, LHS.carrier AS carrier, LHS.package_version AS package_version, LHS.applications AS applications, LHS.software_platform AS software_platform, RHS.shop_id AS shop_id, RHS.shop_name AS shop_name, RHS.location AS LOCATION, RHS.open_date AS open_date, RHS.open_year AS open_year FROM device AS LHS CROSS JOIN shop AS RHS) AS LHS INNER JOIN stock AS RHS ON (LHS.device_id = RHS.device_id AND LHS.shop_id = RHS.shop_id)) ORDER BY shop_name, carrier NULLS LAST;

/*
Gold Result:
(None, 'default2')
(None, None)
('default1', 'default2')
('default1', 'default2')
('default1', None)
('default2', 'default1')
('default2', 'default2')
*/

-- Prediction Query
SELECT T3.Shop_Name, T2.Carrier FROM stock AS T1 JOIN device AS T2 ON T1.Device_ID = T2.Device_ID JOIN shop AS T3 ON T1.Shop_ID = T3.Shop_ID;

/*
Prediction Result:
('default1', None)
('default2', 'default2')
('default2', 'default1')
(None, 'default2')
(None, None)
('default1', 'default2')
('default1', 'default2')
*/