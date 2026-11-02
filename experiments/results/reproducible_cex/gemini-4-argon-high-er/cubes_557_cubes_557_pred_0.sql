-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employee (Employee_ID, Name, Age, City) VALUES (1, 'Alice', 30, 'NYC');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (1, 'B_Shop', 'Loc1', 'Dist1', 10, 'Mgr1');
INSERT INTO shop (Shop_ID, Name, Location, District, Number_products, Manager_name) VALUES (2, 'A_Shop', 'Loc2', 'Dist2', 20, 'Mgr2');
INSERT INTO hiring (Employee_ID, Shop_ID, Start_from, Is_full_time) VALUES (1, NULL, '2020-01-01', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM hiring AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY name;

/*
Gold Result:
('A_Shop',)
('B_Shop',)
*/

-- Prediction Query
SELECT name FROM shop WHERE NOT shop_id IN (SELECT shop_id FROM hiring);

/*
Prediction Result:
*/