-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 2010.0, 'Beta', 2, 50);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 1990.0, 'Gamma', 8, 50);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (3, 1990.0, 'Alpha', 5, 50);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (4, 1980.0, 'Delta', 10, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT open_year_other AS open_year, name_other AS name FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.open_year AS open_year, LHS.name AS name, LHS.num_of_factories AS num_of_factories, LHS.num_of_shops AS num_of_shops, LHS.maxnum_of_shops AS maxnum_of_shops, RHS.manufacturer_id AS manufacturer_id_other, RHS.open_year AS open_year_other, RHS.name AS name_other, RHS.num_of_factories AS num_of_factories_other, RHS.num_of_shops AS num_of_shops_other, RHS.maxnum_of_shops AS maxnum_of_shops_other FROM (SELECT manufacturer_id, open_year, name, num_of_factories, num_of_shops, MAX(num_of_shops) OVER () AS maxnum_of_shops FROM manufacturer) AS LHS CROSS JOIN (SELECT manufacturer_id, open_year, name, num_of_factories, num_of_shops, MAX(num_of_shops) OVER () AS maxnum_of_shops FROM manufacturer) AS RHS) WHERE (maxnum_of_shops <= num_of_shops_other AND maxnum_of_shops <= maxnum_of_shops_other) ORDER BY open_year, name NULLS LAST;

/*
Gold Result:
(1990.0, 'Alpha')
(1990.0, 'Gamma')
(2010.0, 'Beta')
*/

-- Prediction Query
SELECT open_year, name FROM manufacturer ORDER BY num_of_shops DESC, manufacturer.manufacturer_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2010.0, 'Beta')
*/