-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 1995.0, 'Alpha Corp', 3, 10);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 2005.0, 'Beta Inc', 1, 5);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (1, 'Sofa', 15, 250.5);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (2, 'Chair', 5, 120.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (3, 'Stool', 4, 120.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (4, NULL, 8, 120.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (5, 'Desk', 12, NULL);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (6, 'Table', 10, 300.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (7, 'Bed', 20, 500.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 6, 350.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 7, 550.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 7, 520.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT market_rate, name FROM (SELECT * FROM furniture AS LHS WHERE NOT EXISTS(SELECT 1 FROM furniture_manufacte AS RHS WHERE (LHS.furniture_id = RHS.furniture_id))) ORDER BY market_rate, name NULLS LAST;

/*
Gold Result:
(None, 'Desk')
(120.0, 'Chair')
(120.0, 'Stool')
(120.0, None)
(250.5, 'Sofa')
*/

-- Prediction Query
SELECT Market_Rate, name FROM furniture WHERE NOT Furniture_ID IN (SELECT Furniture_ID FROM furniture_manufacte);

/*
Prediction Result:
(250.5, 'Sofa')
(120.0, 'Chair')
(120.0, 'Stool')
(120.0, None)
(None, 'Desk')
*/