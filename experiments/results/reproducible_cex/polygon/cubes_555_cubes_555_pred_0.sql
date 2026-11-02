-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (21, '29', 30, NULL);
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (22, '32', 33, NULL);
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (20, '1', '1', '1', 1, '1');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (19, '1', '1', '1', 1, '1');
INSERT INTO "hiring" ("employee_id", "shop_id", "start_from", "is_full_time") VALUES (21, 19, '1', 1);
INSERT INTO "hiring" ("employee_id", "shop_id", "start_from", "is_full_time") VALUES (22, NULL, '1', 1);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES ('22', '24', 43);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES ('21', '23', NULL);
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
('29',)
*/