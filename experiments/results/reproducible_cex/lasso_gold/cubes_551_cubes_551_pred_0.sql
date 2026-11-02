-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1006, 'Phillip Garcia', 1007, 'Davisstad');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1021, 'Gina Carter', 1022, 'South Aaron');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1026, 'Dr. Cynthia Allen', 1027, 'North Jessicaland');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1008, 'Renee Blair', '84959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 'hear', 1009, 'Derek Zuniga');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1023, 'Michelle Stanton', '489 Eric Track
New Stephanie, NC 00575', 'place', 1024, 'Alec Hickman');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1028, 'Michelle Stanton', 'Unit 8227 Box 8248
DPO AP 55962', 'development', 1029, 'Nicole Vaughn');
INSERT INTO "hiring" ("employee_id", "shop_id", "start_from", "is_full_time") VALUES (1006, 1008, 'raise', 1010);
INSERT INTO "hiring" ("employee_id", "shop_id", "start_from", "is_full_time") VALUES (1021, 1023, 'unit', NULL);
INSERT INTO "hiring" ("employee_id", "shop_id", "start_from", "is_full_time") VALUES (1026, 1028, 'sell', 1030);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT name, COUNT(*) AS n FROM (SELECT LHS.shop_id AS shop_id, LHS.employee_id AS employee_id, LHS.start_from AS start_from, LHS.is_full_time AS is_full_time, RHS.name AS name, RHS.location AS LOCATION, RHS.district AS district, RHS.number_products AS number_products, RHS.manager_name AS manager_name FROM hiring AS LHS INNER JOIN shop AS RHS ON (LHS.shop_id = RHS.shop_id)) GROUP BY name) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Renee Blair')
(2, 'Michelle Stanton')
*/

-- Prediction Query
SELECT COUNT(*), t2.name FROM hiring AS t1 JOIN shop AS t2 ON t1.shop_id = t2.shop_id GROUP BY t2.name;

/*
Prediction Result:
(2, 'Michelle Stanton')
(1, 'Renee Blair')
*/