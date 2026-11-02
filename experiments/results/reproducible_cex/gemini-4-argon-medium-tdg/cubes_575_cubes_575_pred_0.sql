-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests negative, zero, and multi-digit numbers to catch string vs integer sorting mutations (e.g., CAST to TEXT in ORDER BY), and ensures columns with identical values across rows are not collapsed by an erroneous DISTINCT if PK differs.
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (-5, 'NegEmp', 30, 'CityX');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (0, 'ZeroEmp', 30, 'CityX');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'TwoEmp', 30, 'CityX');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (10, 'TenEmp', 30, 'CityX');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (-10, 'NegShop', 'Loc', 'Dist', 10, 'Mgr');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (2, 'TwoShop', 'Loc', 'Dist', 10, 'Mgr');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (10, 'TenShop', 'Loc', 'Dist', 10, 'Mgr');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (10, 2, '2020-01-01', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (2, 2, '2020-01-01', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (0, 10, '2020-01-01', 0);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (-5, -10, '2020-01-01', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_id, employee_id, start_from, is_full_time FROM hiring ORDER BY shop_id, hiring.employee_id NULLS LAST;

/*
Gold Result:
(-10, -5, '2020-01-01', 0)
(2, 2, '2020-01-01', 1)
(2, 10, '2020-01-01', 1)
(10, 0, '2020-01-01', 0)
*/

-- Prediction Query
SELECT * FROM hiring;

/*
Prediction Result:
(-5, -10, '2020-01-01', 0)
(0, 10, '2020-01-01', 0)
(2, 2, '2020-01-01', 1)
(10, 2, '2020-01-01', 1)
*/