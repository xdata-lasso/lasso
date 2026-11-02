-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO market (market_id, country, number_cities) VALUES (2, NULL, 2);
INSERT INTO film (film_id, title, studio, director, gross_in_dollar) VALUES (0, 'default2', 'default2', 'default2', 1);
INSERT INTO film_market_estimation (estimation_id, market_id, film_id, low_estimate, high_estimate, type, year) VALUES (0, NULL, NULL, 2.0, 2.0, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM film AS LHS WHERE NOT EXISTS(SELECT 1 FROM film_market_estimation AS RHS WHERE (LHS.film_id = RHS.film_id))) ORDER BY title;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT Title FROM film WHERE NOT Film_ID IN (SELECT Film_ID FROM film_market_estimation);

/*
Prediction Result:
*/