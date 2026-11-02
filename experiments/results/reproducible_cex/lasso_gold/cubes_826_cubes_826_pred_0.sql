-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (1026, 'Lisa Hensley', 12, 1027.5);
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (1028, 'Michele Williams', 11, 1028.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT num_of_component, name FROM furniture WHERE (num_of_component > 10) ORDER BY num_of_component, furniture.furniture_id NULLS LAST;

/*
Gold Result:
(11, 'Michele Williams')
(12, 'Lisa Hensley')
*/

-- Prediction Query
SELECT Num_of_Component, name FROM furniture WHERE Num_of_Component > 10;

/*
Prediction Result:
(12, 'Lisa Hensley')
(11, 'Michele Williams')
*/