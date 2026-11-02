-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO furniture (furniture_id, name, num_of_component, market_rate) VALUES (1, 'default1', 9, 10.0), (9, 'default2', 11, NULL), (11, 'default2', 0, 11.0), (10, NULL, 10, 11.0), (0, NULL, 9, 11.0), (2, 'default1', 11, 0.0), (3, 'default2', NULL, 1.0), (4, NULL, 0, 9.0), (5, NULL, NULL, 0.0), (6, 'default1', 0, 0.0), (7, NULL, 0, 10.0), (8, 'default1', 9, 0.0), (12, NULL, NULL, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT num_of_component, name FROM furniture WHERE (num_of_component > 10) ORDER BY num_of_component, furniture.furniture_id NULLS LAST;

/*
Gold Result:
(11, 'default1')
(11, 'default2')
*/

-- Prediction Query
SELECT Num_of_Component, name FROM furniture WHERE Num_of_Component > 10;

/*
Prediction Result:
(11, 'default1')
(11, 'default2')
*/