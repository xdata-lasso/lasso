-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, shop_name, location, open_date, open_year) VALUES (0, 'default2', 'default1', 'default1', 0), (2, NULL, 'default1', 'default1', 0), (1, 'default2', NULL, 'default1', 1), (3, 'default1', 'default1', NULL, NULL), (4, NULL, 'default1', 'default1', 0), (5, 'default1', NULL, NULL, 1), (6, 'default2', NULL, 'default1', 0);
INSERT INTO device (device_id, device, carrier, package_version, applications, software_platform) VALUES (0, 'default1', NULL, 'default2', 'default2', 'default1'), (1, 'default1', 'default1', 'default2', NULL, NULL), (2, 'default2', NULL, NULL, 'default2', NULL), (3, 'default2', 'default1', NULL, 'default1', 'default2'), (4, 'default2', 'default1', 'default1', NULL, NULL), (5, NULL, 'default1', NULL, NULL, NULL), (6, 'default1', NULL, NULL, 'default2', 'default1'), (7, 'default2', 'default1', 'default2', 'default1', 'default2'), (8, 'default2', NULL, NULL, 'default2', NULL), (9, NULL, 'default1', 'default2', NULL, 'default1'), (10, NULL, 'default2', 'default1', NULL, 'default2'), (11, 'default1', 'default1', 'default1', 'default1', 'default2');
INSERT INTO stock (shop_id, device_id, quantity) VALUES (3, 5, 2), (6, 1, 0), (4, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY shop_name;

/*
Gold Result:
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop WHERE NOT Shop_ID IN (SELECT Shop_ID FROM stock);

/*
Prediction Result:
('default2',)
('default2',)
(None,)
('default1',)
*/