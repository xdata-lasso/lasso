-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic INNER JOIN vs LEFT JOIN, ORDER BY Age DESC vs ASC, and ensures the query joins `evaluation` rather than `hiring`.
-- The oldest overall employee (Alice, 60) has no evaluation, only a hiring record.
-- The oldest evaluated employee (Bob, 50) should be returned.
-- The youngest evaluated employee (Charlie, 25) tests ASC vs DESC sorting.
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (1, 'Alice', 60, 'New York');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'Bob', 50, 'Chicago');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (3, 'Charlie', 25, 'Boston');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (10, 'Central Shop', 'Downtown', 'D1', 100, 'Alice');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (1, 10, '2020-01-01', 1);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('2', '2022', 1000.0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('3', '2021', 5000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.employee_id AS employee_id, LHS.name AS name, LHS.age AS age, LHS.city AS city, RHS.year_awarded AS year_awarded, RHS.bonus AS bonus FROM employee AS LHS INNER JOIN evaluation AS RHS ON (LHS.employee_id = RHS.employee_id)) ORDER BY age DESC) LIMIT 1);

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT t1.name FROM employee AS t1 JOIN evaluation AS t2 ON t1.Employee_ID = t2.Employee_ID ORDER BY t2.bonus DESC, t1.employee_id NULLS LAST, t2.employee_id NULLS LAST, t2.year_awarded NULLS LAST LIMIT 1;

/*
Prediction Result:
('Charlie',)
*/