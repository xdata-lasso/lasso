-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, name, location, district, number_products, manager_name) VALUES (0, 'default2', 'default1', 'default1', 1, 'default2'), (1, 'default2', 'default2', NULL, 2, NULL), (2, 'default2', NULL, 'default2', 2, 'default2'), (3, NULL, 'default1', 'default2', 2, 'default1'), (4, 'default1', 'default2', NULL, 1, 'default2'), (5, NULL, NULL, 'default1', 0, NULL);
INSERT INTO employee (employee_id, name, age, city) VALUES (1, NULL, 2, NULL), (0, 'default2', 2, 'default2');
INSERT INTO hiring (employee_id, shop_id, start_from, is_full_time) VALUES (1, 0, NULL, 1), (0, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM hiring AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM shop WHERE NOT shop_id IN (SELECT shop_id FROM hiring);

/*
Prediction Result:
('default2',)
(None,)
('default1',)
(None,)
*/