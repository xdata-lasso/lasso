-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (1, 1995.0, 'Alpha Corp', 3, 10);
INSERT INTO manufacturer (Manufacturer_ID, Open_Year, Name, Num_of_Factories, Num_of_Shops) VALUES (2, 2005.0, 'Omega Furnishings', 5, 20);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (1, 'Bookcase', 25, 500.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (2, 'Wardrobe', 12, 150.5);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (3, 'Armchair', 4, 50.0);
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (4, 'Desk', 8, 220.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (1, 1, 450.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 3, 60.0);
INSERT INTO furniture_manufacte (Manufacturer_ID, Furniture_ID, Price_in_Dollar) VALUES (2, 4, 210.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, num_of_component FROM (SELECT * FROM (SELECT * FROM furniture ORDER BY name DESC, furniture.furniture_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Wardrobe', 12)
*/

-- Prediction Query
SELECT name, Num_of_Component FROM furniture ORDER BY market_rate, furniture.furniture_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Armchair', 4)
*/