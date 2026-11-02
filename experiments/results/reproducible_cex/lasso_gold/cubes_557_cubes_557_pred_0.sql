-- Schema DDL
CREATE TABLE "employee" ("Employee_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" INTEGER, "City" TEXT);

CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "District" TEXT, "Number_products" INTEGER, "Manager_name" TEXT);

CREATE TABLE "hiring" ("Employee_ID" INTEGER PRIMARY KEY, "Shop_ID" INTEGER, "Start_from" TEXT, "Is_full_time" INTEGER, FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "evaluation" ("Employee_ID" TEXT, "Year_awarded" TEXT, "Bonus" REAL, PRIMARY KEY ("Employee_ID", "Year_awarded"), FOREIGN KEY ("Employee_ID") REFERENCES "employee" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1020, 'Kimberly Smith', '347 Amber Stream
Sanchezfort, AS 53855', 'customer', 1021, 'Matthew Gomez');
INSERT INTO "shop" ("shop_id", "name", "location", "district", "number_products", "manager_name") VALUES (1022, 'Crystal Whitehead', '65133 Amanda Dam
Whitemouth, IA 10381', 'level', 1022, 'Savannah Garcia');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM shop AS LHS WHERE NOT EXISTS(SELECT 1 FROM hiring AS RHS WHERE (LHS.shop_id = RHS.shop_id))) ORDER BY name;

/*
Gold Result:
('Crystal Whitehead',)
('Kimberly Smith',)
*/

-- Prediction Query
SELECT name FROM shop WHERE NOT shop_id IN (SELECT shop_id FROM hiring);

/*
Prediction Result:
('Kimberly Smith',)
('Crystal Whitehead',)
*/