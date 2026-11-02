-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY Location, primary ORDER BY count ASC, and secondary ORDER BY Location ASC on ties.
-- Also tests unintended inner joins with hiring/employee by leaving hiring empty.
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (1, 'Shop A', 'East', 'D1', 10, 'Alice');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (2, 'Shop B', 'West', 'D2', 20, 'Bob');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (3, 'Shop C', 'West', 'D2', 30, 'Charlie');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (4, 'Shop D', 'North', 'D3', 40, 'David');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (5, 'Shop E', 'North', 'D3', 50, 'Eve');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (6, 'Shop F', 'South', 'D4', 60, 'Frank');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (7, 'Shop G', 'South', 'D4', 70, 'Grace');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (8, 'Shop H', 'South', 'D4', 80, 'Heidi');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, LOCATION FROM (SELECT LOCATION, COUNT(*) AS n FROM shop GROUP BY LOCATION) ORDER BY count___, LOCATION NULLS LAST;

/*
Gold Result:
(1, 'East')
(2, 'North')
(2, 'West')
(3, 'South')
*/

-- Prediction Query
SELECT COUNT(*), LOCATION FROM shop GROUP BY LOCATION;

/*
Prediction Result:
(1, 'East')
(2, 'North')
(3, 'South')
(2, 'West')
*/