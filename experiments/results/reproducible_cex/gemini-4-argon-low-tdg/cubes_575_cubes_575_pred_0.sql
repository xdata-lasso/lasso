-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (1, 'Alice', 30, 'New York');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (2, 'Bob', 25, 'Boston');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (3, 'Charlie', 40, 'Chicago');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (4, 'David', 35, 'Seattle');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (5, 'Eve', 28, 'Miami');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (10, 'Market A', 'Downtown', 'North', 100, 'John');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (20, 'Market B', 'Uptown', 'South', 200, 'Jane');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (30, 'Market C', 'Suburb', 'West', 150, 'Jim');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (3, 20, '2020-01-01', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (1, 20, '2021-06-15', 0);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (2, 10, '2019-03-10', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (4, 10, '2022-11-20', 0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2022', 1000.0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2023', 1500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_id, employee_id, start_from, is_full_time FROM hiring ORDER BY shop_id, hiring.employee_id NULLS LAST;

/*
Gold Result:
(10, 2, '2019-03-10', 1)
(10, 4, '2022-11-20', 0)
(20, 1, '2021-06-15', 0)
(20, 3, '2020-01-01', 1)
*/

-- Prediction Query
SELECT * FROM hiring;

/*
Prediction Result:
(1, 20, '2021-06-15', 0)
(2, 10, '2019-03-10', 1)
(3, 20, '2020-01-01', 1)
(4, 10, '2022-11-20', 0)
*/