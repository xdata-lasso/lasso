-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Central Tech', 'Downtown', '2020-01-15', 2020);
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (1, 'Phone Z1', 'CarrierA', '1.0', 'Maps', 'ZetaOS');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (2, 'Phone Z2', 'CarrierB', '1.1', 'Mail', 'ZetaOS');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (3, 'Phone Z3', 'CarrierC', '1.2', 'Chat', 'ZetaOS');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (4, 'Phone A1', 'CarrierA', '2.0', 'Maps', 'AlphaOS');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (5, 'Phone A2', 'CarrierB', '2.1', 'Music', 'AlphaOS');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (6, 'Phone M1', 'CarrierC', '3.0', 'Browser', 'MidOS');
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 6, 100);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 4, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT software_platform FROM (SELECT LHS.software_platform AS software_platform, LHS.n AS n, RHS.software_platform AS software_platform_other, RHS.n AS n_other FROM (SELECT software_platform, COUNT(*) AS n FROM device GROUP BY software_platform) AS LHS CROSS JOIN (SELECT software_platform, COUNT(*) AS n FROM device GROUP BY software_platform) AS RHS) WHERE (n > n_other) ORDER BY software_platform;

/*
Gold Result:
('AlphaOS',)
('ZetaOS',)
('ZetaOS',)
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST LIMIT 1;

/*
Prediction Result:
('ZetaOS',)
*/