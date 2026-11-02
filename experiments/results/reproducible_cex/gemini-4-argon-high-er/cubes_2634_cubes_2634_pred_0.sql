-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "device" ("Device_ID", "Software_Platform") VALUES (1, 'A');
INSERT INTO "device" ("Device_ID", "Software_Platform") VALUES (2, 'B');
INSERT INTO "device" ("Device_ID", "Software_Platform") VALUES (3, 'B');
INSERT INTO "device" ("Device_ID", "Software_Platform") VALUES (4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT software_platform FROM device ORDER BY software_platform;

/*
Gold Result:
(None,)
('A',)
('B',)
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
(None,)
*/