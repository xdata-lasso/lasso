-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 1995.0, 'Alpha Mfg', 10, 100);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 2001.0, 'Beta Mfg', 20, 200);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (3, 2010.0, 'Gamma Mfg', 30, 300);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (10, 'Chair', 4, 1.5);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (100, 'Table', 5, 2.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (201, 'Desk', 6, 3.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 100, 150.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 10, 50.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 201, 250.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manufacturer_id, num_of_shops FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.open_year AS open_year, LHS.name AS name, LHS.num_of_factories AS num_of_factories, LHS.num_of_shops AS num_of_shops, RHS.price_in_dollar AS price_in_dollar FROM manufacturer AS LHS INNER JOIN furniture_manufacte AS RHS ON (LHS.manufacturer_id = RHS.manufacturer_id AND LHS.num_of_shops = RHS.furniture_id)) ORDER BY manufacturer_id, num_of_shops NULLS LAST;

/*
Gold Result:
(1, 100)
*/

-- Prediction Query
SELECT t1.manufacturer_id, t1.num_of_shops FROM manufacturer AS t1 JOIN furniture_manufacte AS t2 ON t1.manufacturer_id = t2.manufacturer_id ORDER BY t2.Price_in_Dollar DESC, t1.manufacturer_id NULLS LAST, t2.manufacturer_id NULLS LAST, t2.furniture_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2, 200)
*/