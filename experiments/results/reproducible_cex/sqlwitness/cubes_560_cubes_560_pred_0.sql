-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (employee_id, name, age, city) VALUES (0, 'default2', 2, NULL), (1, 'default2', NULL, 'default1'), (2, 'default1', 2, NULL), (3, 'default1', 0, 'default2'), (4, 'default1', 1, 'default1'), (5, 'default1', 0, 'default1'), (6, 'default2', NULL, 'default2'), (7, NULL, 0, NULL), (8, 'default1', NULL, NULL);
INSERT INTO evaluation (employee_id, year_awarded, bonus) VALUES (6, 'default2', 1.0), (2, 'default1', NULL), (8, 'default2', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.employee_id AS employee_id, LHS.name AS name, LHS.age AS age, LHS.city AS city, RHS.year_awarded AS year_awarded, RHS.bonus AS bonus FROM employee AS LHS INNER JOIN evaluation AS RHS ON (LHS.employee_id = RHS.employee_id)) ORDER BY age DESC) LIMIT 1);

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT t1.name FROM employee AS t1 JOIN evaluation AS t2 ON t1.Employee_ID = t2.Employee_ID ORDER BY t2.bonus DESC, t1.employee_id NULLS LAST, t2.employee_id NULLS LAST, t2.year_awarded NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/