-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests projection (SELECT DISTINCT vs SELECT ALL) and ordering with ties on Open_Date.
-- Kills mutants that add DISTINCT, order by Open_Year instead of Open_Date, or order by Shop_ID DESC on ties.
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (10, 'Apple', 'LocA', '2020-05-01', 2020);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (20, 'Apple', 'LocB', '2020-05-01', 2020);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (5, 'Apple', 'LocC', '2020-05-01', 2019);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (15, 'Apple', 'LocD', '2018-12-12', 2022);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (25, 'Apple', 'LocE', '2021-01-01', 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "open_date", "open_year" FROM "shop" WHERE ("shop_name" = 'Apple') ORDER BY open_date, shop.shop_id NULLS LAST;

/*
Gold Result:
('2018-12-12', 2022)
('2020-05-01', 2019)
('2020-05-01', 2020)
('2020-05-01', 2020)
('2021-01-01', 2015)
*/

-- Prediction Query
SELECT Open_Date, Open_Year FROM shop WHERE Shop_Name = 'Apple';

/*
Prediction Result:
('2020-05-01', 2019)
('2020-05-01', 2020)
('2018-12-12', 2022)
('2020-05-01', 2020)
('2021-01-01', 2015)
*/