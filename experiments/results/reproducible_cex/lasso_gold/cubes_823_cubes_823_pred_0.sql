-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (1009, 1010.5, 'Cristian Santos', 1011, 1012);
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (1013, 1011.5, 'Angie Henderson', 1012, 1013);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, manufacturer_id FROM manufacturer ORDER BY name, manufacturer.manufacturer_id NULLS LAST;

/*
Gold Result:
('Angie Henderson', 1013)
('Cristian Santos', 1009)
*/

-- Prediction Query
SELECT name, manufacturer_id FROM manufacturer ORDER BY open_year, manufacturer.manufacturer_id NULLS LAST;

/*
Prediction Result:
('Cristian Santos', 1009)
('Angie Henderson', 1013)
*/