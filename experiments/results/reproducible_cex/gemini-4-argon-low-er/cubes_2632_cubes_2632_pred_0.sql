-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'Phone', 'CarrierA', '1.0', 'AppA', 'OS1');
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (2, 'ShopTwo', 'LocationB', '2021-01-01', 2021);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (2, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT shop_name FROM (SELECT LHS.shop_id AS shop_id, LHS.shop_name AS shop_name, LHS.location AS LOCATION, LHS.open_date AS open_date, LHS.open_year AS open_year, RHS.device_id AS device_id, RHS.shop_id AS shop_id_other FROM shop AS LHS INNER JOIN (SELECT device_id, shop_id, COUNT(*) AS n FROM stock GROUP BY device_id, shop_id) AS RHS ON (LHS.shop_id = RHS.n)) ORDER BY shop_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Shop_Name FROM stock AS T1 JOIN shop AS T2 ON T1.Shop_ID = T2.Shop_ID GROUP BY T1.Shop_ID ORDER BY COUNT(*) DESC, T2.Shop_Name NULLS LAST LIMIT 1;

/*
Prediction Result:
('ShopTwo',)
*/