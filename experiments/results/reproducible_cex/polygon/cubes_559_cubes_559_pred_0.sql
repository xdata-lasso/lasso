-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (8, '-715', -715, '-715');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (10, '13', '14', '15', -715, '16');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (9, '-715', '-715', '-715', -550, '-715');
INSERT INTO "hiring" ("employee_id", "shop_id", "start_from", "is_full_time") VALUES (8, 9, '-715', 1);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES ('8', '12', -715);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES ('8', '11', -715);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT minnumber_products AS min_number_products_, MAX(number_products) OVER () AS max_number_products_ FROM (SELECT shop_id, name, LOCATION, district, number_products, manager_name, MIN(number_products) OVER () AS minnumber_products FROM shop) ORDER BY min_number_products_, max_number_products_ NULLS LAST;

/*
Gold Result:
(-715, -550)
*/

-- Prediction Query
SELECT MIN(Number_products), MAX(Number_products) FROM shop;

/*
Prediction Result:
(-715, -550)
*/