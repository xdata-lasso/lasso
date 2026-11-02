-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (1, 'iPhone 13', 'Verizon', '1.0', 'Mail, Maps', 'iOS');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (2, 'Galaxy S22', 'AT&T', '2.1', 'Browser, Chat', 'Android');
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (3, 'Pixel 6', 'T-Mobile', '1.5', 'Search, Photos', 'Android');
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Z-Mart', 'New York', '2020-01-01', 2020);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'M-Store', 'Los Angeles', '2019-05-10', 2019);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (3, 'A-Shop', 'San Francisco', '2021-03-15', 2021);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (4, 'B-Boutique', 'Chicago', '2018-07-20', 2018);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (1, 2, 15);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (4, 1, 10);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (4, 2, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY shop_name;

/*
Gold Result:
('A-Shop',)
('M-Store',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop WHERE NOT Shop_ID IN (SELECT Shop_ID FROM stock);

/*
Prediction Result:
('M-Store',)
('A-Shop',)
*/