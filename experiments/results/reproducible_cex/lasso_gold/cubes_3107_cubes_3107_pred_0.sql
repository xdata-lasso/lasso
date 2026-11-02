-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1018, 'Sports administrator', 'begin', 'performance', 1019);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1026, 'Air traffic controller', 'better', 'discover', 1027);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1020, 'Jamaica', 1021);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1028, 'Djibouti', 1029);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1022, 1020, 1018, 1024.5, 1024.5, 'almost', 1025);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1030, 1028, 1026, 1023.5, 1025.5, 'mouth', 1026);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT low_estimate, high_estimate FROM film_market_estimation ORDER BY low_estimate, film_market_estimation.estimation_id NULLS LAST;

/*
Gold Result:
(1023.5, 1025.5)
(1024.5, 1024.5)
*/

-- Prediction Query
SELECT Low_Estimate, High_Estimate FROM film_market_estimation;

/*
Prediction Result:
(1024.5, 1024.5)
(1023.5, 1025.5)
*/