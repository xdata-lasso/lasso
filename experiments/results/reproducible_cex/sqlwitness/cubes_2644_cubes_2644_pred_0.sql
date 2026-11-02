-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, shop_name, location, open_date, open_year) VALUES (1, 'default2', 'default2', 'default1', NULL), (2, NULL, 'default1', 'default1', 0), (0, 'default1', NULL, 'default1', 2), (3, 'default1', NULL, 'default2', NULL), (4, NULL, NULL, 'default2', 0), (5, 'default1', NULL, 'default1', 2), (6, NULL, 'default1', NULL, 0);
INSERT INTO device (device_id, device, carrier, package_version, applications, software_platform) VALUES (2, 'default2', 'default2', NULL, 'default2', 'default1'), (0, 'default1', 'default1', 'default2', NULL, 'default1'), (1, 'default1', 'default2', 'default1', 'default1', 'default2'), (3, 'default1', 'default1', NULL, 'default1', NULL), (4, 'default1', 'default1', 'default2', 'default1', 'default2'), (5, 'default1', NULL, NULL, NULL, 'default2'), (6, 'default2', 'default2', NULL, 'default1', 'default2'), (7, NULL, 'default2', 'default1', 'default1', NULL), (8, NULL, NULL, 'default1', 'default2', 'default1'), (9, 'default2', NULL, NULL, 'default1', 'default1'), (10, 'default2', 'default2', 'default1', 'default1', 'default1'), (11, NULL, 'default2', 'default2', NULL, NULL), (12, NULL, 'default1', 'default2', 'default1', 'default2'), (13, 'default2', 'default1', NULL, 'default1', 'default2'), (14, 'default1', NULL, NULL, 'default2', NULL), (15, NULL, NULL, NULL, NULL, 'default2'), (16, 'default2', 'default2', NULL, 'default2', 'default1'), (17, 'default1', NULL, 'default2', NULL, 'default1'), (18, 'default1', 'default2', NULL, NULL, 'default1'), (19, 'default1', 'default1', NULL, 'default1', NULL), (20, 'default1', 'default2', 'default1', 'default2', 'default2');
INSERT INTO stock (shop_id, device_id, quantity) VALUES (5, 20, 2), (4, 4, NULL), (6, 17, 2), (1, 8, 2), (5, 10, NULL), (1, 2, NULL), (0, 14, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT shop_id, shop_name, COUNT(*) AS n FROM (SELECT LHS.shop_id AS shop_id, LHS.shop_name AS shop_name, LHS.location AS LOCATION, LHS.open_date AS open_date, LHS.open_year AS open_year, RHS.device_id AS device_id, RHS.quantity AS quantity FROM shop AS LHS INNER JOIN stock AS RHS ON (LHS.shop_id = RHS.shop_id)) GROUP BY shop_id, shop_name) WHERE (n > 1) ORDER BY shop_name;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T2.Shop_Name FROM stock AS T1 JOIN shop AS T2 ON T1.Shop_ID = T2.Shop_ID GROUP BY T1.Shop_ID HAVING COUNT(*) > 1;

/*
Prediction Result:
('default2',)
('default1',)
*/