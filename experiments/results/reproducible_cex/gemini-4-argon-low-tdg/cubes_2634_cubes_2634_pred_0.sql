-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (duplicate software_platform values).
-- 2. Missing ORDER BY or DESC instead of ASC (inserted in reverse alphabetical order).
-- 3. Unnecessary INNER JOIN with stock/shop (Device 4 has no stock record).
-- 4. Column confusion (Device, Carrier, Applications, Package_Version all have distinct values from Software_Platform).
-- 5. Ordering by a different column (Device_ID or Device order differs from Software_Platform order).
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'Alpha', 'Verizon', '1.0', 'Maps', 'Windows');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'Beta', 'AT&T', '2.0', 'Mail', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (3, 'Gamma', 'T-Mobile', '3.0', 'Browser', 'Windows');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (4, 'Delta', 'Sprint', '4.0', 'Chat', 'Android');
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (10, 'Main Shop', 'NY', '2020-01-01', 2020);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (10, 1, 5);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (10, 2, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT software_platform FROM device ORDER BY software_platform;

/*
Gold Result:
('Android',)
('Windows',)
('iOS',)
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST;

/*
Prediction Result:
('Windows',)
('Android',)
('iOS',)
*/