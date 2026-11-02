-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (1, 'Apple', 'New York', '2020-05-01', 2020);
INSERT INTO shop (Shop_ID, Shop_Name, Location, Open_Date, Open_Year) VALUES (2, 'Apple', 'Chicago', '2018-01-15', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "open_date", "open_year" FROM "shop" WHERE ("shop_name" = 'Apple') ORDER BY open_date, shop.shop_id NULLS LAST;

/*
Gold Result:
('2018-01-15', 2018)
('2020-05-01', 2020)
*/

-- Prediction Query
SELECT Open_Date, Open_Year FROM shop WHERE Shop_Name = 'Apple';

/*
Prediction Result:
('2020-05-01', 2020)
('2018-01-15', 2018)
*/