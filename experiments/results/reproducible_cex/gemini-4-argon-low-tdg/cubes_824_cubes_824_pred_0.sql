-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests secondary ORDER BY (name ASC NULLS LAST) when counts are tied, and DISTINCT vs ALL when duplicate names have identical counts
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (1, 1985.0, 'Bravo', 4, 8);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (2, 1995.0, 'Alpha', 2, 3);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (3, 2005.0, NULL, 1, 2);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (4, 2015.0, 'Alpha', 5, 12);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (100, 'Sofa', 10, 300.0);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (200, 'Bed', 12, 400.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (1, 100, 500.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (1, 200, 600.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (2, 100, 550.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (2, 200, 650.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (3, 100, 450.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (3, 200, 550.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (4, 100, 520.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (4, 200, 620.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.n AS n, RHS.open_year AS open_year, RHS.name AS name, RHS.num_of_factories AS num_of_factories, RHS.num_of_shops AS num_of_shops FROM (SELECT manufacturer_id, COUNT(*) AS n FROM furniture_manufacte GROUP BY manufacturer_id) AS LHS INNER JOIN manufacturer AS RHS ON (LHS.manufacturer_id = RHS.manufacturer_id)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(2, 'Alpha')
(2, 'Alpha')
(2, 'Bravo')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), t1.name FROM manufacturer AS t1 JOIN furniture_manufacte AS t2 ON t1.manufacturer_id = t2.manufacturer_id GROUP BY t1.manufacturer_id;

/*
Prediction Result:
(2, 'Bravo')
(2, 'Alpha')
(2, None)
(2, 'Alpha')
*/