-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'Zeta Film', 'Studio Alpha', 'Aaron', 50000000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (2, 'Beta Film', 'Studio Beta', 'Morris', 30000000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (3, 'Alpha Film', 'Studio Gamma', 'Zachary', 10000000);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (1, 'USA', 100);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (1, 1, 1, 1000.0, 2000.0, 'Type A', 2020);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (2, 1, 2, 1500.0, 2500.0, 'Type B', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT studio FROM (SELECT * FROM (SELECT * FROM (SELECT film_id, title, studio, director, gross_in_dollar, COUNT(*) OVER () AS n FROM film) ORDER BY director DESC) LIMIT 1);

/*
Gold Result:
('Studio Gamma',)
*/

-- Prediction Query
SELECT Studio FROM film GROUP BY Studio ORDER BY COUNT(*) DESC, Studio NULLS LAST LIMIT 1;

/*
Prediction Result:
('Studio Alpha',)
*/