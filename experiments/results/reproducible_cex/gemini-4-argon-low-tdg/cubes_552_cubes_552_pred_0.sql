-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, primary ORDER BY count___ ASC vs DESC, secondary ORDER BY city ASC vs DESC, and DISTINCT vs non-DISTINCT counts.
-- Also includes rows in shop, hiring, and evaluation to kill mutants that erroneously JOIN other tables or query shop.Location / shop.District.
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (1, 'Alice', 30, 'Boston');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'Bob', 25, 'Boston');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (3, 'Charlie', 35, 'Austin');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (4, 'David', 28, 'Chicago');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (5, 'Eve', 40, 'Denver');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (6, 'Frank', 22, 'Denver');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (7, 'Grace', 29, 'Denver');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (101, 'MegaMart', 'Seattle', 'North', 500, 'Alice');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (102, 'MiniMart', 'Miami', 'South', 150, 'Bob');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (1, 101, '2020-01-01', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (3, 102, '2021-06-15', 0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2021', 1000.0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2022', 1500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, city FROM (SELECT city, COUNT(*) AS n FROM employee GROUP BY city) ORDER BY count___, city NULLS LAST;

/*
Gold Result:
(1, 'Austin')
(1, 'Chicago')
(2, 'Boston')
(3, 'Denver')
*/

-- Prediction Query
SELECT COUNT(*), city FROM employee GROUP BY city;

/*
Prediction Result:
(1, 'Austin')
(2, 'Boston')
(1, 'Chicago')
(3, 'Denver')
*/