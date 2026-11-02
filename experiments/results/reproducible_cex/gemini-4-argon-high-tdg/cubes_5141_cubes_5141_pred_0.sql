-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (1, 'Galaxy', 'Verizon', '1.0', 'Maps', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (2, 'iPhone', 'ATT', '2.0', 'Mail', 'iOS');
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Beta Shop', 'Chicago', '15-May', 2015);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'Delta Shop', 'Austin', '01-Jan', 2022);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (3, 'Alpha Shop', 'Seattle', '30-Dec', 2005);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (4, 'Echo Shop', 'Miami', '20-Jun', 2012);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (10, 'Charlie Shop', 'Boston', '10-Oct', 2018);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 1, 50);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (2, 1, 100);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (3, 2, 10);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (4, 2, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT * FROM (SELECT * FROM (SELECT shop_id, shop_name, MAX(open_year) AS maxopen_year FROM shop GROUP BY shop_id, shop_name) ORDER BY shop_id DESC) LIMIT 1);

/*
Gold Result:
('Charlie Shop',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop ORDER BY Open_Year DESC, shop.shop_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Delta Shop',)
*/