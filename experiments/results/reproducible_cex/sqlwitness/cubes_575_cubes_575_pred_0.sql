-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, name, location, district, number_products, manager_name) VALUES (1, 'default2', 'default1', 'default1', NULL, 'default2'), (0, NULL, 'default2', NULL, 0, 'default1'), (2, 'default1', 'default2', NULL, 1, 'default2');
INSERT INTO employee (employee_id, name, age, city) VALUES (1, NULL, 1, 'default2'), (0, 'default2', 1, NULL);
INSERT INTO hiring (employee_id, shop_id, start_from, is_full_time) VALUES (1, NULL, NULL, NULL), (0, 2, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT shop_id, employee_id, start_from, is_full_time FROM hiring ORDER BY shop_id, hiring.employee_id NULLS LAST;

/*
Gold Result:
(None, 1, None, None)
(2, 0, None, 1)
*/

-- Prediction Query
SELECT * FROM hiring;

/*
Prediction Result:
(0, 2, None, 1)
(1, None, None, None)
*/