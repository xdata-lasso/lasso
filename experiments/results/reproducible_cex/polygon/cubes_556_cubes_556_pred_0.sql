-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (19, '1', 1, '1');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (29, '1', 1, '1');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (20, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1, NULL, '38', '39', 40, NULL);
INSERT INTO "hiring" ("employee_id", "shop_id", "start_from", "is_full_time") VALUES (19, 20, NULL, NULL);
INSERT INTO "hiring" ("employee_id", "shop_id", "start_from", "is_full_time") VALUES (29, 1, NULL, NULL);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES ('29', '1', 1);
INSERT INTO "evaluation" ("employee_id", "year_awarded", "bonus") VALUES ('19', '1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.shop_id AS shop_id, LHS.name AS name, LHS.location AS LOCATION, LHS.district AS district, LHS.number_products AS number_products, LHS.manager_name AS manager_name, RHS.employee_id AS employee_id, RHS.start_from AS start_from, RHS.is_full_time AS is_full_time, RHS.shop_id_other AS shop_id_other, RHS.n AS n FROM shop AS LHS INNER JOIN (SELECT shop_id, employee_id, start_from, is_full_time, shop_id_other, shop_id AS n FROM (SELECT LHS.shop_id AS shop_id, LHS.employee_id AS employee_id, LHS.start_from AS start_from, LHS.is_full_time AS is_full_time, RHS.shop_id AS shop_id_other FROM hiring AS LHS INNER JOIN (SELECT shop_id, COUNT(*) AS n FROM shop GROUP BY shop_id) AS RHS ON (LHS.shop_id = RHS.n))) AS RHS ON (LHS.shop_id = RHS.shop_id)) ORDER BY name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT t2.name FROM hiring AS t1 JOIN shop AS t2 ON t1.shop_id = t2.shop_id GROUP BY t1.shop_id ORDER BY COUNT(*) DESC, t2.name NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/