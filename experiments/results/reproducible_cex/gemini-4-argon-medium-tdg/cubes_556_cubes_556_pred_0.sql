-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests the case where shop_id = 1 exists in the shop table, and other shops are hired into,
-- but NO hiring record exists for shop_id = 1.
-- The Reference Query should return an empty result, whereas a mutant joining on shop_id = shop_id will return 'Zeta Shop' and 'Eta Shop'.
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (201, 'David', 28, 'Seattle');
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (202, 'Eva', 40, 'Boston');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (1, 'Omega Shop', 'Loc1', 'Dist1', 50, 'Mgr1');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (2, 'Zeta Shop', 'Loc2', 'Dist2', 60, 'Mgr2');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (3, 'Eta Shop', 'Loc3', 'Dist3', 70, 'Mgr3');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (201, 2, '2019-05-10', 1);
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (202, 3, '2018-03-15', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.shop_id AS shop_id, LHS.name AS name, LHS.location AS LOCATION, LHS.district AS district, LHS.number_products AS number_products, LHS.manager_name AS manager_name, RHS.employee_id AS employee_id, RHS.start_from AS start_from, RHS.is_full_time AS is_full_time, RHS.shop_id_other AS shop_id_other, RHS.n AS n FROM shop AS LHS INNER JOIN (SELECT shop_id, employee_id, start_from, is_full_time, shop_id_other, shop_id AS n FROM (SELECT LHS.shop_id AS shop_id, LHS.employee_id AS employee_id, LHS.start_from AS start_from, LHS.is_full_time AS is_full_time, RHS.shop_id AS shop_id_other FROM hiring AS LHS INNER JOIN (SELECT shop_id, COUNT(*) AS n FROM shop GROUP BY shop_id) AS RHS ON (LHS.shop_id = RHS.n))) AS RHS ON (LHS.shop_id = RHS.shop_id)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT t2.name FROM hiring AS t1 JOIN shop AS t2 ON t1.shop_id = t2.shop_id GROUP BY t1.shop_id ORDER BY COUNT(*) DESC, t2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Eta Shop',)
*/