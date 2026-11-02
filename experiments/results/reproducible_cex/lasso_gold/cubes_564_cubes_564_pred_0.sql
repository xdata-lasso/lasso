-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1003, 'Donald Booth', '654 Jason Track
Curtisfurt, CT 47553', 'throw', 1004, 'Dennis Williams');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1009, 'Melissa Robinson', NULL, 'low', 1010, 'Charles Mcgee');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, LOCATION FROM (SELECT LOCATION, COUNT(*) AS n FROM shop GROUP BY LOCATION) ORDER BY count___, LOCATION NULLS LAST;

/*
Gold Result:
(1, '654 Jason Track\nCurtisfurt, CT 47553')
(1, None)
*/

-- Prediction Query
SELECT COUNT(*), LOCATION FROM shop GROUP BY LOCATION;

/*
Prediction Result:
(1, None)
(1, '654 Jason Track\nCurtisfurt, CT 47553')
*/