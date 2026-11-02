-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO furniture (furniture_id, name, num_of_component, market_rate) VALUES (0, 'default1', 1, 2.0), (2, 'default1', NULL, NULL);
INSERT INTO manufacturer (manufacturer_id, open_year, name, num_of_factories, num_of_shops) VALUES (2, 1.0, 'default1', 1, NULL), (1, NULL, 'default1', NULL, 1), (0, NULL, 'default2', 0, 1), (3, NULL, NULL, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT market_rate, name FROM (SELECT * FROM furniture AS LHS WHERE NOT EXISTS(SELECT 1 FROM furniture_manufacte AS RHS WHERE (LHS.furniture_id = RHS.furniture_id))) ORDER BY market_rate, name NULLS LAST;

/*
Gold Result:
(None, 'default1')
(2.0, 'default1')
*/

-- Prediction Query
SELECT Market_Rate, name FROM furniture WHERE NOT Furniture_ID IN (SELECT Furniture_ID FROM furniture_manufacte);

/*
Prediction Result:
(2.0, 'default1')
(None, 'default1')
*/