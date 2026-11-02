-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Alpha', 'Studio A', 'Director X', 1000000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'Beta', 'Studio B', 'Director Y', 2000000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (1, 'USA', 50);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (2, 'UK', 20);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1, 1, 1, 300.5, 400.75, 'Type A', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (2, 1, 2, 100.25, 900.5, 'Type B', 2021);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (3, 2, 1, 100.25, 900.5, 'Type A', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (4, 2, 2, 100.25, 500.0, 'Type C', 2022);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (5, 1, 1, 200.0, 600.25, 'Type B', 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT low_estimate, high_estimate FROM film_market_estimation ORDER BY low_estimate, film_market_estimation.estimation_id NULLS LAST;

/*
Gold Result:
(100.25, 900.5)
(100.25, 900.5)
(100.25, 500.0)
(200.0, 600.25)
(300.5, 400.75)
*/

-- Prediction Query
SELECT Low_Estimate, High_Estimate FROM film_market_estimation;

/*
Prediction Result:
(300.5, 400.75)
(100.25, 900.5)
(100.25, 900.5)
(100.25, 500.0)
(200.0, 600.25)
*/