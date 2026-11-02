-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering (<> 'Android', case sensitivity, substring matching, NULL handling in WHERE)
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'iPhone 13', 'Verizon', '1.0', 'Maps', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'Galaxy S21', 'AT&T', '2.0', 'Browser', 'Android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (3, 'Pixel 6', 'T-Mobile', '3.0', 'Mail', 'android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (4, 'Lumia 950', 'Sprint', '4.0', 'Office', 'Windows');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (5, 'OnePlus 9', 'Unlocked', '5.0', 'Games', 'Android 11');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (6, 'Prototype', 'TestCarrier', '0.1', 'None', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "carrier" FROM "device" WHERE ("software_platform" <> 'Android') ORDER BY carrier, device.device_id NULLS LAST;

/*
Gold Result:
('Sprint',)
('T-Mobile',)
('Unlocked',)
('Verizon',)
*/

-- Prediction Query
SELECT Carrier FROM device WHERE Software_Platform <> 'Android';

/*
Prediction Result:
('Verizon',)
('T-Mobile',)
('Sprint',)
('Unlocked',)
*/