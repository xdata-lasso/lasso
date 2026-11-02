-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (8, 14, '15', 10, 10);
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (7, 14, '15', 9, 10);
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (12, '15', 15, 15);
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (11, '15', 15, 15);
INSERT INTO "furniture_manufacte" ("manufacturer_id", "furniture_id", "price_in_dollar") VALUES (8, 12, 15);
INSERT INTO "furniture_manufacte" ("manufacturer_id", "furniture_id", "price_in_dollar") VALUES (7, 11, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_year FROM manufacturer WHERE (num_of_shops >= 10 OR num_of_shops > num_of_factories) ORDER BY name, manufacturer.manufacturer_id NULLS LAST;

/*
Gold Result:
('15', 14.0)
('15', 14.0)
*/

-- Prediction Query
SELECT name, open_year FROM manufacturer WHERE num_of_shops > 10 OR Num_of_Factories < 10;

/*
Prediction Result:
('15', 14.0)
*/