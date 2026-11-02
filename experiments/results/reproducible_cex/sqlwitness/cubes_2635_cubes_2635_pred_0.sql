-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO device (device_id, device, carrier, package_version, applications, software_platform) VALUES (1, 'Android', 'default2', 'Android', 'default2', 'default1'), (0, 'default2', 'default1', 'Android', 'default2', 'default2'), (2, 'Android', 'default2', NULL, 'Android', 'default1'), (3, 'Android', 'Android', 'default1', 'Android', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "carrier" FROM "device" WHERE ("software_platform" <> 'Android') ORDER BY carrier, device.device_id NULLS LAST;

/*
Gold Result:
('Android',)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Carrier FROM device WHERE Software_Platform <> 'Android';

/*
Prediction Result:
('default1',)
('default2',)
('default2',)
('Android',)
*/