-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (1, 'Alice', 30, 'New York');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (2, 'Bob', 25, 'Chicago');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (3, 'Charlie', 35, 'Boston');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (4, 'Diana', 28, 'Seattle');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (5, 'Evan', 40, 'Austin');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (10, 'TechMart', 'Downtown', 'North', 500, 'Grace');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (20, 'BookHaven', 'Uptown', 'East', 1200, 'Henry');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (30, 'FreshGrocer', 'Midtown', 'West', 800, 'Irene');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (40, 'UnusedShop', 'Suburb', 'South', 150, 'Jack');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (1, 30, '2021-06-01', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (2, 10, '2023-01-15', 0);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (3, 20, '2020-11-20', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (4, 10, '2019-03-10', 1);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2021', 1500.50);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2022', 2000.00);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('2', '2023', 500.00);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('5', '2020', 3000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_id, employee_id, start_from, is_full_time FROM hiring ORDER BY shop_id, hiring.employee_id NULLS LAST;

/*
Gold Result:
(10, 2, '2023-01-15', 0)
(10, 4, '2019-03-10', 1)
(20, 3, '2020-11-20', 1)
(30, 1, '2021-06-01', 1)
*/

-- Prediction Query
SELECT * FROM hiring;

/*
Prediction Result:
(1, 30, '2021-06-01', 1)
(2, 10, '2023-01-15', 0)
(3, 20, '2020-11-20', 1)
(4, 10, '2019-03-10', 1)
*/