-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO market (market_id, country, number_cities) VALUES (1, 'default2', 0), (0, 'default1', 0);
INSERT INTO film (film_id, title, studio, director, gross_in_dollar) VALUES (1, 'default1', NULL, 'default1', 1), (0, NULL, NULL, 'default1', NULL), (2, NULL, 'default2', 'default2', 0);
INSERT INTO film_market_estimation (estimation_id, market_id, film_id, low_estimate, high_estimate, type, year) VALUES (0, 1, 1, 0.0, NULL, 'default2', 1), (1, NULL, 1, 1.0, NULL, 'default2', NULL), (2, 0, NULL, 0.0, 0.0, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT low_estimate, high_estimate FROM film_market_estimation ORDER BY low_estimate, film_market_estimation.estimation_id NULLS LAST;

/*
Gold Result:
(0.0, None)
(0.0, 0.0)
(1.0, None)
*/

-- Prediction Query
SELECT Low_Estimate, High_Estimate FROM film_market_estimation;

/*
Prediction Result:
(0.0, None)
(1.0, None)
(0.0, 0.0)
*/