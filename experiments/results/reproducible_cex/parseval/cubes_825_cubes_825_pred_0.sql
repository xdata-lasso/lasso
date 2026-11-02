-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: furniture --
INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (1, 'fur_e8f2ca', 1, 1.0);

INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (-2147483647, 'fur_41cf64', 1, 1.0);

INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (-2147483646, 'q_1_5bc1b5', 1, 582.588439);

INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (-2147483645, 'q_1_5bc1b5', 1, 680.190136);

INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (-1, '5', -55602865, 486.033807);

INSERT INTO "furniture" ("furniture_id", "name", "num_of_component", "market_rate") VALUES (0, '4', -664303813, 833.684115);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, num_of_component FROM (SELECT * FROM (SELECT * FROM furniture ORDER BY name DESC, furniture.furniture_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('q_1_5bc1b5', 1)
*/

-- Prediction Query
SELECT name, Num_of_Component FROM furniture ORDER BY market_rate, furniture.furniture_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('fur_41cf64', 1)
*/