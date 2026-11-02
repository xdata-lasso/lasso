-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Alpha', 'Studio A', 'Dir A', 500000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'Beta', 'Studio B', 'Dir B', 600000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (3, 'Gamma', 'Studio C', 'Dir C', 700000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (10, 'Delta', 'Studio D', 'Dir D', 800000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (10, 'Japan', 50);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (20, 'Japan', 15);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (30, 'USA', 100);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (40, 'China', 80);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (101, 10, 2, 500.0, 800.0, 'Box Office', 2005);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (102, 10, 3, 900.0, 1200.0, 'DVD', 1998);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (103, 20, 1, 100.0, 300.0, 'Streaming', 2012);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (104, 20, 2, 250.0, 400.0, 'Box Office', 1998);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (10, 30, 10, 700.0, 1000.0, 'Japan', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (105, 40, 1, 400.0, 600.0, 'Box Office', 2001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "year" FROM (SELECT "LHS"."market_id" AS "market_id", "LHS"."country" AS "country", "LHS"."number_cities" AS "number_cities", "RHS"."estimation_id" AS "estimation_id", "RHS"."low_estimate" AS "low_estimate", "RHS"."high_estimate" AS "high_estimate", "RHS"."film_id" AS "film_id", "RHS"."type" AS "type", "RHS"."year" AS "year" FROM "market" AS "LHS" INNER JOIN "film_market_estimation" AS "RHS" ON ("LHS"."market_id" = "RHS"."market_id")) WHERE ("country" = 'Japan') ORDER BY YEAR, "year" NULLS LAST;

/*
Gold Result:
(1998,)
(1998,)
(2005,)
(2012,)
*/

-- Prediction Query
SELECT T1.Year FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID = T2.Market_ID WHERE T2.Country = 'Japan' ORDER BY T1.Year DESC, T1.estimation_id NULLS LAST, T2.market_id NULLS LAST;

/*
Prediction Result:
(2012,)
(2005,)
(1998,)
(1998,)
*/