-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'A', 'S', 'D', 100);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (1, 'Z', 10);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (2, 'A', 20);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (1, 1, 1, 10.0, 20.0, 'T', 2000);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (2, 2, 1, 10.0, 20.0, 'T', 1990);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country, YEAR FROM (SELECT LHS.market_id AS market_id, LHS.country AS country, LHS.number_cities AS number_cities, RHS.estimation_id AS estimation_id, RHS.low_estimate AS low_estimate, RHS.high_estimate AS high_estimate, RHS.film_id AS film_id, RHS.type AS TYPE, RHS.year AS YEAR FROM market AS LHS INNER JOIN film_market_estimation AS RHS ON (LHS.market_id = RHS.market_id)) ORDER BY country, YEAR NULLS LAST;

/*
Gold Result:
('A', 1990)
('Z', 2000)
*/

-- Prediction Query
SELECT T2.Country, T1.Year FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID = T2.Market_ID;

/*
Prediction Result:
('Z', 2000)
('A', 1990)
*/