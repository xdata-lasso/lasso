-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'PhoneA', 'CarrierB', '1.0', 'App1', 'OS1');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'PhoneB', 'CarrierA', '1.0', 'App1', 'OS1');
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (1, 'Shop1', 'Loc1', '2020-01-01', 2020);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (1, NULL, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM device AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.device_id = RHS.device_id))) ORDER BY carrier;

/*
Gold Result:
('CarrierA',)
('CarrierB',)
*/

-- Prediction Query
SELECT Carrier FROM device WHERE NOT Device_ID IN (SELECT Device_ID FROM stock);

/*
Prediction Result:
*/