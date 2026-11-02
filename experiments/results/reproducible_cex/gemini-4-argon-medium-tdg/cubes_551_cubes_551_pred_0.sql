-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Grouping by shop.Name vs grouping by shop.Shop_ID (two distinct shops sharing the same Name 'Alpha').
-- 2. INNER JOIN vs LEFT/RIGHT JOIN (Shop 'Delta' has 0 hirings; Employee 6 has NULL Shop_ID in hiring).
-- 3. ORDER BY count___ ASC, name ASC with ties in count ('Beta' and 'Gamma' both have 1 hiring, 'Alpha' has 3).
-- 4. Filtering mutations on Is_full_time or Start_from (mix of 0, 1, NULL).
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (1, 'EmpA', 25, 'NY');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'EmpB', 30, 'LA');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (3, 'EmpC', 35, 'SF');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (4, 'EmpD', 28, 'NY');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (5, 'EmpE', 40, 'LA');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (6, 'EmpF', 22, 'CHI');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (7, 'EmpG', 50, 'BOS');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (10, 'Alpha', 'Loc1', 'D1', 100, 'Mgr1');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (20, 'Alpha', 'Loc2', 'D2', 200, 'Mgr2');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (30, 'Gamma', 'Loc3', 'D3', 150, 'Mgr3');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (40, 'Beta', 'Loc4', 'D4', 300, 'Mgr4');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (50, 'Delta', 'Loc5', 'D5', 50, 'Mgr5');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (1, 10, '2020', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (2, 10, '2021', 0);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (3, 20, '2022', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (4, 30, '2019', 0);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (5, 40, NULL, NULL);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (6, NULL, '2023', 1);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2021', 500.0);
INSERT INTO "evaluation" ("Employee_ID", "Year_awarded", "Bonus") VALUES ('1', '2022', 600.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT name, COUNT(*) AS n FROM (SELECT LHS.shop_id AS shop_id, LHS.employee_id AS employee_id, LHS.start_from AS start_from, LHS.is_full_time AS is_full_time, RHS.name AS name, RHS.location AS LOCATION, RHS.district AS district, RHS.number_products AS number_products, RHS.manager_name AS manager_name FROM hiring AS LHS INNER JOIN shop AS RHS ON (LHS.shop_id = RHS.shop_id)) GROUP BY name) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Beta')
(1, 'Gamma')
(3, 'Alpha')
*/

-- Prediction Query
SELECT COUNT(*), t2.name FROM hiring AS t1 JOIN shop AS t2 ON t1.shop_id = t2.shop_id GROUP BY t2.name;

/*
Prediction Result:
(3, 'Alpha')
(1, 'Beta')
(1, 'Gamma')
*/