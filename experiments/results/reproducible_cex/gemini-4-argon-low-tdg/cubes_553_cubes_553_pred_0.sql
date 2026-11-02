-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic alphabetical sorting, duplicate names (catches DISTINCT mutants), out-of-order insertion (catches missing ORDER BY), and disjoint tables (catches unintended JOINs with hiring/evaluation/shop).
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (1, 'Charlie', 30, 'Boston');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (2, 'Alice', 25, 'New York');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (3, 'Bob', 40, 'Chicago');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (4, 'Alice', 35, 'Seattle');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (10, 'Zeta Store', 'Downtown', 'D1', 100, 'Eve');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (1, 10, '2020-01-01', 1);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2021', 500.0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2022', 600.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM employee ORDER BY name, employee.employee_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM employee ORDER BY age, employee.employee_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Charlie',)
('Alice',)
('Bob',)
*/