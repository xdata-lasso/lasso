-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, name, location, district, number_products, manager_name) VALUES (0, 'default1', 'default2', NULL, 0, 'default1'), (1, 'default1', 'default1', 'default2', 1, NULL), (2, NULL, NULL, 'default1', 0, 'default1'), (3, 'default1', 'default1', NULL, 0, 'default2'), (4, 'default2', NULL, 'default2', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION, district FROM shop ORDER BY name, shop.shop_id NULLS LAST;

/*
Gold Result:
(None, None, 'default1')
('default1', 'default2', None)
('default1', 'default1', 'default2')
('default1', 'default1', None)
('default2', None, 'default2')
*/

-- Prediction Query
SELECT name, LOCATION, district FROM shop ORDER BY number_products DESC, shop.shop_id NULLS LAST;

/*
Prediction Result:
('default1', 'default1', 'default2')
('default1', 'default2', None)
(None, None, 'default1')
('default1', 'default1', None)
('default2', None, 'default2')
*/