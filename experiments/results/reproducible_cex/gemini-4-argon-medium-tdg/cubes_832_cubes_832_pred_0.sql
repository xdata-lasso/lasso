-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 1990.0, 'Mfg_Alpha', 2, 5);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 2000.0, 'Mfg_Beta', 3, 10);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (10, 'Chair', 4, 50.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (20, 'Table', 6, 120.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (30, NULL, 2, 30.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (40, 'Unused_Sofa', 8, 500.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 10, 100.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 10, NULL);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 20, 250.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 20, 150.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 30, 80.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price_in_dollar FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.furniture_id AS furniture_id, LHS.price_in_dollar AS price_in_dollar, RHS.name AS name, RHS.num_of_component AS num_of_component, RHS.market_rate AS market_rate FROM furniture_manufacte AS LHS LEFT JOIN furniture AS RHS ON (LHS.furniture_id = RHS.furniture_id)) ORDER BY name, price_in_dollar NULLS LAST;

/*
Gold Result:
(None, 80.0)
('Chair', 100.0)
('Chair', None)
('Table', 150.0)
('Table', 250.0)
*/

-- Prediction Query
SELECT t1.name, t2.price_in_dollar FROM furniture AS t1 JOIN furniture_manufacte AS t2 ON t1.Furniture_ID = t2.Furniture_ID;

/*
Prediction Result:
('Chair', 100.0)
('Chair', None)
('Table', 250.0)
('Table', 150.0)
(None, 80.0)
*/