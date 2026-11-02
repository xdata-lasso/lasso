-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (1, 'Alice Smith', 30, 'Boston');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (2, 'Bob Jones', 25, 'Austin');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (3, 'Charlie Brown', 40, 'New York');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (4, 'Diana Prince', 35, 'Chicago');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (101, 'NY Mart', 'New York', 'Manhattan', 50, 'John Doe');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (102, 'NY Mart', 'New York', 'Manhattan', 50, 'John Doe');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (103, NULL, 'New York', NULL, NULL, NULL);
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (104, 'Windy Shop', 'Chicago', 'Loop', 100, 'Jane Roe');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (105, 'Bean Store', 'Boston', 'Back Bay', 20, 'Sam Adams');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (106, 'Harbor Shop', 'Boston', 'Seaport', 30, 'Paul Revere');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (107, 'Lone Star', 'Austin', 'Downtown', 40, 'Jim Bowie');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (108, 'Capitol Goods', 'Austin', 'South Congress', 60, 'Sam Houston');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (1, 107, '2020-01-15', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (2, 107, '2021-03-10', 0);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (3, 107, '2022-06-01', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (4, 101, '2019-11-20', 1);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2021', 1500.0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('2', '2022', 800.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, LOCATION FROM (SELECT LOCATION, COUNT(*) AS n FROM shop GROUP BY LOCATION) ORDER BY count___, LOCATION NULLS LAST;

/*
Gold Result:
(1, 'Chicago')
(2, 'Austin')
(2, 'Boston')
(3, 'New York')
*/

-- Prediction Query
SELECT COUNT(*), LOCATION FROM shop GROUP BY LOCATION;

/*
Prediction Result:
(2, 'Austin')
(2, 'Boston')
(1, 'Chicago')
(3, 'New York')
*/