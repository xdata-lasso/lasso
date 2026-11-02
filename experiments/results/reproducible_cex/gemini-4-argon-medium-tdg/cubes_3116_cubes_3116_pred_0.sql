-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'Film A', 'Studio A', 'Director A', 100000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (2, 'Film B', 'Studio B', 'Director B', 200000);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (1, 'Japan', 10);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (2, 'USA', 50);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (3, 'Japan', 5);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (4, 'japan', 8);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (1, 1, 1, 100.0, 200.0, 'Type1', 2020);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (2, 1, 2, 150.0, 250.0, 'Type1', 2018);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (3, 1, 1, 120.0, 220.0, 'Type2', 2020);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (4, 2, 1, 300.0, 400.0, 'Type1', 2019);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (5, 4, 1, 50.0, 100.0, 'Type1', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "year" FROM (SELECT "LHS"."market_id" AS "market_id", "LHS"."country" AS "country", "LHS"."number_cities" AS "number_cities", "RHS"."estimation_id" AS "estimation_id", "RHS"."low_estimate" AS "low_estimate", "RHS"."high_estimate" AS "high_estimate", "RHS"."film_id" AS "film_id", "RHS"."type" AS "type", "RHS"."year" AS "year" FROM "market" AS "LHS" INNER JOIN "film_market_estimation" AS "RHS" ON ("LHS"."market_id" = "RHS"."market_id")) WHERE ("country" = 'Japan') ORDER BY YEAR, "year" NULLS LAST;

/*
Gold Result:
(2018,)
(2020,)
(2020,)
*/

-- Prediction Query
SELECT T1.Year FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID = T2.Market_ID WHERE T2.Country = 'Japan' ORDER BY T1.Year DESC, T1.estimation_id NULLS LAST, T2.market_id NULLS LAST;

/*
Prediction Result:
(2020,)
(2020,)
(2018,)
*/