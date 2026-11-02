-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out of natural PK order), secondary sort on estimation_id, and conflict between high_estimate and estimation_id.
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'Film A', 'Studio A', 'Director A', 100000);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (1, 'USA', 50);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (10, 1, 1, 50.5, 100.0, 'Type A', 2020);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (5, 1, 1, 20.0, 200.0, 'Type B', 2021);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (20, 1, 1, 20.0, 80.0, 'Type C', 2019);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (15, 1, 1, 10.0, 50.0, 'Type A', 2022);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT low_estimate, high_estimate FROM film_market_estimation ORDER BY low_estimate, film_market_estimation.estimation_id NULLS LAST;

/*
Gold Result:
(10.0, 50.0)
(20.0, 200.0)
(20.0, 80.0)
(50.5, 100.0)
*/

-- Prediction Query
SELECT Low_Estimate, High_Estimate FROM film_market_estimation;

/*
Prediction Result:
(20.0, 200.0)
(50.5, 100.0)
(10.0, 50.0)
(20.0, 80.0)
*/