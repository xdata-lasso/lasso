-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Bag semantics vs. Set semantics (Duplicate 'Carrier' values for unstocked devices: kills SELECT DISTINCT / EXCEPT).
-- 2. Shared 'Carrier' across stocked and unstocked devices (kills SELECT Carrier FROM device EXCEPT SELECT Carrier FROM stock JOIN device).
-- 3. Ordering direction and NULL handling (ASC vs DESC, NULLS FIRST).
-- 4. Column confusion (Device text != Carrier text).
-- 5. Anti-join vs Inner-join (some devices stocked, some not).
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'Pixel 8', 'Verizon', 'v1.0', 'Maps', 'Android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'Galaxy S23', 'Verizon', 'v2.0', 'Mail', 'Android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (3, 'iPhone 15', 'AT&T', 'v3.0', 'Music', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (4, 'iPhone 14', 'AT&T', 'v2.5', 'Music', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (5, 'Xperia 1', 'T-Mobile', 'v1.1', 'Camera', 'Android');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (6, 'Unlocked Phone', NULL, 'v1.0', 'Browser', 'Android');
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (10, 'Downtown Store', 'NY', '2020-01-01', 2020);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (20, 'Mall Kiosk', 'CA', '2021-06-15', 2021);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (10, 3, 50);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (10, 5, 25);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (20, 5, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM device AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.device_id = RHS.device_id))) ORDER BY carrier;

/*
Gold Result:
(None,)
('AT&T',)
('Verizon',)
('Verizon',)
*/

-- Prediction Query
SELECT Carrier FROM device WHERE NOT Device_ID IN (SELECT Device_ID FROM stock);

/*
Prediction Result:
('Verizon',)
('Verizon',)
('AT&T',)
(None,)
*/