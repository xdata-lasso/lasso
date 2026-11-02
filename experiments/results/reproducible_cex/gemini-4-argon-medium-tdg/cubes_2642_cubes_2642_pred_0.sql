-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard hierarchical counts (4, 3, 2, 1), reverse alphabetical relationship with count,
-- and ensures mutants using DISTINCT, MAX, MIN, or missing the self-join fail.
-- Also includes unreferenced devices and multiple stocks to kill mutants joining 'stock'.
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'PhoneA', 'Carrier1', '1.0', 'App1', 'Symbian');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'PhoneB', 'Carrier1', '1.0', 'App1', 'Symbian');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (3, 'PhoneC', 'Carrier2', '2.0', 'App2', 'Symbian');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (4, 'PhoneD', 'Carrier2', '2.0', 'App2', 'Symbian');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (5, 'PhoneE', 'Carrier1', '1.0', 'App1', 'BlackBerry');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (6, 'PhoneF', 'Carrier2', '1.0', 'App2', 'BlackBerry');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (7, 'PhoneG', 'Carrier3', '1.0', 'App3', 'BlackBerry');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (8, 'PhoneH', 'Carrier1', '1.0', 'App1', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (9, 'PhoneI', 'Carrier2', '1.0', 'App1', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (10, 'PhoneJ', 'Carrier1', '1.0', 'App1', 'Android');
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (1, 'Main Shop', 'NY', '2020-01-01', 2020);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (2, 'Second Shop', 'LA', '2021-01-01', 2021);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (1, 10, 50);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (2, 10, 50);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (1, 8, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT software_platform FROM (SELECT LHS.software_platform AS software_platform, LHS.n AS n, RHS.software_platform AS software_platform_other, RHS.n AS n_other FROM (SELECT software_platform, COUNT(*) AS n FROM device GROUP BY software_platform) AS LHS CROSS JOIN (SELECT software_platform, COUNT(*) AS n FROM device GROUP BY software_platform) AS RHS) WHERE (n > n_other) ORDER BY software_platform;

/*
Gold Result:
('BlackBerry',)
('BlackBerry',)
('Symbian',)
('Symbian',)
('Symbian',)
('iOS',)
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST LIMIT 1;

/*
Prediction Result:
('Symbian',)
*/