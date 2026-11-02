-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Solo Film', 'Indie', 'Jane Doe', 10000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(number_cities) OVER () AS max_number_cities_, minnumber_cities AS min_number_cities_ FROM (SELECT market_id, country, number_cities, MIN(number_cities) OVER () AS minnumber_cities FROM market) ORDER BY max_number_cities_, min_number_cities_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(Number_cities), MIN(Number_cities) FROM market;

/*
Prediction Result:
(None, None)
*/