-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (1, 'EmpA', 25, 'CityA');
INSERT INTO "employee" ("Employee_ID", "Name", "Age", "City") VALUES (2, 'EmpB', 30, 'CityB');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (10, 'Zeta Shop', 'Loc1', 'Dist1', 100, 'Mgr1');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (20, 'Alpha Shop', 'Loc2', 'Dist2', 200, 'Mgr2');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (30, 'Alpha Shop', 'Loc3', 'Dist3', 300, 'Mgr3');
INSERT INTO "shop" ("Shop_ID", "Name", "Location", "District", "Number_products", "Manager_name") VALUES (40, 'Beta Shop', 'Loc4', 'Dist4', 400, 'Mgr4');
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (1, 40, '2020', 1);
INSERT INTO "hiring" ("Employee_ID", "Shop_ID", "Start_from", "Is_full_time") VALUES (2, 40, '2021', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM hiring AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY name;

/*
Gold Result:
('Alpha Shop',)
('Alpha Shop',)
('Zeta Shop',)
*/

-- Prediction Query
SELECT name FROM shop WHERE NOT shop_id IN (SELECT shop_id FROM hiring);

/*
Prediction Result:
('Zeta Shop',)
('Alpha Shop',)
('Alpha Shop',)
*/