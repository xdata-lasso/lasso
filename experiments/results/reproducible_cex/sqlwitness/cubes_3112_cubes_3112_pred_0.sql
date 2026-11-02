-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO film (film_id, title, studio, director, gross_in_dollar) VALUES (0, 'Nicholas Meyer', 'default1', 'Walter Hill', NULL), (1, NULL, 'Nicholas Meyer', 'default2', NULL), (2, 'Walter Hill', 'Nicholas Meyer', NULL, 1), (3, 'default2', 'Walter Hill', 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "studio" FROM "film" WHERE ("director" <> 'Nicholas Meyer' AND "director" = 'Walter Hill') ORDER BY studio, film.film_id NULLS LAST;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT Studio FROM film WHERE Director = 'Nicholas Meyer' INTERSECT SELECT Studio FROM film WHERE Director = 'Walter Hill';

/*
Prediction Result:
*/