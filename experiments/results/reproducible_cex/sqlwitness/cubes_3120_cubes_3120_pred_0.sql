-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO film (film_id, title, studio, director, gross_in_dollar) VALUES (2, NULL, NULL, 'default2', NULL), (0, 'default1', 'default1', 'default2', 1), (1, 'default1', 'default2', NULL, NULL), (3, 'default2', NULL, 'default2', 0), (4, NULL, 'default2', NULL, 1), (5, 'default1', 'default1', 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT studio FROM (SELECT * FROM (SELECT * FROM (SELECT film_id, title, studio, director, gross_in_dollar, COUNT(*) OVER () AS n FROM film) ORDER BY director DESC) LIMIT 1);

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT Studio FROM film GROUP BY Studio ORDER BY COUNT(*) DESC, Studio NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/