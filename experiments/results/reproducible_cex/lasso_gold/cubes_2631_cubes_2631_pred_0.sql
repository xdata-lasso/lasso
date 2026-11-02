-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1006, 'Renee Morales', '327 Nelson Route
Lake Mark, WI 07832', 'drop', 1007);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1008, 'Calvin Nielsen', '959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 'hear', 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM shop ORDER BY shop_name, shop.shop_id NULLS LAST;

/*
Gold Result:
('Calvin Nielsen',)
('Renee Morales',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop ORDER BY Open_Year ASC, shop.shop_id NULLS LAST;

/*
Prediction Result:
('Renee Morales',)
('Calvin Nielsen',)
*/