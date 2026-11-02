-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (1, 'Alice', NULL, 'Boston');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (2, NULL, 30, 'Boston');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (3, 'Bob', 25, 'Austin');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (4, 'Bob', 25, 'Austin');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (5, 'Charlie', 35, NULL);
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (6, 'Diana', 28, NULL);
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (7, 'Evan', 40, 'Chicago');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (8, 'Fiona', 22, 'Denver');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (9, 'George', 29, 'Denver');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (10, 'Hannah', 31, 'Denver');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (101, 'Central Mart', 'Chicago', 'North', 500, 'Evan');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (1, 101, '2020-01-01', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (3, 101, '2021-06-15', 0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2021', 1000.0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2022', 1500.0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('7', '2022', 800.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, city FROM (SELECT city, COUNT(*) AS n FROM employee GROUP BY city) ORDER BY count___, city NULLS LAST;

/*
Gold Result:
(1, 'Chicago')
(2, 'Austin')
(2, 'Boston')
(2, None)
(3, 'Denver')
*/

-- Prediction Query
SELECT COUNT(*), city FROM employee GROUP BY city;

/*
Prediction Result:
(2, None)
(2, 'Austin')
(2, 'Boston')
(1, 'Chicago')
(3, 'Denver')
*/