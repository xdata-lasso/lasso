-- Schema DDL
CREATE TABLE "manufacturer" ("Manufacturer_ID" INTEGER PRIMARY KEY, "Open_Year" REAL, "Name" TEXT, "Num_of_Factories" INTEGER, "Num_of_Shops" INTEGER);

CREATE TABLE "furniture" ("Furniture_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Num_of_Component" INTEGER, "Market_Rate" REAL);

CREATE TABLE "furniture_manufacte" ("Manufacturer_ID" INTEGER, "Furniture_ID" INTEGER, "Price_in_Dollar" REAL, PRIMARY KEY ("Manufacturer_ID", "Furniture_ID"), FOREIGN KEY ("Furniture_ID") REFERENCES "furniture" ("Furniture_ID"), FOREIGN KEY ("Manufacturer_ID") REFERENCES "manufacturer" ("Manufacturer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO furniture (Furniture_ID, Name, Num_of_Component, Market_Rate) VALUES (1, 'Chair', 4, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT summarket_rate AS sum_market_rate_ FROM (SELECT furniture_id, name, num_of_component, market_rate, SUM(market_rate) OVER () AS summarket_rate FROM furniture) WHERE (market_rate = 2.0 OR summarket_rate >= 2.0) ORDER BY sum_market_rate_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(market_rate) FROM furniture ORDER BY market_rate DESC, furniture.furniture_id NULLS LAST LIMIT 2;

/*
Prediction Result:
(1.0,)
*/