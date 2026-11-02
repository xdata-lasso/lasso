-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Grouping by shop.Name vs grouping by shop.Shop_ID (Shops 1 and 2 share the name 'Alpha')
-- 2. INNER JOIN vs LEFT/RIGHT JOIN (Shop 3 has 0 hirings; Employee 5 is not hired; Hiring for Employee 4 has NULL Shop_ID)
-- 3. ORDER BY count___ ASC vs DESC, and tie-breaking by name ASC with NULLS LAST
-- 4. COUNT(*) vs COUNT(shop.Name) when shop.Name is NULL (Shop 4)
-- 5. Accidental filtering on Is_full_time or Start_from (NULLs and 0/1 mix)
-- 6. Accidental join with employee table using employee.Name instead of shop.Name
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (1, 'Emp_A', 25, 'NY');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'Emp_B', 30, 'LA');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (3, 'Emp_C', 35, 'Chicago');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (4, 'Emp_D', 40, 'Houston');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (5, 'Emp_E', 45, 'Phoenix');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (6, 'Emp_F', 28, 'Seattle');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (7, 'Emp_G', 32, 'Boston');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (1, 'Alpha', 'Loc1', 'Dist1', 100, 'Mgr1');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (2, 'Alpha', 'Loc2', 'Dist2', 200, 'Mgr2');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (3, 'Beta', 'Loc3', 'Dist3', 150, 'Mgr3');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (4, NULL, 'Loc4', 'Dist4', 50, 'Mgr4');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (5, 'Gamma', 'Loc5', 'Dist5', 300, 'Mgr5');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (6, 'Delta', 'Loc6', 'Dist6', 400, 'Mgr6');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (1, 1, '2020-01-01', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (2, 2, '2020-02-01', 0);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (3, 4, NULL, NULL);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (4, NULL, '2021-01-01', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (6, 5, '2021-05-01', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (7, 6, '2021-06-01', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT name, COUNT(*) AS n FROM (SELECT LHS.shop_id AS shop_id, LHS.employee_id AS employee_id, LHS.start_from AS start_from, LHS.is_full_time AS is_full_time, RHS.name AS name, RHS.location AS LOCATION, RHS.district AS district, RHS.number_products AS number_products, RHS.manager_name AS manager_name FROM hiring AS LHS INNER JOIN shop AS RHS ON (LHS.shop_id = RHS.shop_id)) GROUP BY name) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Delta')
(1, 'Gamma')
(1, None)
(2, 'Alpha')
*/

-- Prediction Query
SELECT COUNT(*), t2.name FROM hiring AS t1 JOIN shop AS t2 ON t1.shop_id = t2.shop_id GROUP BY t2.name;

/*
Prediction Result:
(1, None)
(2, 'Alpha')
(1, 'Delta')
(1, 'Gamma')
*/