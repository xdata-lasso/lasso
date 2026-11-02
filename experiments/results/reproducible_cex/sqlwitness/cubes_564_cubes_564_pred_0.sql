-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO shop (shop_id, name, location, district, number_products, manager_name) VALUES (0, NULL, NULL, NULL, 0, NULL), (1, NULL, 'default2', 'default2', NULL, 'default1'), (2, 'default1', 'default2', 'default2', NULL, NULL), (3, 'default2', 'default1', 'default1', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, LOCATION FROM (SELECT LOCATION, COUNT(*) AS n FROM shop GROUP BY LOCATION) ORDER BY count___, LOCATION NULLS LAST;

/*
Gold Result:
(1, 'default1')
(1, None)
(2, 'default2')
*/

-- Prediction Query
SELECT COUNT(*), LOCATION FROM shop GROUP BY LOCATION;

/*
Prediction Result:
(1, None)
(1, 'default1')
(2, 'default2')
*/