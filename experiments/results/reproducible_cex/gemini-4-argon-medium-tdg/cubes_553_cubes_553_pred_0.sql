-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULLS FIRST vs NULLS LAST in ORDER BY Name, and WHERE Name IS NOT NULL mutations.
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (10, 'Zack', 22, 'Dallas');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (20, NULL, 28, 'Denver');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (30, 'Aaron', 31, 'Detroit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employee ORDER BY name, employee.employee_id NULLS LAST;

/*
Gold Result:
(None,)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM employee ORDER BY age, employee.employee_id NULLS LAST;

/*
Prediction Result:
('Zack',)
(None,)
('Aaron',)
*/