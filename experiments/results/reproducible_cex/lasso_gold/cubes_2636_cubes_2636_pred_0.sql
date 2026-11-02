-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1010, 'bar', 'present', 'capital', 'themselves', 'human');
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1011, 'machine', 'not', 'finally', 'win', 'production');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM device AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.device_id = RHS.device_id))) ORDER BY carrier;

/*
Gold Result:
('not',)
('present',)
*/

-- Prediction Query
SELECT Carrier FROM device WHERE NOT Device_ID IN (SELECT Device_ID FROM stock);

/*
Prediction Result:
('present',)
('not',)
*/