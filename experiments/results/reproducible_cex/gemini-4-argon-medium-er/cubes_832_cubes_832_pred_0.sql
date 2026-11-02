-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (1, 2000.0, 'M1', 1, 1);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (2, 2000.0, 'M2', 1, 1);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (1, 'B_Chair', 4, 10.0);
INSERT INTO "furniture" ("Furniture_ID", "Name", "Num_of_Component", "Market_Rate") VALUES (2, 'A_Table', 4, 20.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (1, 1, 50.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (1, 2, 100.0);
INSERT INTO "furniture_manufacte" ("Manufacturer_ID", "Furniture_ID", "Price_in_Dollar") VALUES (2, NULL, 75.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, price_in_dollar FROM (SELECT LHS.manufacturer_id AS manufacturer_id, LHS.furniture_id AS furniture_id, LHS.price_in_dollar AS price_in_dollar, RHS.name AS name, RHS.num_of_component AS num_of_component, RHS.market_rate AS market_rate FROM furniture_manufacte AS LHS LEFT JOIN furniture AS RHS ON (LHS.furniture_id = RHS.furniture_id)) ORDER BY name, price_in_dollar NULLS LAST;

/*
Gold Result:
(None, 75.0)
('A_Table', 100.0)
('B_Chair', 50.0)
*/

-- Prediction Query
SELECT t1.name, t2.price_in_dollar FROM furniture AS t1 JOIN furniture_manufacte AS t2 ON t1.Furniture_ID = t2.Furniture_ID;

/*
Prediction Result:
('B_Chair', 50.0)
('A_Table', 100.0)
*/