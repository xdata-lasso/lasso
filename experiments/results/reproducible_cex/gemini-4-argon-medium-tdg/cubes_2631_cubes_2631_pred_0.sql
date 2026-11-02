-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Zeta Store', 'NY', '2020-01-01', 2020);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'Alpha Store', 'LA', '2018-05-10', 2018);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (3, 'Beta Store', 'SF', '2021-03-15', 2021);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (4, 'Alpha Store', 'TX', '2019-11-20', 2019);
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (10, 'Phone X', 'Carrier A', '1.0', 'Maps', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (20, 'Phone Y', 'Carrier B', '2.0', 'Mail', 'iOS');
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 10, 50);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 20, 30);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (2, 10, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM shop ORDER BY shop_name, shop.shop_id NULLS LAST;

/*
Gold Result:
('Alpha Store',)
('Alpha Store',)
('Beta Store',)
('Zeta Store',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop ORDER BY Open_Year ASC, shop.shop_id NULLS LAST;

/*
Prediction Result:
('Alpha Store',)
('Alpha Store',)
('Zeta Store',)
('Beta Store',)
*/