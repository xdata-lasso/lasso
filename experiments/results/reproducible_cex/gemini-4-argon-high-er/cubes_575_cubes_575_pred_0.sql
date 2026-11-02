-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (1, 'Alice', 30, 'New York');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'Bob', 25, 'Boston');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (10, 'Shop A', 'Loc A', 'Dist A', 100, 'Mgr A');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (20, 'Shop B', 'Loc B', 'Dist B', 200, 'Mgr B');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (1, 20, '2020-01-01', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (2, 10, '2021-01-01', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_id, employee_id, start_from, is_full_time FROM hiring ORDER BY shop_id, hiring.employee_id NULLS LAST;

/*
Gold Result:
(10, 2, '2021-01-01', 0)
(20, 1, '2020-01-01', 1)
*/

-- Prediction Query
SELECT * FROM hiring;

/*
Prediction Result:
(1, 20, '2020-01-01', 1)
(2, 10, '2021-01-01', 0)
*/