-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic counting, filtering (n > n_other), DISTINCT, ORDER BY, and LEFT JOIN vs INNER JOIN (employee with 0 evaluations).
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (1, 'Zack', 30, 'NY');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'Alice', 25, 'LA');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (3, 'Bob', 40, 'SF');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (4, 'Charlie', 35, 'CHI');
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2020', 100.0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2021', 200.0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2022', 300.0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('2', '2020', 150.0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('2', '2021', 250.0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('3', '2020', 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.employee_id AS employee_id, LHS.n AS n, LHS.name AS name, LHS.age AS age, LHS.city AS city, RHS.employee_id AS employee_id_other, RHS.n AS n_other FROM (SELECT LHS.employee_id AS employee_id, LHS.n AS n, RHS.name AS name, RHS.age AS age, RHS.city AS city FROM (SELECT employee_id, COUNT(*) AS n FROM evaluation GROUP BY employee_id) AS LHS INNER JOIN employee AS RHS ON (LHS.employee_id = RHS.employee_id)) AS LHS CROSS JOIN (SELECT employee_id, COUNT(*) AS n FROM evaluation GROUP BY employee_id) AS RHS) WHERE (n > n_other) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT t1.name FROM employee AS t1 JOIN evaluation AS t2 ON t1.Employee_ID = t2.Employee_ID GROUP BY t2.Employee_ID ORDER BY COUNT(*) DESC, t1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zack',)
*/