-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (3, 1995.0, 'Gamma Corp', 4, 20);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 2005.0, 'Beta Works', 2, 10);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 1980.0, 'Alpha Inc', 5, 20);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (4, 2010.0, 'Delta Ltd', 1, 30);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (10, 'Chair', 4, 50.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (20, 'Table', 6, 120.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (30, 'Desk', 8, 200.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (3, 20, 150.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 10, 75.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 20, 140.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 10, 60.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 20, 130.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manufacturer_id, furniture_id AS num_of_shops FROM (SELECT furniture_id, manufacturer_id, MAX(price_in_dollar) AS price_in_dollar FROM (SELECT manufacturer_id, furniture_id, price_in_dollar, open_year, name, num_of_factories, furniture_id AS num_of_shops FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.furniture_id AS furniture_id, LHS.price_in_dollar AS price_in_dollar, RHS.open_year AS open_year, RHS.name AS name, RHS.num_of_factories AS num_of_factories FROM furniture_manufacte AS LHS INNER JOIN manufacturer AS RHS ON (LHS.manufacturer_id = RHS.manufacturer_id AND LHS.furniture_id = RHS.num_of_shops))) GROUP BY furniture_id, manufacturer_id) ORDER BY manufacturer_id, num_of_shops NULLS LAST;

/*
Gold Result:
(1, 20)
(2, 10)
(3, 20)
*/

-- Prediction Query
SELECT t1.manufacturer_id, t1.num_of_shops FROM manufacturer AS t1 JOIN furniture_manufacte AS t2 ON t1.manufacturer_id = t2.manufacturer_id ORDER BY t2.Price_in_Dollar DESC, t1.manufacturer_id NULLS LAST, t2.manufacturer_id NULLS LAST, t2.furniture_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(3, 20)
*/