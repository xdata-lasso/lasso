-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard execution: > 3 rows, distinct Number_products, non-alphabetical insertion order,
-- distinct Name vs Manager_name/Location/District, and checks against inner join mutants (not all shops are in hiring).
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (1, 'Alpha', 'LocC', 'DistX', 150, 'Mgr1');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (2, 'Beta', 'LocA', 'DistY', 50, 'Mgr2');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (3, 'Gamma', 'LocD', 'DistZ', 300, 'Mgr3');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (4, 'Delta', 'LocB', 'DistW', 200, 'Mgr4');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (5, 'Epsilon', 'LocE', 'DistV', 100, 'Mgr5');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (101, 'EmpA', 30, 'CityA');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (101, 2, '2020-01-01', 1);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('101', '2021', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT shop_id, name, LOCATION, district, number_products, manager_name, AVG(number_products) OVER () AS meannumber_products FROM shop) ORDER BY number_products DESC) LIMIT 3);

/*
Gold Result:
('Gamma',)
('Delta',)
('Alpha',)
*/

-- Prediction Query
SELECT name FROM shop WHERE number_products > (SELECT AVG(number_products) FROM shop);

/*
Prediction Result:
('Gamma',)
('Delta',)
*/