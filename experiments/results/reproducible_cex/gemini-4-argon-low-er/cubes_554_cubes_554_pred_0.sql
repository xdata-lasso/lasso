-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (1, 'Shop A', 'Loc A', 'Dist A', 10, 'Mgr A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT shop_id, name, LOCATION, district, number_products, manager_name, AVG(number_products) OVER () AS meannumber_products FROM shop) ORDER BY number_products DESC) LIMIT 3);

/*
Gold Result:
('Shop A',)
*/

-- Prediction Query
SELECT name FROM shop WHERE number_products > (SELECT AVG(number_products) FROM shop);

/*
Prediction Result:
*/