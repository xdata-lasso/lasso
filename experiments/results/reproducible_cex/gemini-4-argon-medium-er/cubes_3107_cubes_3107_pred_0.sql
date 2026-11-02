-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'A', 'B', 'C', 100);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (1, 'USA', 10);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (1, 1, 1, 200.0, 300.0, 'T', 2020);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (2, 1, 1, 100.0, 150.0, 'T', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT low_estimate, high_estimate FROM film_market_estimation ORDER BY low_estimate, film_market_estimation.estimation_id NULLS LAST;

/*
Gold Result:
(100.0, 150.0)
(200.0, 300.0)
*/

-- Prediction Query
SELECT Low_Estimate, High_Estimate FROM film_market_estimation;

/*
Prediction Result:
(200.0, 300.0)
(100.0, 150.0)
*/