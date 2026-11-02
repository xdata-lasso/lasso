-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1036, 'Air traffic controller', 'better', 'discover', 1037);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1043, 'Town planner', 'agreement', 'option', 1044);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1038, 'Djibouti', 1039);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1045, 'Congo', NULL);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1040, 1038, 1036, 10001.0, 1041.5, 'mouth', 1042);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1047, 1045, 1043, 10001.0, 1048.5, 'sense', 1049);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meannumber_cities AS avg_t2_number_cities_ FROM (SELECT film_id, low_estimate, AVG(number_cities) AS meannumber_cities FROM (SELECT LHS.market_id AS market_id, LHS.country AS country, LHS.number_cities AS number_cities, RHS.estimation_id AS estimation_id, RHS.low_estimate AS low_estimate, RHS.high_estimate AS high_estimate, RHS.film_id AS film_id, RHS.type AS TYPE, RHS.year AS YEAR FROM market AS LHS INNER JOIN (SELECT * FROM film_market_estimation WHERE (low_estimate > 10000.0)) AS RHS ON (LHS.market_id = RHS.market_id)) GROUP BY film_id, low_estimate) ORDER BY avg_t2_number_cities_;

/*
Gold Result:
(None,)
(1039.0,)
*/

-- Prediction Query
SELECT AVG(T2.Number_cities) FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID = T2.Market_ID WHERE T1.Low_Estimate > 10000;

/*
Prediction Result:
(1039.0,)
*/