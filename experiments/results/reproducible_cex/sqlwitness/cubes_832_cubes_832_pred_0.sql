-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO furniture (furniture_id, name, num_of_component, market_rate) VALUES (1, NULL, NULL, 1.0), (0, 'default1', 1, 1.0);
INSERT INTO manufacturer (manufacturer_id, open_year, name, num_of_factories, num_of_shops) VALUES (0, 0.0, 'default2', 1, 1), (1, NULL, 'default2', 0, NULL);
INSERT INTO furniture_manufacte (manufacturer_id, furniture_id, price_in_dollar) VALUES (1, 1, NULL), (0, 1, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price_in_dollar FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.furniture_id AS furniture_id, LHS.price_in_dollar AS price_in_dollar, RHS.name AS name, RHS.num_of_component AS num_of_component, RHS.market_rate AS market_rate FROM furniture_manufacte AS LHS LEFT JOIN furniture AS RHS ON (LHS.furniture_id = RHS.furniture_id)) ORDER BY name, price_in_dollar NULLS LAST;

/*
Gold Result:
(None, 0.0)
(None, None)
*/

-- Prediction Query
SELECT t1.name, t2.price_in_dollar FROM furniture AS t1 JOIN furniture_manufacte AS t2 ON t1.Furniture_ID = t2.Furniture_ID;

/*
Prediction Result:
(None, None)
(None, 0.0)
*/