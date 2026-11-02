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
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (1, 'Zeta Mart', '100 Main St', 'North', 50, 'Manager Z');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (2, 'Beta Store', '200 Oak St', 'South', 120, 'Manager B');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (3, 'Alpha Shop', '300 Pine St', 'East', 80, 'Manager A');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (4, 'Gamma Boutique', '400 Elm St', 'West', 200, 'Manager G');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (1, 2, '2020-01-15', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (2, 2, '2021-06-01', 0);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (3, 4, '2019-11-20', 1);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('1', '2021', 1500.0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('3', '2022', 2000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM hiring AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY name;

/*
Gold Result:
('Alpha Shop',)
('Zeta Mart',)
*/

-- Prediction Query
SELECT name FROM shop WHERE NOT shop_id IN (SELECT shop_id FROM hiring);

/*
Prediction Result:
('Zeta Mart',)
('Alpha Shop',)
*/