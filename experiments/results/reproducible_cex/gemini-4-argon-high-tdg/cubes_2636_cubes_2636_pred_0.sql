-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (1, 'Galaxy S10', 'Zeta Mobile', 'v1.0', 'Maps', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (2, 'iPhone 12', 'Alpha Telecom', 'v2.1', 'Mail', 'iOS');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (3, 'Pixel 5', 'Beta Wireless', 'v3.0', 'Browser', 'Android');
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Downtown Store', 'New York', '2018-05-10', 2018);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'Uptown Store', 'Chicago', '2019-08-15', 2019);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 3, 25);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (2, 3, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM device AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.device_id = RHS.device_id))) ORDER BY carrier;

/*
Gold Result:
('Alpha Telecom',)
('Zeta Mobile',)
*/

-- Prediction Query
SELECT Carrier FROM device WHERE NOT Device_ID IN (SELECT Device_ID FROM stock);

/*
Prediction Result:
('Zeta Mobile',)
('Alpha Telecom',)
*/