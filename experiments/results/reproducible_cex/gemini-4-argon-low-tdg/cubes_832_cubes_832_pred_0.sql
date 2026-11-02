-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Unreferenced furniture rows (kills RIGHT JOIN, FULL JOIN, or reversed LEFT JOIN).
-- 2. Duplicate (name, price_in_dollar) pairs across different manufacturers (kills SELECT DISTINCT).
-- 3. NULLs in furniture.Name and furniture_manufacte.Price_in_Dollar (tests NULLS FIRST vs NULLS LAST in ORDER BY).
-- 4. Multi-column sorting (ORDER BY name ASC, price_in_dollar ASC) vs single-column or DESC sorting.
-- 5. Confounding values in Manufacturer.Name and Furniture.Market_Rate (kills wrong column/table selection).
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 1990.0, ' Mfg_Z', 5, 10);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 2000.0, 'Mfg_A', 3, 8);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (3, 2010.0, 'Mfg_M', 1, 2);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (10, 'Chair', 4, 999.99);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (20, 'Table', 6, 50.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (30, NULL, 2, 10.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (40, 'Unmanufactured_Sofa', 10, 500.0);
-- Duplicate output rows ('Chair', 150.0) from different manufacturers
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 10, 150.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 10, 150.0);
-- Different price and NULL price for 'Chair' to test secondary sort and NULLS LAST
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (3, 10, 80.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (3, 20, NULL);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 20, 300.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 20, 200.0);
-- Furniture with NULL Name to test primary sort NULL ordering
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 30, 50.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 30, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price_in_dollar FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.furniture_id AS furniture_id, LHS.price_in_dollar AS price_in_dollar, RHS.name AS name, RHS.num_of_component AS num_of_component, RHS.market_rate AS market_rate FROM furniture_manufacte AS LHS LEFT JOIN furniture AS RHS ON (LHS.furniture_id = RHS.furniture_id)) ORDER BY name, price_in_dollar NULLS LAST;

/*
Gold Result:
(None, 50.0)
(None, None)
('Chair', 80.0)
('Chair', 150.0)
('Chair', 150.0)
('Table', 200.0)
('Table', 300.0)
('Table', None)
*/

-- Prediction Query
SELECT t1.name, t2.price_in_dollar FROM furniture AS t1 JOIN furniture_manufacte AS t2 ON t1.Furniture_ID = t2.Furniture_ID;

/*
Prediction Result:
('Chair', 150.0)
('Chair', 150.0)
('Chair', 80.0)
('Table', None)
('Table', 300.0)
('Table', 200.0)
(None, 50.0)
(None, None)
*/