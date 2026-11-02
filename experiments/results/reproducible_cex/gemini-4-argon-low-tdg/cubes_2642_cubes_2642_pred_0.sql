-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests multiple distinct software platforms with varying frequencies, ties, and opposite alphabetical/count ordering.
-- Catches mutants in: DISTINCT vs ALL, ORDER BY direction/column, comparison operators (> vs >=, <, =), and LIMIT 1 / MAX(n) shortcuts.
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'Phone A', 'Carrier 1', '1.0', 'App 1', 'Android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'Phone B', 'Carrier 1', '1.0', 'App 1', 'Android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (3, 'Phone C', 'Carrier 2', '2.0', 'App 2', 'Android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (4, 'Phone D', 'Carrier 2', '2.0', 'App 2', 'BlackBerry');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (5, 'Phone E', 'Carrier 3', '3.0', 'App 3', 'BlackBerry');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (6, 'Phone F', 'Carrier 3', '3.0', 'App 3', 'Symbian');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (7, 'Phone G', 'Carrier 4', '4.0', 'App 4', 'Windows');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (8, 'Phone H', 'Carrier 4', '4.0', 'App 4', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (9, 'Phone I', 'Carrier 4', '4.0', 'App 4', 'iOS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT software_platform FROM (SELECT LHS.software_platform AS software_platform, LHS.n AS n, RHS.software_platform AS software_platform_other, RHS.n AS n_other FROM (SELECT software_platform, COUNT(*) AS n FROM device GROUP BY software_platform) AS LHS CROSS JOIN (SELECT software_platform, COUNT(*) AS n FROM device GROUP BY software_platform) AS RHS) WHERE (n > n_other) ORDER BY software_platform;

/*
Gold Result:
('Android',)
('Android',)
('Android',)
('Android',)
('BlackBerry',)
('BlackBerry',)
('iOS',)
('iOS',)
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST LIMIT 1;

/*
Prediction Result:
('Android',)
*/