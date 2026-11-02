-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: shop --
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1, '5k5swwqcgs', '9n8', '4', -734455130);

INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (-2147483647, '4h', 'ia2yp', 'uzhsrwbbp6lu', 1019800248);

INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (4, 'dlttil', 'n', 'rmdp', 2026480202);

INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (5, 'ie5', 'nw6klf', 'a9000t5c4eci', 1149850321);

INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (-2147483648, 'e', '76nium52', 'zbuo4nrqrof', 373262291);

INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (-2147483649, 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', -1666765085);

INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (-2147483642, 'q_2_2a793b', '72klex14ji7z', 'au2dwy', -953437896);

INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (-2147483641, 'q_2_2a793b', '3pyu78d', '9rljsl0b4', 1649269347);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT * FROM (SELECT * FROM (SELECT shop_id, shop_name, MAX(open_year) AS maxopen_year FROM shop GROUP BY shop_id, shop_name) ORDER BY shop_id DESC) LIMIT 1);

/*
Gold Result:
('ie5',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop ORDER BY Open_Year DESC, shop.shop_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('dlttil',)
*/