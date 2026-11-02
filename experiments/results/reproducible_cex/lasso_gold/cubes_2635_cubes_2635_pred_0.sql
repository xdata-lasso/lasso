-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1016, 'capital', 'finally', 'human', 'bar', 'not');
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1017, 'surface', 'animal', 'show', 'machine', 'old');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "carrier" FROM "device" WHERE ("software_platform" <> 'Android') ORDER BY carrier, device.device_id NULLS LAST;

/*
Gold Result:
('animal',)
('finally',)
*/

-- Prediction Query
SELECT Carrier FROM device WHERE Software_Platform <> 'Android';

/*
Prediction Result:
('finally',)
('animal',)
*/