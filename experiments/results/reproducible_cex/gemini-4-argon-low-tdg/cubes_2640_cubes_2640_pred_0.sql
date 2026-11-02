-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (1, 'Phone', 'CarrierA', '1.0', 'App1', 'OS1');
INSERT INTO "device" ("Device_ID", "Device", "Carrier", "Package_Version", "Applications", "Software_Platform") VALUES (2, 'Tablet', 'CarrierB', '2.0', 'App2', 'OS2');
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (1, 'Zeta Shop', 'LocA', '2020-01-01', 2020);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (2, 'Alpha Shop', 'LocB', '2021-01-01', 2021);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (3, 'Alpha Shop', 'LocC', '2022-01-01', 2022);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (4, 'Beta Shop', 'LocD', '2020-05-01', 2020);
INSERT INTO "shop" ("Shop_ID", "Shop_Name", "Location", "Open_Date", "Open_Year") VALUES (5, 'Gamma Shop', 'LocE', '2019-03-01', 2019);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (4, 1, 0);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (5, 1, 10);
INSERT INTO "stock" ("Shop_ID", "Device_ID", "Quantity") VALUES (5, 2, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY shop_name;

/*
Gold Result:
('Alpha Shop',)
('Alpha Shop',)
('Zeta Shop',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop WHERE NOT Shop_ID IN (SELECT Shop_ID FROM stock);

/*
Prediction Result:
('Zeta Shop',)
('Alpha Shop',)
('Alpha Shop',)
*/