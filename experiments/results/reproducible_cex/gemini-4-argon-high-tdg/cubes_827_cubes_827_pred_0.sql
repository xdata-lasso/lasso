-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 2020.0, 'Zeta Corp', 50, 30);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 1990.0, 'Alpha Inc', 40, 10);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (3, 2005.0, 'Beta LLC', 10, 20);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (4, 2010.0, 'Gamma Co', 25, 15);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (10, 'Chair', 4, 50.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (15, 'Stool', 3, 30.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (20, 'Table', 8, 120.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (25, 'Desk', 6, 95.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (30, 'Sofa', 12, 300.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 30, 900.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 10, 850.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 10, 100.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (3, 20, 500.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (4, 25, 250.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manufacturer_id, num_of_shops FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.open_year AS open_year, LHS.name AS name, LHS.num_of_factories AS num_of_factories, LHS.num_of_shops AS num_of_shops, RHS.price_in_dollar AS price_in_dollar FROM manufacturer AS LHS INNER JOIN furniture_manufacte AS RHS ON (LHS.manufacturer_id = RHS.manufacturer_id AND LHS.num_of_shops = RHS.furniture_id)) ORDER BY manufacturer_id, num_of_shops NULLS LAST;

/*
Gold Result:
(1, 30)
(2, 10)
(3, 20)
*/

-- Prediction Query
SELECT t1.manufacturer_id, t1.num_of_shops FROM manufacturer AS t1 JOIN furniture_manufacte AS t2 ON t1.manufacturer_id = t2.manufacturer_id ORDER BY t2.Price_in_Dollar DESC, t1.manufacturer_id NULLS LAST, t2.manufacturer_id NULLS LAST, t2.furniture_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 30)
*/