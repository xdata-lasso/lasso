-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO furniture (furniture_id, name, num_of_component, market_rate) VALUES (1, 'default1', 2, NULL), (2, 'default1', 1, 1.0), (0, NULL, 1, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, furniture_id FROM (SELECT * FROM (SELECT * FROM (SELECT furniture_id, name, MAX(market_rate) AS market_rate FROM furniture GROUP BY furniture_id, name) ORDER BY furniture_id) LIMIT 1);

/*
Gold Result:
(None, 0)
*/

-- Prediction Query
SELECT name, furniture_id FROM furniture ORDER BY market_rate DESC, furniture.furniture_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1', 2)
*/