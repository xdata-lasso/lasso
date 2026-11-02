-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 1995.0, 'Alpha Corp', 3, 10);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 2005.0, 'Beta Works', 5, 20);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (1, 'Oak Table', 12, 250.5);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (2, 'Pine Chair', 6, 120.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (3, 'Glass Desk', 8, 120.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (4, 'Leather Sofa', 15, 85.75);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 4, 500.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 4, 520.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT market_rate, name FROM (SELECT * FROM furniture AS LHS WHERE NOT EXISTS(SELECT 1 FROM furniture_manufacte AS RHS WHERE (LHS.furniture_id = RHS.furniture_id))) ORDER BY market_rate, name NULLS LAST;

/*
Gold Result:
(120.0, 'Glass Desk')
(120.0, 'Pine Chair')
(250.5, 'Oak Table')
*/

-- Prediction Query
SELECT Market_Rate, name FROM furniture WHERE NOT Furniture_ID IN (SELECT Furniture_ID FROM furniture_manufacte);

/*
Prediction Result:
(250.5, 'Oak Table')
(120.0, 'Pine Chair')
(120.0, 'Glass Desk')
*/