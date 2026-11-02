-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests duplicate values across all non-PK columns (especially Location) and NULLs in every nullable column, plus unmatched/matched foreign keys in related tables.
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (1, 'Alice', 30, 'New York');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'Bob', 25, 'Los Angeles');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (3, 'Charlie', 35, 'Chicago');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (1, 'Shop A', 'Downtown', 'Dist 1', 100, 'Mgr 1');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (2, 'Shop A', 'Downtown', 'Dist 1', 100, 'Mgr 1');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (4, 'Shop B', 'Uptown', 'Dist 2', 0, 'Mgr 2');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (1, 1, '2020-01-01', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (2, 1, '2021-01-01', 0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2022', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_location_ FROM (SELECT COUNT(*) AS n FROM shop) ORDER BY count_distinct_location_;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT LOCATION) FROM shop;

/*
Prediction Result:
(2,)
*/