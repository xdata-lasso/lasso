-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (10, 'TechStore', 'Downtown', 'North', 50, 'Sarah');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (1, 'Zack', 22, 'Austin');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (2, 'Aaron', 45, 'Boston');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (3, 'Mike', 31, 'Chicago');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (4, 'Clara', 28, 'Denver');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (5, 'David', 35, 'Seattle');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (1, 10, '2019-01-01', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (3, 10, '2020-06-15', 0);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (5, 10, '2018-03-10', 1);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('4', '2021', 1500.0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('5', '2020', 2000.0);
INSERT INTO evaluation (Employee_ID, Year_awarded, Bonus) VALUES ('5', '2022', 2500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM employee AS LHS WHERE NOT EXISTS(SELECT 1 FROM evaluation AS RHS WHERE (LHS.employee_id = RHS.employee_id))) ORDER BY name;

/*
Gold Result:
('Aaron',)
('Mike',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM employee WHERE NOT Employee_ID IN (SELECT Employee_ID FROM evaluation);

/*
Prediction Result:
('Zack',)
('Aaron',)
('Mike',)
*/