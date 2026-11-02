-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'iPhone 13', 'Verizon', '1.0', 'Maps', 'iOS');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'iPhone 14', 'AT&T', '2.0', 'Mail', 'iOS');
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (1, 'Apple', 'Cupertino', '2021-05-10', 2021);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (2, 'Apple', 'New York', '2020-12-01', 2020);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (3, 'Samsung', 'Seoul', '2019-01-15', 2019);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (4, 'Apple Store', 'London', '2018-03-20', 2018);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (5, 'apple', 'Tokyo', '2017-07-07', 2017);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (6, NULL, 'Paris', '2016-06-06', 2016);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (1, 1, 50);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (1, 2, 30);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (3, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "open_date", "open_year" FROM "shop" WHERE ("shop_name" = 'Apple') ORDER BY open_date, shop.shop_id NULLS LAST;

/*
Gold Result:
('2020-12-01', 2020)
('2021-05-10', 2021)
*/

-- Prediction Query
SELECT Open_Date, Open_Year FROM shop WHERE Shop_Name = 'Apple';

/*
Prediction Result:
('2021-05-10', 2021)
('2020-12-01', 2020)
*/