-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'Phone X', 'ZetaTel', '1.0', 'Maps', 'Android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'Phone A', 'AlphaMobile', '2.0', 'Browser', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (3, 'Phone B', 'AlphaMobile', '1.5', 'Mail', 'Android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (4, 'Phone C', 'BetaComm', '3.0', 'Chat', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (5, 'Phone D', 'BetaComm', '3.1', 'Games', 'Android');
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (10, 'Main Store', 'NY', '2020-01-01', 2020);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (20, 'West Store', 'LA', '2021-06-15', 2021);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (10, 4, 50);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (20, 4, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM device AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.device_id = RHS.device_id))) ORDER BY carrier;

/*
Gold Result:
('AlphaMobile',)
('AlphaMobile',)
('BetaComm',)
('ZetaTel',)
*/

-- Prediction Query
SELECT Carrier FROM device WHERE NOT Device_ID IN (SELECT Device_ID FROM stock);

/*
Prediction Result:
('ZetaTel',)
('AlphaMobile',)
('AlphaMobile',)
('BetaComm',)
*/