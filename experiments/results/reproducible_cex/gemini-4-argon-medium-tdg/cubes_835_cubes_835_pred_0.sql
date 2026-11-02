-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (1, 1990.0, 'Alpha', 15, 10);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (2, 1991.0, 'Beta', 15, 9);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (3, 1992.0, 'Gamma', 15, 11);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (4, 1993.0, 'Delta', 5, 5);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (5, 1994.0, 'Epsilon', 5, 6);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (6, 1995.0, 'Zeta', 5, 4);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (7, 1996.0, 'Eta', 5, 10);
INSERT INTO "manufacturer" ("Manufacturer_ID", "Open_Year", "Name", "Num_of_Factories", "Num_of_Shops") VALUES (8, 1997.0, 'Theta', 8, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, open_year FROM manufacturer WHERE (num_of_shops >= 10 OR num_of_shops > num_of_factories) ORDER BY name, manufacturer.manufacturer_id NULLS LAST;

/*
Gold Result:
('Alpha', 1990.0)
('Epsilon', 1994.0)
('Eta', 1996.0)
('Gamma', 1992.0)
('Theta', 1997.0)
*/

-- Prediction Query
SELECT name, open_year FROM manufacturer WHERE num_of_shops > 10 OR Num_of_Factories < 10;

/*
Prediction Result:
('Gamma', 1992.0)
('Delta', 1993.0)
('Epsilon', 1994.0)
('Zeta', 1995.0)
('Eta', 1996.0)
('Theta', 1997.0)
*/