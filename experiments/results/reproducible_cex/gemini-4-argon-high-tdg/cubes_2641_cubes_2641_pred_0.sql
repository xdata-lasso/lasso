-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (1, 'Phone1', 'Zeta', '1.0', 'App1', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (2, 'Phone2', 'Beta', '2.0', 'App2', 'iOS');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (3, 'Phone3', 'Alpha', '3.0', 'App3', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (4, 'Phone4', 'Beta', '4.0', 'App4', 'Windows');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (5, 'Phone5', 'Omega', '5.0', 'App5', 'iOS');
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (10, 'ShopA', 'NY', '2020-01-01', 2020);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (20, 'ShopB', 'LA', '2021-01-01', 2021);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (10, 1, 5);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (20, 1, 3);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (10, 2, 10);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (10, 4, 2);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (20, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT carrier FROM (SELECT LHS.device_id AS device_id, LHS.device AS device, LHS.carrier AS carrier, LHS.package_version AS package_version, LHS.applications AS applications, LHS.software_platform AS software_platform, RHS.shop_id AS shop_id, RHS.n AS n FROM device AS LHS INNER JOIN (SELECT * FROM (SELECT device_id, shop_id, COUNT(*) AS n FROM stock GROUP BY device_id, shop_id) WHERE (n >= 1)) AS RHS ON (LHS.device_id = RHS.device_id)) ORDER BY carrier;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.Carrier FROM stock AS T1 JOIN device AS T2 ON T1.Device_ID = T2.Device_ID GROUP BY T1.Device_ID HAVING COUNT(*) > 1;

/*
Prediction Result:
('Zeta',)
*/