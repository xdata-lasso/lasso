-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO furniture (furniture_id, name, num_of_component, market_rate) VALUES (0, 'default2', NULL, 2.0), (2, 'default1', 0, NULL), (1, NULL, 1, NULL);
INSERT INTO manufacturer (manufacturer_id, open_year, name, num_of_factories, num_of_shops) VALUES (0, NULL, NULL, 2, NULL), (1, 2.0, NULL, 2, NULL), (2, 1.0, 'default1', NULL, 2), (3, 0.0, 'default2', 0, 2), (4, 2.0, 'default1', 0, 2), (5, 1.0, 'default1', NULL, 0);
INSERT INTO furniture_manufacte (manufacturer_id, furniture_id, price_in_dollar) VALUES (5, 2, 1.0), (2, 0, 1.0), (0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manufacturer_id, furniture_id AS num_of_shops FROM (SELECT furniture_id, manufacturer_id, MAX(price_in_dollar) AS price_in_dollar FROM (SELECT manufacturer_id, furniture_id, price_in_dollar, open_year, name, num_of_factories, furniture_id AS num_of_shops FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.furniture_id AS furniture_id, LHS.price_in_dollar AS price_in_dollar, RHS.open_year AS open_year, RHS.name AS name, RHS.num_of_factories AS num_of_factories FROM furniture_manufacte AS LHS INNER JOIN manufacturer AS RHS ON (LHS.manufacturer_id = RHS.manufacturer_id AND LHS.furniture_id = RHS.num_of_shops))) GROUP BY furniture_id, manufacturer_id) ORDER BY manufacturer_id, num_of_shops NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT t1.manufacturer_id, t1.num_of_shops FROM manufacturer AS t1 JOIN furniture_manufacte AS t2 ON t1.manufacturer_id = t2.manufacturer_id ORDER BY t2.Price_in_Dollar DESC, t1.manufacturer_id NULLS LAST, t2.manufacturer_id NULLS LAST, t2.furniture_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2, 2)
*/