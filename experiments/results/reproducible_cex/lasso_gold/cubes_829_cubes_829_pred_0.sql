-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (1024, 'Gina Moore', 1025, 1027.5);
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (1027, 'Ryan Munoz', 1026, 1026.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT market_rate, name FROM (SELECT * FROM furniture AS LHS WHERE NOT EXISTS(SELECT 1 FROM furniture_manufacte AS RHS WHERE (LHS.furniture_id = RHS.furniture_id))) ORDER BY market_rate, name NULLS LAST;

/*
Gold Result:
(1026.5, 'Ryan Munoz')
(1027.5, 'Gina Moore')
*/

-- Prediction Query
SELECT Market_Rate, name FROM furniture WHERE NOT Furniture_ID IN (SELECT Furniture_ID FROM furniture_manufacte);

/*
Prediction Result:
(1027.5, 'Gina Moore')
(1026.5, 'Ryan Munoz')
*/