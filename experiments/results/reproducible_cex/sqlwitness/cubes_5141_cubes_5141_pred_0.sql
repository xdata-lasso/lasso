-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, shop_name, location, open_date, open_year) VALUES (1, 'default2', 'default1', 'default2', 2), (2, 'default2', 'default2', NULL, 2), (0, NULL, NULL, 'default2', 1), (3, NULL, 'default1', 'default2', 1), (4, 'default2', NULL, 'default2', NULL), (5, 'default2', 'default1', 'default2', NULL), (6, 'default1', 'default1', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT * FROM (SELECT * FROM (SELECT shop_id, shop_name, MAX(open_year) AS maxopen_year FROM shop GROUP BY shop_id, shop_name) ORDER BY shop_id DESC) LIMIT 1);

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop ORDER BY Open_Year DESC, shop.shop_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/