-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: furniture --
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (1, 'fur_81f485', -55602865, 486.033807);

INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (0, 'fur_81f485', -664303813, 0.0);

INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (2, NULL, -55602865, 486.033807);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, furniture_id FROM (SELECT * FROM (SELECT * FROM furniture ORDER BY furniture_id) LIMIT 1);

/*
Gold Result:
('fur_81f485', 0)
*/

-- Prediction Query
SELECT name, furniture_id FROM furniture ORDER BY market_rate DESC, furniture.furniture_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('fur_81f485', 1)
*/