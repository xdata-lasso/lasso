-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (3, 'Galaxy S', 'Verizon', '1.0', 'Maps', 'Android');
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (0, 'Shop_Zero', 'Austin', '2009-01-01', 2009);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Shop_Alpha', 'Boston', '2010-05-10', 2010);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'Shop_Beta', 'Chicago', '2011-06-15', 2011);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (3, 'Shop_Gamma', 'Denver', '2012-07-20', 2012);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (4, 'Shop_Delta', 'Miami', '2013-08-25', 2013);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (5, 'Shop_Epsilon', 'Seattle', '2014-09-30', 2014);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (2, 3, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT shop_name FROM (SELECT LHS.shop_id AS shop_id, LHS.shop_name AS shop_name, LHS.location AS LOCATION, LHS.open_date AS open_date, LHS.open_year AS open_year, RHS.device_id AS device_id, RHS.shop_id AS shop_id_other FROM shop AS LHS INNER JOIN (SELECT device_id, shop_id, COUNT(*) AS n FROM stock GROUP BY device_id, shop_id) AS RHS ON (LHS.shop_id = RHS.n)) ORDER BY shop_name;

/*
Gold Result:
('Shop_Alpha',)
*/

-- Prediction Query
SELECT T2.Shop_Name FROM stock AS T1 JOIN shop AS T2 ON T1.Shop_ID = T2.Shop_ID GROUP BY T1.Shop_ID ORDER BY COUNT(*) DESC, T2.Shop_Name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Shop_Beta',)
*/