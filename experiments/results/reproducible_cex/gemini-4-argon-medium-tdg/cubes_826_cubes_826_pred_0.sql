-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WHERE boundary conditions (>, >=, =, <, <=, NULL) and primary ORDER BY (ASC vs DESC)
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (1, 'Chair', 9, 10.5);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (2, 'Table', 10, 20.0);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (3, 'Desk', 15, 30.0);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (4, 'Sofa', 11, 40.0);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (5, 'Stool', NULL, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT num_of_component, name FROM furniture WHERE (num_of_component > 10) ORDER BY num_of_component, furniture.furniture_id NULLS LAST;

/*
Gold Result:
(11, 'Sofa')
(15, 'Desk')
*/

-- Prediction Query
SELECT Num_of_Component, name FROM furniture WHERE Num_of_Component > 10;

/*
Prediction Result:
(15, 'Desk')
(11, 'Sofa')
*/