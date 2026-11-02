-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name (primary) and Manufacturer_ID (secondary, with ties on Name),
-- anti-correlation with other columns (Open_Year, Num_of_Factories, Num_of_Shops),
-- and foreign key disparity (some manufacturers in furniture_manufacte, some not, some multiple times)
-- to kill incorrect JOINs, WHERE filters, GROUP BYs, or wrong ORDER BY columns/directions.
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (30, 1980.0, 'Alpha', 10, 5);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (10, 2005.0, 'Beta', 2, 20);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (20, 1995.0, 'Beta', 5, 15);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (5, 2020.0, 'Gamma', 1, 1);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (101, 'Chair', 4, 50.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (102, 'Table', 5, 120.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (30, 101, 45.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (30, 102, 110.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (10, 101, 55.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, manufacturer_id FROM manufacturer ORDER BY name, manufacturer.manufacturer_id NULLS LAST;

/*
Gold Result:
('Alpha', 30)
('Beta', 10)
('Beta', 20)
('Gamma', 5)
*/

-- Prediction Query
SELECT name, manufacturer_id FROM manufacturer ORDER BY open_year, manufacturer.manufacturer_id NULLS LAST;

/*
Prediction Result:
('Alpha', 30)
('Beta', 20)
('Beta', 10)
('Gamma', 5)
*/