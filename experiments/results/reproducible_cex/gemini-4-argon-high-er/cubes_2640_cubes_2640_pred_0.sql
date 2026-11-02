-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO device (Device_ID, Device, Carrier, Package_Version, Applications, Software_Platform) VALUES (1, 'Phone', 'CarrierA', '1.0', 'AppA', 'OS1');
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Shop B', 'Loc 1', '2020-01-01', 2020);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'Shop A', 'Loc 2', '2020-01-02', 2020);
INSERT INTO stock (Shop_ID, Device_ID, Quantity) VALUES (NULL, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY shop_name;

/*
Gold Result:
('Shop A',)
('Shop B',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop WHERE NOT Shop_ID IN (SELECT Shop_ID FROM stock);

/*
Prediction Result:
*/