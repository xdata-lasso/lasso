-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO furniture (furniture_id, name, num_of_component, market_rate) VALUES (0, 'default2', NULL, 2.0), (2, 'default1', 1, 0.0), (1, 'default2', NULL, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, num_of_component FROM (SELECT * FROM (SELECT * FROM (SELECT furniture_id, name, num_of_component, market_rate, MIN(market_rate) OVER () AS minmarket_rate FROM furniture) ORDER BY market_rate) LIMIT 1);

/*
Gold Result:
('default2', None)
*/

-- Prediction Query
SELECT name, Num_of_Component FROM furniture ORDER BY market_rate, furniture.furniture_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2', None)
*/