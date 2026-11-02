-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO furniture (furniture_id, name, num_of_component, market_rate) VALUES (1, 'default2', 0, NULL), (0, 'default2', NULL, 1.0), (2, 'default1', 0, NULL), (3, 'default1', 0, 0.0), (4, NULL, NULL, NULL);
INSERT INTO manufacturer (manufacturer_id, open_year, name, num_of_factories, num_of_shops) VALUES (1, NULL, NULL, 1, 1), (0, 0.0, 'default1', 0, NULL), (2, NULL, 'default1', 0, 0), (3, 1.0, 'default1', 1, 0), (4, 0.0, 'default2', 1, 1), (5, 0.0, 'default1', NULL, 1), (6, 1.0, 'default1', NULL, NULL), (7, 1.0, NULL, NULL, NULL), (8, 1.0, 'default1', NULL, 0), (9, 0.0, NULL, 0, 1), (10, NULL, 'default2', 1, NULL), (11, NULL, NULL, 0, NULL), (12, 1.0, NULL, 1, NULL), (13, 0.0, 'default1', NULL, 0), (14, NULL, 'default1', 1, 0), (15, 1.0, 'default2', 0, 1), (16, 0.0, 'default2', 0, 0);
INSERT INTO furniture_manufacte (manufacturer_id, furniture_id, price_in_dollar) VALUES (12, 2, NULL), (4, 3, NULL), (3, 0, 1.0), (9, 0, NULL), (1, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.n AS n, RHS.open_year AS open_year, RHS.name AS name, RHS.num_of_factories AS num_of_factories, RHS.num_of_shops AS num_of_shops FROM (SELECT manufacturer_id, COUNT(*) AS n FROM furniture_manufacte GROUP BY manufacturer_id) AS LHS INNER JOIN manufacturer AS RHS ON (LHS.manufacturer_id = RHS.manufacturer_id)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'default1')
(1, 'default2')
(1, None)
(1, None)
(1, None)
*/

-- Prediction Query
SELECT COUNT(*), t1.name FROM manufacturer AS t1 JOIN furniture_manufacte AS t2 ON t1.manufacturer_id = t2.manufacturer_id GROUP BY t1.manufacturer_id;

/*
Prediction Result:
(1, None)
(1, 'default1')
(1, 'default2')
(1, None)
(1, None)
*/