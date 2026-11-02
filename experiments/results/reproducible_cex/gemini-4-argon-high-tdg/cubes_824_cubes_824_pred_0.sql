-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 1995.0, 'Zeta Corp', 10, 50);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 2005.0, 'Alpha Inc', 5, 20);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (3, 1980.0, 'Omega LLC', 15, 30);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (4, 2010.0, 'Ghost Co', 2, 8);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (10, 'Chair', 4, 45.5);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (20, 'Table', 6, 120.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (30, 'Desk', 8, 200.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (40, 'Sofa', 12, 500.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 10, 50.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 20, 130.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 30, 210.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 10, 48.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (3, 20, 125.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (3, 30, 195.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.n AS n, RHS.open_year AS open_year, RHS.name AS name, RHS.num_of_factories AS num_of_factories, RHS.num_of_shops AS num_of_shops FROM (SELECT manufacturer_id, COUNT(*) AS n FROM furniture_manufacte GROUP BY manufacturer_id) AS LHS INNER JOIN manufacturer AS RHS ON (LHS.manufacturer_id = RHS.manufacturer_id)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Alpha Inc')
(2, 'Omega LLC')
(3, 'Zeta Corp')
*/

-- Prediction Query
SELECT COUNT(*), t1.name FROM manufacturer AS t1 JOIN furniture_manufacte AS t2 ON t1.manufacturer_id = t2.manufacturer_id GROUP BY t1.manufacturer_id;

/*
Prediction Result:
(3, 'Zeta Corp')
(1, 'Alpha Inc')
(2, 'Omega LLC')
*/