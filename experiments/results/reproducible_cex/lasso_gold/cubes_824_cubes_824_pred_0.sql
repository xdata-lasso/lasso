-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (1009, 'Angie Henderson', 1010, 1011.5);
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (1017, 'Cristian Santos', 1018, 1019.5);
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (1012, 1013.5, 'Daniel Wagner', 1014, 1015);
INSERT INTO "manufacturer" ("manufacturer_id", "open_year", "name", "num_of_factories", "num_of_shops") VALUES (1020, NULL, 'Connie Lawrence', 1022, 1023);
INSERT INTO "furniture_manufacte" ("manufacturer_id", "furniture_id", "price_in_dollar") VALUES (1012, 1009, 1016.5);
INSERT INTO "furniture_manufacte" ("manufacturer_id", "furniture_id", "price_in_dollar") VALUES (1020, 1017, 1024.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.n AS n, RHS.open_year AS open_year, RHS.name AS name, RHS.num_of_factories AS num_of_factories, RHS.num_of_shops AS num_of_shops FROM (SELECT manufacturer_id, COUNT(*) AS n FROM furniture_manufacte GROUP BY manufacturer_id) AS LHS INNER JOIN manufacturer AS RHS ON (LHS.manufacturer_id = RHS.manufacturer_id)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Connie Lawrence')
(1, 'Daniel Wagner')
*/

-- Prediction Query
SELECT COUNT(*), t1.name FROM manufacturer AS t1 JOIN furniture_manufacte AS t2 ON t1.manufacturer_id = t2.manufacturer_id GROUP BY t1.manufacturer_id;

/*
Prediction Result:
(1, 'Daniel Wagner')
(1, 'Connie Lawrence')
*/