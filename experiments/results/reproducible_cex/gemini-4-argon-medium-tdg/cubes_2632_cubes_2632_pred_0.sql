-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard join condition where LHS.shop_id = 1 (since COUNT(*) per PK group is always 1),
-- distinct elimination over multiple stock rows, and decouples stock's shop_id from the matched LHS.shop_id.
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (10, 'Phone A', 'Carrier X', '1.0', 'App1', 'OS1');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (20, 'Phone B', 'Carrier Y', '2.0', 'App2', 'OS2');
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Shop One', 'Loc A', '2020-01-01', 2020);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'Shop Two', 'Loc B', '2021-01-01', 2021);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (3, 'Shop Three', 'Loc C', '2022-01-01', 2022);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (2, 10, 5);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (2, 20, 10);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (3, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT shop_name FROM (SELECT LHS.shop_id AS shop_id, LHS.shop_name AS shop_name, LHS.location AS LOCATION, LHS.open_date AS open_date, LHS.open_year AS open_year, RHS.device_id AS device_id, RHS.shop_id AS shop_id_other FROM shop AS LHS INNER JOIN (SELECT device_id, shop_id, COUNT(*) AS n FROM stock GROUP BY device_id, shop_id) AS RHS ON (LHS.shop_id = RHS.n)) ORDER BY shop_name;

/*
Gold Result:
('Shop One',)
*/

-- Prediction Query
SELECT T2.Shop_Name FROM stock AS T1 JOIN shop AS T2 ON T1.Shop_ID = T2.Shop_ID GROUP BY T1.Shop_ID ORDER BY COUNT(*) DESC, T2.Shop_Name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Shop Two',)
*/