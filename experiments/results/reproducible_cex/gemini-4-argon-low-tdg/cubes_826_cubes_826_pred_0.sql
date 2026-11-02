-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (10, 'Zebra Sofa', 15, 100.0);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (20, 'Alpha Bed', 15, 200.0);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (5, 'Middle Wardrobe', 15, 50.0);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (1, 'Cabinet', 25, 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT num_of_component, name FROM furniture WHERE (num_of_component > 10) ORDER BY num_of_component, furniture.furniture_id NULLS LAST;

/*
Gold Result:
(15, 'Middle Wardrobe')
(15, 'Zebra Sofa')
(15, 'Alpha Bed')
(25, 'Cabinet')
*/

-- Prediction Query
SELECT Num_of_Component, name FROM furniture WHERE Num_of_Component > 10;

/*
Prediction Result:
(25, 'Cabinet')
(15, 'Middle Wardrobe')
(15, 'Zebra Sofa')
(15, 'Alpha Bed')
*/