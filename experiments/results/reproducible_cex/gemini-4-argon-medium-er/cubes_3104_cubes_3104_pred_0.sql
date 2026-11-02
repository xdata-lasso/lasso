-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (1, 'A', 1);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (2, 'B', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM market ORDER BY country, market.market_id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Country FROM market ORDER BY Number_cities DESC, market.market_id NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
*/