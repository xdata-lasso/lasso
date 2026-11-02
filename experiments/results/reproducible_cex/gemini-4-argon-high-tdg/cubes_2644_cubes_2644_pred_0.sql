-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (101, 'Galaxy S', 'Verizon', '1.0', 'Maps', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (102, 'iPhone', 'ATT', '2.0', 'Mail', 'iOS');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (103, 'Pixel', 'T-Mobile', '3.0', 'Browser', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (104, 'Lumia', 'Sprint', '4.0', 'Office', 'Windows');
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Zeta Store', 'Austin', '2018-05-01', 2018);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'Alpha Mart', 'Boston', '2019-06-15', 2019);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (3, 'Gamma Shop', 'Chicago', '2020-01-10', 2020);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (4, 'Beta Boutique', 'Denver', '2017-11-20', 2017);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (5, 'Delta Depot', 'Miami', '2016-03-03', 2016);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 101, 1);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 102, 1);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 103, 1);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (3, 101, 50);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (4, 101, 0);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (4, 102, 0);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (5, 101, 2);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (5, 102, 2);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (5, 103, 2);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (5, 104, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT shop_id, shop_name, COUNT(*) AS n FROM (SELECT LHS.shop_id AS shop_id, LHS.shop_name AS shop_name, LHS.location AS LOCATION, LHS.open_date AS open_date, LHS.open_year AS open_year, RHS.device_id AS device_id, RHS.quantity AS quantity FROM shop AS LHS INNER JOIN stock AS RHS ON (LHS.shop_id = RHS.shop_id)) GROUP BY shop_id, shop_name) WHERE (n > 1) ORDER BY shop_name;

/*
Gold Result:
('Beta Boutique',)
('Delta Depot',)
('Zeta Store',)
*/

-- Prediction Query
SELECT T2.Shop_Name FROM stock AS T1 JOIN shop AS T2 ON T1.Shop_ID = T2.Shop_ID GROUP BY T1.Shop_ID HAVING COUNT(*) > 1;

/*
Prediction Result:
('Zeta Store',)
('Beta Boutique',)
('Delta Depot',)
*/