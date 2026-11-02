-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1011, 'Mark Ferguson', 1012, 'East Steven');
INSERT INTO "employee" ("employee_id", "name", "age", "city") VALUES (1016, 'Daniel Bright', 1017, 'Daviston');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1014, 'Timothy Watts', '30564 Jason Port Suite 376
Thomasberg, IA 98148', 'option', 1014, 'Nicole Patterson');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1013, 'Brittany Moore', '6978 Maddox Wall
Lake Jenniferside, WV 35474', 'specific', 1019, 'Ashley Graham');
INSERT INTO "hiring" ("employee_id", "shop_id", "start_from", "is_full_time") VALUES (1011, 1014, 'long', 1015);
INSERT INTO "hiring" ("employee_id", "shop_id", "start_from", "is_full_time") VALUES (1016, 1013, 'past', 1016);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_id, employee_id, start_from, is_full_time FROM hiring ORDER BY shop_id, hiring.employee_id NULLS LAST;

/*
Gold Result:
(1013, 1016, 'past', 1016)
(1014, 1011, 'long', 1015)
*/

-- Prediction Query
SELECT * FROM hiring;

/*
Prediction Result:
(1011, 1014, 'long', 1015)
(1016, 1013, 'past', 1016)
*/