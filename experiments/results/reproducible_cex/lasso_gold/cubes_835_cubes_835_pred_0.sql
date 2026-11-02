-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (1030, 1031.5, 'Michele Williams', 10, 11);
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (1034, 1035.5, 'Brian Ramirez', NULL, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_year FROM manufacturer WHERE (num_of_shops >= 10 OR num_of_shops > num_of_factories) ORDER BY name, manufacturer.manufacturer_id NULLS LAST;

/*
Gold Result:
('Brian Ramirez', 1035.5)
('Michele Williams', 1031.5)
*/

-- Prediction Query
SELECT name, open_year FROM manufacturer WHERE num_of_shops > 10 OR Num_of_Factories < 10;

/*
Prediction Result:
('Michele Williams', 1031.5)
*/