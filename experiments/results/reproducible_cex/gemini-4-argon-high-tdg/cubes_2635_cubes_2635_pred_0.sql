-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'iPhone 13', 'Verizon', 'v1.0', 'Mail', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'Galaxy S21', 'AT&T', 'v2.0', 'Maps', 'Android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (3, 'Lumia 950', 'T-Mobile', 'v1.5', 'Office', 'Windows Phone');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (4, 'CustomPhone', 'Bell', 'v0.9', 'Browser', 'AOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (5, 'iPhone 14', 'Sprint', 'v1.1', 'Music', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (6, 'iPhone SE', 'Bell', 'v1.2', 'Camera', 'iOS');
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (10, 'Downtown Tech', 'New York', '2018-05-01', 2018);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (20, 'Uptown Mobile', 'Chicago', '2020-11-15', 2020);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (10, 1, 15);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (20, 1, 8);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (10, 2, 25);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (20, 3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "carrier" FROM "device" WHERE ("software_platform" <> 'Android') ORDER BY carrier, device.device_id NULLS LAST;

/*
Gold Result:
('Bell',)
('Bell',)
('Sprint',)
('T-Mobile',)
('Verizon',)
*/

-- Prediction Query
SELECT Carrier FROM device WHERE Software_Platform <> 'Android';

/*
Prediction Result:
('Verizon',)
('T-Mobile',)
('Bell',)
('Sprint',)
('Bell',)
*/