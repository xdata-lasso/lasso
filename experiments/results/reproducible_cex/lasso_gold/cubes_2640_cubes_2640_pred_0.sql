-- Schema DDL
CREATE TABLE "device" ("Device_ID" INTEGER PRIMARY KEY, "Device" TEXT, "Carrier" TEXT, "Package_Version" TEXT, "Applications" TEXT, "Software_Platform" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Name" TEXT, "Location" TEXT, "Open_Date" TEXT, "Open_Year" INTEGER);

CREATE TABLE "stock" ("Shop_ID" INTEGER, "Device_ID" INTEGER, "Quantity" INTEGER, PRIMARY KEY ("Shop_ID", "Device_ID"), FOREIGN KEY ("Device_ID") REFERENCES "device" ("Device_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1015, 'Sherri Baker', '03911 Cabrera Trace Apt. 278
West Allison, PA 55962', 'development', 1016);
INSERT INTO "shop" ("shop_id", "shop_name", "location", "open_date", "open_year") VALUES (1017, 'Nicole Vaughn', '148 Eric Track
New Stephanie, NC 00575', 'place', 1017);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_name FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM stock AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY shop_name;

/*
Gold Result:
('Nicole Vaughn',)
('Sherri Baker',)
*/

-- Prediction Query
SELECT Shop_Name FROM shop WHERE NOT Shop_ID IN (SELECT Shop_ID FROM stock);

/*
Prediction Result:
('Sherri Baker',)
('Nicole Vaughn',)
*/