-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, shop_name, location, open_date, open_year) VALUES (1, NULL, NULL, 'default1', NULL), (2, 'default2', 'default1', 'default1', 0), (0, 'default2', 'default2', NULL, 1), (3, 'default1', 'default2', 'default2', 0), (4, NULL, NULL, 'default2', 2), (5, 'default2', NULL, 'default2', 0), (6, 'default1', NULL, 'default1', 2), (7, NULL, 'default2', 'default1', NULL);
INSERT INTO device (device_id, device, carrier, package_version, applications, software_platform) VALUES (1, 'default1', 'default2', 'default1', 'default2', NULL), (2, NULL, 'default1', NULL, 'default2', 'default2'), (0, 'default1', 'default1', 'default1', 'default1', 'default1'), (3, NULL, NULL, 'default2', 'default2', NULL), (4, 'default2', NULL, 'default1', 'default1', 'default2'), (5, NULL, NULL, NULL, NULL, 'default1'), (6, 'default1', 'default1', 'default2', 'default2', NULL), (7, NULL, 'default1', 'default1', 'default1', 'default2');
INSERT INTO stock (shop_id, device_id, quantity) VALUES (0, 0, 2), (1, 1, 1), (6, 4, 0), (3, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT carrier FROM (SELECT LHS.device_id AS device_id, LHS.device AS device, LHS.carrier AS carrier, LHS.package_version AS package_version, LHS.applications AS applications, LHS.software_platform AS software_platform, RHS.shop_id AS shop_id, RHS.n AS n FROM device AS LHS INNER JOIN (SELECT * FROM (SELECT device_id, shop_id, COUNT(*) AS n FROM stock GROUP BY device_id, shop_id) WHERE (n >= 1)) AS RHS ON (LHS.device_id = RHS.device_id)) ORDER BY carrier;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T2.Carrier FROM stock AS T1 JOIN device AS T2 ON T1.Device_ID = T2.Device_ID GROUP BY T1.Device_ID HAVING COUNT(*) > 1;

/*
Prediction Result:
('default1',)
*/