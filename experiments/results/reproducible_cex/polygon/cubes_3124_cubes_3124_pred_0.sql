-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (8, '-145', '-145', '-145', -145);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (7, '-145', '-145', '-145', -145);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (10, '13', -145);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (9, '-145', 797);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (12, 10, 7, -145, -145, '-145', -145);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (11, 10, 8, -145, -145, '-145', -145);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(number_cities) OVER () AS max_number_cities_, minnumber_cities AS min_number_cities_ FROM (SELECT market_id, country, number_cities, MIN(number_cities) OVER () AS minnumber_cities FROM market) ORDER BY max_number_cities_, min_number_cities_ NULLS LAST;

/*
Gold Result:
(797, -145)
*/

-- Prediction Query
SELECT MAX(Number_cities), MIN(Number_cities) FROM market;

/*
Prediction Result:
(797, -145)
*/