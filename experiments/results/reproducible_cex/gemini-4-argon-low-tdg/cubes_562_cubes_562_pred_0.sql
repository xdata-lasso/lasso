-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (2, 'Zeta Store', 'West St', 'District 2', 50, 'Bob');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (1, 'Alpha Store', 'East St', 'District 1', 100, 'Alice');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (3, 'Beta Store', 'North St', 'District 3', 10, 'Charlie');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION, district FROM shop ORDER BY name, shop.shop_id NULLS LAST;

/*
Gold Result:
('Alpha Store', 'East St', 'District 1')
('Beta Store', 'North St', 'District 3')
('Zeta Store', 'West St', 'District 2')
*/

-- Prediction Query
SELECT name, LOCATION, district FROM shop ORDER BY number_products DESC, shop.shop_id NULLS LAST;

/*
Prediction Result:
('Alpha Store', 'East St', 'District 1')
('Zeta Store', 'West St', 'District 2')
('Beta Store', 'North St', 'District 3')
*/