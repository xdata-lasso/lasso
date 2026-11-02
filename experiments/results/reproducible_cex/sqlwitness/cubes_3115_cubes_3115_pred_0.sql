-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO film (film_id, title, studio, director, gross_in_dollar) VALUES (1, NULL, 'default2', 'default1', 0), (0, NULL, NULL, NULL, 0), (2, 'default1', 'default1', 'default1', NULL), (3, 'default2', 'default1', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM film ORDER BY director, film.film_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT Director FROM film;

/*
Prediction Result:
(None,)
('default1',)
*/