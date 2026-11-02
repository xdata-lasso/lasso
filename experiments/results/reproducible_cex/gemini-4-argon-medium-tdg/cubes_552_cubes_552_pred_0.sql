-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, COUNT(*), primary sorting by count ASC, and secondary sorting by city ASC (where city alphabetical order opposes count order).
-- Also includes unreferenced employees and 1-to-many evaluations to catch spurious JOINs with other tables.
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (1, 'Alice', 30, 'ZooCity');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'Bob', 25, 'AlphaCity');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (3, 'Charlie', 25, 'AlphaCity');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (4, 'David', 40, 'BetaCity');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (5, 'Eve', 35, 'BetaCity');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (6, 'Frank', 28, 'BetaCity');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (10, 'Main Shop', 'ZooCity', 'North', 100, 'Alice');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (1, 10, '2020-01-01', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (2, 10, '2021-01-01', 0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2021', 500.0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2022', 600.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, city FROM (SELECT city, COUNT(*) AS n FROM employee GROUP BY city) ORDER BY count___, city NULLS LAST;

/*
Gold Result:
(1, 'ZooCity')
(2, 'AlphaCity')
(3, 'BetaCity')
*/

-- Prediction Query
SELECT COUNT(*), city FROM employee GROUP BY city;

/*
Prediction Result:
(2, 'AlphaCity')
(3, 'BetaCity')
(1, 'ZooCity')
*/