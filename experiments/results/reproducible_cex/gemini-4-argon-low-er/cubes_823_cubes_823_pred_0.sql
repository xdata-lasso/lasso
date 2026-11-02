-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 2000.0, 'B', 1, 1);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 2010.0, 'A', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, manufacturer_id FROM manufacturer ORDER BY name, manufacturer.manufacturer_id NULLS LAST;

/*
Gold Result:
('A', 2)
('B', 1)
*/

-- Prediction Query
SELECT name, manufacturer_id FROM manufacturer ORDER BY open_year, manufacturer.manufacturer_id NULLS LAST;

/*
Prediction Result:
('B', 1)
('A', 2)
*/