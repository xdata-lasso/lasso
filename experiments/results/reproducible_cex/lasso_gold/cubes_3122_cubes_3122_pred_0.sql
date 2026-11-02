-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1068, 'Local government officer', 'PM', 'everything', 1069);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1076, 'Local government officer', 'PM', 'everything', 1069);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1070, 'Sri Lanka', 1071);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1072, 1070, 1068, 1073.5, 1074.5, 'animal', 1995);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1075, 1070, 1076, 1073.5, 1074.5, 'animal', 1995);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM (SELECT LHS.estimation_id AS estimation_id, LHS.low_estimate AS low_estimate, LHS.high_estimate AS high_estimate, LHS.film_id AS film_id, LHS.type AS TYPE, LHS.market_id AS market_id, LHS.year AS YEAR, RHS.title AS title, RHS.studio AS studio, RHS.director AS director, RHS.gross_in_dollar AS gross_in_dollar FROM film_market_estimation AS LHS INNER JOIN film AS RHS ON (LHS.film_id = RHS.film_id)) WHERE (YEAR = 1995) ORDER BY director;

/*
Gold Result:
('everything',)
('everything',)
*/

-- Prediction Query
SELECT DISTINCT T1.Director FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID = T2.Film_ID WHERE T2.Year = 1995;

/*
Prediction Result:
('everything',)
*/