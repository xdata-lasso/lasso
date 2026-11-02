-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, name, location, district, number_products, manager_name) VALUES (0, 'default2', 'default2', NULL, NULL, 'default1'), (1, 'default1', 'default2', 'default1', 0, 'default2'), (2, 'default1', NULL, NULL, 1, NULL), (3, 'default1', 'default2', 'default2', 1, 'default1'), (4, NULL, 'default1', 'default2', NULL, 'default2'), (5, 'default1', 'default2', 'default2', 1, NULL), (6, 'default1', NULL, 'default2', 0, 'default2'), (7, NULL, 'default2', 'default2', 1, 'default1'), (8, 'default2', 'default1', 'default2', 1, 'default2');
INSERT INTO employee (employee_id, name, age, city) VALUES (0, 'default1', 0, 'default1'), (1, 'default2', 0, 'default1'), (2, 'default2', 0, 'default1'), (3, NULL, NULL, 'default1'), (4, NULL, 1, NULL), (5, 'default1', NULL, NULL), (6, 'default1', 0, 'default2'), (7, 'default2', 1, NULL), (8, 'default2', 1, NULL), (9, 'default2', 0, 'default2'), (10, 'default2', 0, 'default1'), (11, NULL, NULL, NULL);
INSERT INTO hiring (employee_id, shop_id, start_from, is_full_time) VALUES (9, 7, 'default1', 1), (10, 7, 'default1', 0), (0, 2, NULL, 1), (7, 2, 'default2', 1), (11, 0, NULL, 1), (8, 1, NULL, 0), (1, 4, 'default2', 1), (2, 5, NULL, 1), (3, 2, 'default2', 1), (4, 1, 'default2', 0), (5, 3, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT name, COUNT(*) AS n FROM (SELECT LHS.shop_id AS shop_id, LHS.employee_id AS employee_id, LHS.start_from AS start_from, LHS.is_full_time AS is_full_time, RHS.name AS name, RHS.location AS LOCATION, RHS.district AS district, RHS.number_products AS number_products, RHS.manager_name AS manager_name FROM hiring AS LHS INNER JOIN shop AS RHS ON (LHS.shop_id = RHS.shop_id)) GROUP BY name) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'default2')
(3, None)
(7, 'default1')
*/

-- Prediction Query
SELECT COUNT(*), t2.name FROM hiring AS t1 JOIN shop AS t2 ON t1.shop_id = t2.shop_id GROUP BY t2.name;

/*
Prediction Result:
(3, None)
(7, 'default1')
(1, 'default2')
*/