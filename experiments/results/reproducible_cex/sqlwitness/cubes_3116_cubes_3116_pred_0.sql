-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO market (market_id, country, number_cities) VALUES (1, 'Japan', 0), (0, NULL, NULL), (2, 'Japan', 1), (3, 'default2', 0), (4, 'default2', 1), (5, 'default1', NULL);
INSERT INTO film (film_id, title, studio, director, gross_in_dollar) VALUES (0, 'default1', NULL, NULL, NULL);
INSERT INTO film_market_estimation (estimation_id, market_id, film_id, low_estimate, high_estimate, type, year) VALUES (0, NULL, NULL, NULL, 0.0, NULL, 1), (1, 2, NULL, NULL, 0.0, 'default2', 0), (2, 2, NULL, 0.0, NULL, 'default1', NULL), (3, 3, NULL, 1.0, 1.0, 'Japan', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "year" FROM (SELECT "LHS"."market_id" AS "market_id", "LHS"."country" AS "country", "LHS"."number_cities" AS "number_cities", "RHS"."estimation_id" AS "estimation_id", "RHS"."low_estimate" AS "low_estimate", "RHS"."high_estimate" AS "high_estimate", "RHS"."film_id" AS "film_id", "RHS"."type" AS "type", "RHS"."year" AS "year" FROM "market" AS "LHS" INNER JOIN "film_market_estimation" AS "RHS" ON ("LHS"."market_id" = "RHS"."market_id")) WHERE ("country" = 'Japan') ORDER BY YEAR, "year" NULLS LAST;

/*
Gold Result:
(None,)
(0,)
*/

-- Prediction Query
SELECT T1.Year FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID = T2.Market_ID WHERE T2.Country = 'Japan' ORDER BY T1.Year DESC, T1.estimation_id NULLS LAST, T2.market_id NULLS LAST;

/*
Prediction Result:
(0,)
(None,)
*/