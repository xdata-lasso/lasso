-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (24, '20', '21', '37', 22);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (33, '28', '29', '37', 30);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (15, '37', 37);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (32, '37', 37);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (23, 32, 24, 25, 26, '27', 1995);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (31, 32, 33, 34, 35, '36', 1995);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM (SELECT LHS.estimation_id AS estimation_id, LHS.low_estimate AS low_estimate, LHS.high_estimate AS high_estimate, LHS.film_id AS film_id, LHS.type AS TYPE, LHS.market_id AS market_id, LHS.year AS YEAR, RHS.title AS title, RHS.studio AS studio, RHS.director AS director, RHS.gross_in_dollar AS gross_in_dollar FROM film_market_estimation AS LHS INNER JOIN film AS RHS ON (LHS.film_id = RHS.film_id)) WHERE (YEAR = 1995) ORDER BY director;

/*
Gold Result:
('37',)
('37',)
*/

-- Prediction Query
SELECT DISTINCT T1.Director FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID = T2.Film_ID WHERE T2.Year = 1995;

/*
Prediction Result:
('37',)
*/