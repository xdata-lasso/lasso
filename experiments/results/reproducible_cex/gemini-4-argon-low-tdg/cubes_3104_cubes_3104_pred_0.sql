-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (3, 'USA', 100);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (1, 'Canada', 50);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (2, 'UK', 75);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (4, 'USA', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM market ORDER BY country, market.market_id NULLS LAST;

/*
Gold Result:
('Canada',)
('UK',)
('USA',)
('USA',)
*/

-- Prediction Query
SELECT Country FROM market ORDER BY Number_cities DESC, market.market_id NULLS LAST;

/*
Prediction Result:
('USA',)
('UK',)
('Canada',)
('USA',)
*/