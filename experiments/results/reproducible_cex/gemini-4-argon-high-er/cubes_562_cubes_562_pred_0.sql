-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (1, 'A', 'Loc1', 'Dist1', 10, 'M1');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (2, 'B', 'Loc2', 'Dist2', 20, 'M2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION, district FROM shop ORDER BY name, shop.shop_id NULLS LAST;

/*
Gold Result:
('A', 'Loc1', 'Dist1')
('B', 'Loc2', 'Dist2')
*/

-- Prediction Query
SELECT name, LOCATION, district FROM shop ORDER BY number_products DESC, shop.shop_id NULLS LAST;

/*
Prediction Result:
('B', 'Loc2', 'Dist2')
('A', 'Loc1', 'Dist1')
*/