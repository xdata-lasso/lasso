-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, shop_name, location, open_date, open_year) VALUES (2, 'default1', 'default2', NULL, NULL), (0, NULL, 'default2', NULL, 1), (1, 'default1', 'default1', 'default2', 0), (3, 'default1', 'default2', 'default1', 2), (4, NULL, NULL, NULL, NULL), (5, NULL, 'default2', NULL, 1), (6, 'default2', 'default2', NULL, 1);
INSERT INTO device (device_id, device, carrier, package_version, applications, software_platform) VALUES (0, 'default2', 'default1', 'default1', 'default1', 'default1'), (1, 'default1', 'default2', 'default2', NULL, 'default1'), (2, 'default2', 'default2', 'default1', NULL, 'default1'), (3, 'default2', 'default1', 'default2', 'default2', 'default2'), (4, 'default2', 'default2', 'default1', 'default1', 'default1'), (5, 'default2', 'default1', 'default1', 'default1', NULL);
INSERT INTO stock (shop_id, device_id, quantity) VALUES (5, 0, 0), (4, 4, 2), (1, 4, 2), (4, 3, NULL), (2, 1, 1), (1, 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM device AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.device_id = RHS.device_id))) ORDER BY carrier;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Carrier FROM device WHERE NOT Device_ID IN (SELECT Device_ID FROM stock);

/*
Prediction Result:
('default2',)
('default1',)
*/