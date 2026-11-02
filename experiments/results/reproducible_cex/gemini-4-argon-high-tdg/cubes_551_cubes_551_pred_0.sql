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
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (3, 'Charlie', 35, 'Chicago');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (4, 'Diana', 28, 'New York');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (5, 'Evan', 40, 'Boston');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (6, 'Fiona', 22, 'Seattle');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (7, 'George', 50, 'Austin');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (10, 'Zeta Mart', 'Downtown', 'North', 100, 'Sarah');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (20, 'Alpha Store', 'Uptown', 'South', 250, 'Mike');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (30, 'Beta Boutique', 'Midtown', 'East', 50, 'Laura');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (40, 'Ghost Shop', 'Suburb', 'West', 75, 'Tom');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (1, 10, '2020-01-15', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (2, 10, '2021-03-10', 0);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (3, 20, '2019-07-01', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (4, 20, '2022-05-20', 0);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (5, 30, '2023-02-01', 0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2021', 1500.0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2022', 2000.0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('3', '2020', 1200.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT name, COUNT(*) AS n FROM (SELECT LHS.shop_id AS shop_id, LHS.employee_id AS employee_id, LHS.start_from AS start_from, LHS.is_full_time AS is_full_time, RHS.name AS name, RHS.location AS LOCATION, RHS.district AS district, RHS.number_products AS number_products, RHS.manager_name AS manager_name FROM hiring AS LHS INNER JOIN shop AS RHS ON (LHS.shop_id = RHS.shop_id)) GROUP BY name) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Beta Boutique')
(2, 'Alpha Store')
(2, 'Zeta Mart')
*/

-- Prediction Query
SELECT COUNT(*), t2.name FROM hiring AS t1 JOIN shop AS t2 ON t1.shop_id = t2.shop_id GROUP BY t2.name;

/*
Prediction Result:
(2, 'Alpha Store')
(1, 'Beta Boutique')
(2, 'Zeta Mart')
*/