-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1001, 'purpose', 'brother', 'ago', 'site', 'face');
INSERT INTO "device" ("device_id", "device", "carrier", "package_version", "applications", "software_platform") VALUES (1002, 'purpose', 'election', 'dog', 'chair', 'since');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT software_platform FROM (SELECT LHS.device AS device, LHS.software_platform AS software_platform, LHS.maxn AS maxn, RHS.carrier AS carrier, RHS.package_version AS package_version, RHS.applications AS applications, RHS.software_platform AS software_platform_other FROM (SELECT device, software_platform, MAX(n) AS maxn FROM (SELECT device, software_platform, COUNT(*) AS n FROM device GROUP BY device, software_platform) GROUP BY device, software_platform) AS LHS INNER JOIN device AS RHS ON (LHS.maxn = RHS.device_id AND LHS.device = RHS.device)) ORDER BY software_platform;

/*
Gold Result:
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST LIMIT 1;

/*
Prediction Result:
('face',)
*/