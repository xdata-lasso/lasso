-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (1, 'Alpha', 'C1', '1.0', 'App1', 'WebOS');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (2, 'Beta', 'C2', '2.0', 'App2', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (3, 'Beta', 'C3', '2.1', 'App3', 'Tizen');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (4, 'Beta', 'C4', '2.2', 'App4', 'Tizen');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (5, 'Gamma', 'C5', '3.0', 'App5', 'Bada');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT software_platform FROM (SELECT LHS.device AS device, LHS.software_platform AS software_platform, LHS.maxn AS maxn, RHS.carrier AS carrier, RHS.package_version AS package_version, RHS.applications AS applications, RHS.software_platform AS software_platform_other FROM (SELECT device, software_platform, MAX(n) AS maxn FROM (SELECT device, software_platform, COUNT(*) AS n FROM device GROUP BY device, software_platform) GROUP BY device, software_platform) AS LHS INNER JOIN device AS RHS ON (LHS.maxn = RHS.device_id AND LHS.device = RHS.device)) ORDER BY software_platform;

/*
Gold Result:
('Tizen',)
('WebOS',)
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST LIMIT 1;

/*
Prediction Result:
('Tizen',)
*/