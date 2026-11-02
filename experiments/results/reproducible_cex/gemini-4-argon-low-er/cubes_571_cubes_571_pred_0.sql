-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (1, 'B', 30, 'City1');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (2, 'A', 25, 'City2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM employee AS LHS WHERE NOT EXISTS(SELECT 1 FROM evaluation AS RHS WHERE (LHS.employee_id = RHS.employee_id))) ORDER BY name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT name FROM employee WHERE NOT Employee_ID IN (SELECT Employee_ID FROM evaluation);

/*
Prediction Result:
('B',)
('A',)
*/