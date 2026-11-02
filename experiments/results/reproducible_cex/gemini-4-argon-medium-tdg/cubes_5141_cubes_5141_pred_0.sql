-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Zulu Store', 'North', '2022-01-01', 2022);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'Middle Store', 'Central', '2020-05-15', 2020);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (10, 'Alpha Store', 'South', '1999-12-31', 1999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT * FROM (SELECT * FROM (SELECT shop_id, shop_name, MAX(open_year) AS maxopen_year FROM shop GROUP BY shop_id, shop_name) ORDER BY shop_id DESC) LIMIT 1);

/*
Gold Result:
('Alpha Store',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop ORDER BY Open_Year DESC, shop.shop_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zulu Store',)
*/