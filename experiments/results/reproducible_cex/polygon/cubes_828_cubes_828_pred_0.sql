-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (9, 12, '13', 20, 20);
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (8, 14, '15', 18, 21);
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (11, '20', 20, 20);
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (10, '20', 20, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(num_of_factories) OVER () AS avg_num_of_factories_ FROM manufacturer WHERE (num_of_factories = 20 OR num_of_shops > 20) ORDER BY avg_num_of_factories_;

/*
Gold Result:
(19.0,)
*/

-- Prediction Query
SELECT AVG(Num_of_Factories) FROM manufacturer WHERE num_of_shops > 20;

/*
Prediction Result:
(18.0,)
*/