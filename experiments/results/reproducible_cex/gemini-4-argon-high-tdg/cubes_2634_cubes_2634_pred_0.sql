-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Downtown Mobile', 'New York', '2018-05-10', 2018);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'Westside Tech', 'Los Angeles', '2020-11-22', 2020);
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (1, 'Alpha Phone', 'Verizon', '1.0', 'Maps', 'Windows');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (2, 'Zeta Phone', 'AT&T', '2.0', 'Mail', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (3, 'Mu Phone', 'T-Mobile', '3.0', 'Chat', 'BlackBerry');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (4, 'Gamma Phone', 'Sprint', '2.1', 'Music', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (5, 'Delta Phone', 'Vodafone', '3.1', 'Browser', 'BlackBerry');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (6, 'Epsilon Phone', 'Orange', '3.2', 'Camera', 'BlackBerry');
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 1, 15);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (2, 2, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT software_platform FROM device ORDER BY software_platform;

/*
Gold Result:
('Android',)
('BlackBerry',)
('Windows',)
*/

-- Prediction Query
SELECT Software_Platform FROM device GROUP BY Software_Platform ORDER BY COUNT(*) DESC, Software_Platform NULLS LAST;

/*
Prediction Result:
('BlackBerry',)
('Android',)
('Windows',)
*/