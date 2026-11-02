-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Director (contrasting with Film_ID, Title, Studio, and Gross_in_dollar orders), duplicate directors (kills DISTINCT), and orphan/multi-join scenarios with film_market_estimation.
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'Zebra', 'Studio C', 'Cameron', 300000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (2, 'Alpha', 'Studio A', 'Adams', 500000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (3, 'Beta', 'Studio B', 'Adams', 100000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (4, 'Gamma', 'Studio D', 'Baker', 200000);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (10, 'USA', 50);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (20, 'UK', 20);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (100, 10, 1, 1000.0, 2000.0, 'Initial', 2020);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (101, 20, 1, 1500.0, 2500.0, 'Revised', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM film ORDER BY director, film.film_id NULLS LAST;

/*
Gold Result:
('Adams',)
('Adams',)
('Baker',)
('Cameron',)
*/

-- Prediction Query
SELECT DISTINCT Director FROM film;

/*
Prediction Result:
('Cameron',)
('Adams',)
('Baker',)
*/