-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1024, 'Melinda Jones', 1025, 'New Jessica');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1026, 'James Mayo', 1027, 'New Jessica');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1028, 'Amy Underwood', 1029, 'New Nancy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, city FROM (SELECT city, COUNT(*) AS n FROM employee GROUP BY city) ORDER BY count___, city NULLS LAST;

/*
Gold Result:
(1, 'New Nancy')
(2, 'New Jessica')
*/

-- Prediction Query
SELECT COUNT(*), city FROM employee GROUP BY city;

/*
Prediction Result:
(2, 'New Jessica')
(1, 'New Nancy')
*/