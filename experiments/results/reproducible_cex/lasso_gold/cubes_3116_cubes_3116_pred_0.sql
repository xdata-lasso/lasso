-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1078, 'Health physicist', 'clearly', 'dinner', 1079);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1094, 'Chief Strategy Officer', 'her', 'throw', 1095);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1086, NULL, NULL, NULL, NULL);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1080, 'Japan', 1081);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1096, 'Japan', 1097);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1082, 1080, 1078, 1083.5, 1084.5, 'source', 1085);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1090, 1080, 1086, 1091.5, 1092.5, 'husband', 1093);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1098, 1096, 1094, 1099.5, 1100.5, 'guy', 1101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "year" FROM (SELECT "LHS"."market_id" AS "market_id", "LHS"."country" AS "country", "LHS"."number_cities" AS "number_cities", "RHS"."estimation_id" AS "estimation_id", "RHS"."low_estimate" AS "low_estimate", "RHS"."high_estimate" AS "high_estimate", "RHS"."film_id" AS "film_id", "RHS"."type" AS "type", "RHS"."year" AS "year" FROM "market" AS "LHS" INNER JOIN "film_market_estimation" AS "RHS" ON ("LHS"."market_id" = "RHS"."market_id")) WHERE ("country" = 'Japan') ORDER BY YEAR, "year" NULLS LAST;

/*
Gold Result:
(1085,)
(1093,)
(1101,)
*/

-- Prediction Query
SELECT T1.Year FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID = T2.Market_ID WHERE T2.Country = 'Japan' ORDER BY T1.Year DESC, T1.estimation_id NULLS LAST, T2.market_id NULLS LAST;

/*
Prediction Result:
(1101,)
(1093,)
(1085,)
*/