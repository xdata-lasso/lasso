-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Inception', 'Warner Bros', 'Christopher Nolan', 800000000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (1, 'USA', 10);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (2, 'Canada', 30);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (3, 'Brazil', 20);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (4, 'Canada', 5);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1, 1, 1, 1000.0, 2000.0, 'Initial', 2010);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (2, 1, 1, 1500.0, 2500.0, 'Revised', 2011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM market ORDER BY country, market.market_id NULLS LAST;

/*
Gold Result:
('Brazil',)
('Canada',)
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT Country FROM market ORDER BY Number_cities DESC, market.market_id NULLS LAST;

/*
Prediction Result:
('Canada',)
('Brazil',)
('USA',)
('Canada',)
*/