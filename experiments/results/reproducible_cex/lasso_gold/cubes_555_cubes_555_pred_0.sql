-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1001, 'Allison Hill', 1004, 'North Jefferyhaven');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1002, 'Noah Rhodes', 1011.0, 'New Jamesside');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1003, 'Angie Henderson', 1018.0, 'Robinsonshire');
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1001, 'fall', 1007.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1001, 'table', 1014.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1001, 'true', 1021.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1001, 'according', 1010.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1001, 'song', 1017.5);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES (1001, 'sure', 1024.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.employee_id AS employee_id, LHS.n AS n, LHS.name AS name, LHS.age AS age, LHS.city AS city, RHS.employee_id AS employee_id_other, RHS.n AS n_other FROM (SELECT LHS.employee_id AS employee_id, LHS.n AS n, RHS.name AS name, RHS.age AS age, RHS.city AS city FROM (SELECT employee_id, COUNT(*) AS n FROM evaluation GROUP BY employee_id) AS LHS INNER JOIN employee AS RHS ON (LHS.employee_id = RHS.employee_id)) AS LHS CROSS JOIN (SELECT employee_id, COUNT(*) AS n FROM evaluation GROUP BY employee_id) AS RHS) WHERE (n > n_other) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT t1.name FROM employee AS t1 JOIN evaluation AS t2 ON t1.Employee_ID = t2.Employee_ID GROUP BY t2.Employee_ID ORDER BY COUNT(*) DESC, t1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Allison Hill',)
*/